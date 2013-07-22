source = 'ireland';
approximation = 'rbf';
[cn,r] = HHT(imread(strcat(source,'.png')),approximation);
[k n m] = size(cn);
for t = 1 : k
    ct = reshape(cn(t, :, :), n, m);
    Image = mat2gray(ct);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d.bmp'), t);
    imwrite(Image,name);
end;
Image = mat2gray(r);
name = sprintf(strcat('data/',source,'_',approximation,'_trend.bmp'));
imwrite(Image,name);