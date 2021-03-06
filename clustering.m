function [resW, resM, resMW, resMWD, resMD] = clustering(cn, clusters)
[k n m] = size(cn);

W = zeros(k,n-1,m);
M = zeros(k,n,m);


for t = 1 : k
    ct = reshape(cn(t, :, :), n, m);
    
    
    hx = hilbert(ct);
    
    hm = abs(hx);
    %hm = hm / norm(hm);
    hx = atan((imag(hx)./real(hx)));
   
    hw = diff(hx);
    %hw = hw / norm(hw);
    
    M(t, :, :) = M(t, :, :) + reshape(hm, 1, n, m);
    W(t, :, :) = W(t, :, :) + reshape(hw, 1, n-1, m);
end;

Mx = zeros(n*m, k);
for t = 1 : k
    for l = 1 : n
        for q = 1 : m
            Mx(l + q*n, t) = M(t,l,q);
        end;
    end;
end;

Wx = zeros((n-1)*m, k);
MWx = zeros((n-1)*m, 2*k);
for t = 1 : k
    for l = 1 : n-1
        for q = 1 : m
            Wx(l + q*(n-1), t) = W(t,l,q);
            MWx(l + q*(n-1), t) = W(t,l,q);
            MWx(l + q*(n-1), k + t) = M(t,l,q);
        end;
    end;
end;

Mm = kmeans(Mx, clusters);
Wm = kmeans(Wx, clusters);
MWm = kmeans(MWx, clusters);

resM = zeros(n,m);
resW = zeros(n-1,m);
resMW = zeros(n-1,m);

for l = 1 : n
    for q = 1 : m
        resM(l, q) = Mm(l + q*n,1);
    end;
end;

for l = 1 : n-1
    for q = 1 : m
        resW(l, q) = Wm(l + q*(n-1),1);
        resMW(l, q) = MWm(l + q*(n-1),1);
    end;
end;



resMWD = resMW;
resMD = resM;
for n = 1:20
    resMWD = mdilatation(resMWD);
    resMD = mdilatation(resMD);
end;






