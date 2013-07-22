x = 2*pi*linspace(-1,1);
y = cos(x) - 0.5 + 0.5*rand(size(x)); 

[cn,r] = HHT(y, 'bla', 0.1);
% [xmax,imax,xmin,imin] = extrema(y);
% 
% [t,l]= size(y);
% xi = 1:l;
% 
% max = interp1(imax,xmax,xi, 'spline');
% min = interp1(imin,xmin,xi, 'spline');
% h = (max + min)/2;
% 
% c = y - h;
% 
% plot(xi,y,xi,c);