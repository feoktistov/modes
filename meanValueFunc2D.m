function [h,maxCount,minCount] = meanValueFunc2D(image, method)

if nargin < 2
    method = 'linear';
end

[w,h] = size(image);

x = 1:h;
y = 1:w;
[XI,YI] = meshgrid(x,y);

%[max,imax,min,imin] = getExtrema(image);
[max,imax,min,imin] = getExtremaByMorfologicalReconstruction(image);
%[max,imax,min,imin] = extrema2(image);

[maxCount, t] = size(imax);
[minCount, t] = size(imin);

if(maxCount > 3 && minCount > 3)
    if (strcmp(method,'rbf'))
        minZI = rbfinterp([XI(:)'; YI(:)'], rbfcreate([XI(imin)';YI(imin)'], min','RBFFunction', 'multiquadric', 'RBFConstant', 1));
        maxZI = rbfinterp([XI(:)'; YI(:)'], rbfcreate([XI(imax)';YI(imax)'], max','RBFFunction', 'multiquadric', 'RBFConstant', 1));
        minZI = reshape(minZI, size(XI));
        maxZI = reshape(maxZI, size(XI));
    else
        minZI = griddata(XI(imin),YI(imin),min,XI,YI,method);
        maxZI = griddata(XI(imax),YI(imax),max,XI,YI,method);
    end;
    h = (minZI + maxZI)/2;
else
    h = image;
end;

function [maxZ,maxi,minZ,mini] = getExtrema(image)
[w,h] = size(image);
z = double(image);
min = imregionalmin(image);
index = 1;
for n = 1 : w
   for m = 1 : h
       if(min(n,m) == 1)
           mini(index) = sub2ind(size(image), n, m);
           minZ(index) = z(n,m);
           index = index + 1;
       end;
   end; 
end;

mini = mini';
minZ = minZ';

max = imregionalmax(image);
index = 1;
for n = 1 : w
   for m = 1 : h
       if(max(n,m) == 1)
           maxi(index) = sub2ind(size(image), n, m);
           maxZ(index) = z(n,m);
           index = index + 1;
       end;
   end; 
end;

maxi = maxi';
maxZ = maxZ';



function [maxZ,maxi,minZ,mini] = getExtremaByMorfologicalReconstruction(image)
 
[w,h] = size(image);
z = double(image);

max = z - imreconstruct(z - 1,z);
min = -z - imreconstruct(-z - 1,-z);

index = 1;
for n = 1 : w
   for m = 1 : h
       if(min(n,m) == 1)
           mini(index) = sub2ind(size(image), n, m);
           minZ(index) = z(n,m);
           index = index + 1;
       end;
   end; 
end;

mini = mini';
minZ = minZ';

index = 1;
for n = 1 : w
   for m = 1 : h
       if(max(n,m) == 1)
           maxi(index) = sub2ind(size(image), n, m);
           maxZ(index) = z(n,m);
           index = index + 1;
       end;
   end; 
end;

maxi = maxi';
maxZ = maxZ';






























