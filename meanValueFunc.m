function [h,maxCount,minCount] = meanValueFunc(array)

[t,l]= size(array);

xi = 1:l;
[xmax,imax,xmin,imin] = extrema(array);

[t,maxCount] = size(xmax);
[t,minCount] = size(xmin);
if( maxCount > 1 && minCount > 1)
    max = interp1(imax,xmax,xi, 'spline');
    min = interp1(imin,xmin,xi, 'spline');
    h = (max + min)/2;
else
    h = array;
end;