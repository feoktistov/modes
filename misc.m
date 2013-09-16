% source = 'data/brain_rbf_mode_1';
% approximation = 'rbf';
% extension = '.bmp';
% image = imread(strcat(source,extension));
% if(length(size(image)) == 3)
%     image = sum(image,3);
% end;
% 
% res = double(image);
% 
% 
%  p1 = imag(hilbert(res));
%  p2 = imrotate(imag(hilbert(imrotate(res,90))),-90);
%  c = p2;
%  for n = 1:147
%     for m = 1:147
%         c(n,m) = p1(n,m)*p2(n,m);
%     end;
%  end;

[k n m] = size(cn);
for t = 1 : k
    ct = reshape(cn(t, :, :), n, m);
    Image = mat2gray(ct);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d.bmp'), t);
    imwrite(Image,name);
    
    ht = reshape(hn(t, :, :), n-1, m);
    Image = mat2gray(ht);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d_hilbert.bmp'), t);
    imwrite(Image,name);
    
    ht = reshape(hxn(t, :, :), n-1, m);
    Image = mat2gray(ht);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d_hilbert_x.bmp'), t);
    imwrite(Image,name);
    
    ht = reshape(hyn(t, :, :), n-1, m);
    Image = mat2gray(ht);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d_hilbert_y.bmp'), t);
    imwrite(Image,name);
    
end;