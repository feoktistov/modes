function [cn, r] = HHT(data,method,threshold)

if nargin < 2
    method = 'linear';
end;

if nargin < 3
    use_S_Method = true;
else
    use_S_Method = false;
end

[w,h] = size(data);
dim = 2;
if( w == 1)
    dim = 1;
end;
if( h == 1)
    data =reshape(data,1,w);
    dim = 1;
end;

fprintf('Dim  %d\n',dim);
x = double(data);
maxSum = sum(abs(x(:)));
curSum = maxSum;
index = 1;
fprintf('maxSum  %f\n',maxSum);
while( (curSum > maxSum*0.1) && index < 10)
    if(use_S_Method)
        c = S_calc(x, method);
    else
        c = SD_calc(x,threshold, method);
    end;
    r = x - c;
    x = r;
    if(dim == 2)
       cn(index,:,:) = c;
    else
       cn(index,:) = c;
    end;
    curSum = sum(abs(x(:)));
    fprintf('curSum  %f maxSum %f \n',curSum, maxSum);
    index = index + 1;
end;

if(index >= 10)
   fprintf('error: bad input data. To many modes\n'); 
   fprintf('curSum  %f maxSum %f \n',curSum, maxSum);
end;

if(dim == 2)
    [w,h] = size(data);
    if(index > 2)
        sum_cn = reshape(sum(cn),w,h);
    else 
        sum_cn = reshape(cn,w,h);  
    end;
    res = sum_cn + r - double(data);
else 
    res = sum(cn) + r - double(image);
end;
fprintf('res  %f\n',sum(res(:)));


function h = SD_calc(h1,threshold, method)
fprintf('Use SD criteria\n');
maxInnerIterations = 100;
dim = getDim(h1);
minExtremumCount = dim + 2;
SD = threshold*2;
iterations = 0;
fprintf('Start calculate h1\n');
while(SD > threshold && iterations < maxInnerIterations)
    if(dim == 2)
        [m, maxCount, minCount] = meanValueFunc2D(h1,method);
    else
        [m, maxCount, minCount] = meanValueFunc(h1);
    end;
    if(maxCount < minExtremumCount || minCount < minExtremumCount)
        break;
    end;
    m(isnan(m))=0;
    h2 = h1 - m;
    SD = SD_crit(h1,h2);
    h1 = h2;
    iterations = iterations + 1;
end;
if(iterations == maxInnerIterations)
    fprintf('Break because iterations exceeded limit %d!\n', maxInnerIterations);
    fprintf('SD final %f\n',SD);
else
    fprintf('Iterations %d.\n', iterations);
end;
fprintf('\n');
h = h1;


function r=SD_crit(h1, h2)
t1 = (h1-h2).^2;
t2 = h1.^2;
r=sum(t1(:))/sum(t2(:));



function h = S_calc(h1, method)
fprintf('Use S criteria\n');
maxInnerIterations = 100;
dim = getDim(h1);
minExtremumCount = dim + 2;
iterations = 0;
maxCount = 0;
minCount = 0;
S_crit = true;
while(  S_crit && iterations < maxInnerIterations)
    if(dim == 2)
        [m, curMaxCount, curMinCount] = meanValueFunc2D(h1,method);
    else
        [m, curMaxCount, curMinCount] = meanValueFunc(h1);
    end;
    if(curMaxCount < minExtremumCount || curMinCount < minExtremumCount)
        break;
    end;
    m(isnan(m))=0;
    h1 = h1 - m;
    S_crit = (maxCount ~= curMaxCount || minCount ~= curMinCount);
    maxCount = curMaxCount;
    minCount = curMinCount;
    iterations = iterations + 1;
end;
if(iterations == maxInnerIterations)
    fprintf('Break because iterations exceeded limit %d!\n', maxInnerIterations);
    fprintf('min %d max %d\n',minCount, maxCount);
else
    fprintf('Iterations %d.\n', iterations);
end;

h = h1;


function d = getDim(h)
[w,h] = size(h);
if( w == 1|| h == 1)
    d = 1;
else 
    d = 2;
end;

