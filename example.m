maxSize = 100;
source = 'ireland';
approximation = 'rbf';
extension = '.png';
image = imread(strcat(source,extension));
if(length(size(image)) == 3)
    image = sum(image,3);
end;


[w,h] = size(image);
w = min(w,maxSize);
h = min(h,maxSize);
image = image(1:w,1:h);

Image = mat2gray(image);
name = strcat('data/',source,'.bmp');
imwrite(Image,name);

[cn,hn,r] = HHT(image,approximation);
[k n m] = size(cn);
for t = 1 : k
    ct = reshape(cn(t, :, :), n, m);
    Image = mat2gray(ct);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d.bmp'), t);
    imwrite(Image,name);
    
    ht = reshape(hn(t, :, :), n, m);
    Image = mat2gray(ht);
    name = sprintf(strcat('data/',source,'_',approximation,'_mode_%d_hilbert.bmp'), t);
    imwrite(Image,name);
end;
Image = mat2gray(r);
name = sprintf(strcat('data/',source,'_',approximation,'_trend.bmp'));
imwrite(Image,name);