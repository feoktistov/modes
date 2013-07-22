function [h,maxCount,minCount] = meanValueFunc2D(image, method)

if nargin < 2
    method = 'linear';
end

[w,h] = size(image);

x = 1:w;
y = 1:h;
[XI,YI] = meshgrid(x,y);

[max,imax,min,imin] = extrema2(image);

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


