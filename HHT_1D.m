function [cn, r] = HHT_1D(array,method,threshold)

if nargin < 3
    use_S_Method = true;
else
    use_S_Method = false;
end

x = double(array);
maxSum = sum(abs(x(:)));
curSum = maxSum;
index = 1;
fprintf('maxSum  %f\n',maxSum);
while( (curSum > maxSum*0.1) || index > 10)
    if(use_S_Method)
        c = S_calc(x, method);
    else
        c = SD_calc(x,threshold, method);
    end;
    r = x - c;
    x = r;
    cn(index,:) = c;
    curSum = sum(abs(x(:)));
    fprintf('curSum  %f\n',curSum);
    index = index + 1;
end;

l = size(array);
res = reshape(sum(cn),l) + r - double(image);
fprintf('res  %f\n',sum(res(:)));


function h = SD_calc(h1,threshold, method)
fprintf('Use SD criteria\n');
maxInnerIterations = 100;
minExtremumCount = 3;
SD = threshold*2;
iterations = 0;
fprintf('Start calculate h1\n');
while(SD > threshold && iterations < maxInnerIterations)
    [m, maxCount, minCount] = meanValueFunc(h1,method);
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
minExtremumCount = 4;
iterations = 0;
maxCount = 0;
minCount = 0;
S_crit = true;
while(  S_crit && iterations < maxInnerIterations)
    [m, curMaxCount, curMinCount] = meanValueFunc(h1,method);
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

