maxSize = 250; 
for s = 8:14
source = int2str(s); 
approximation = 'rbf'; 
extension = '.jpg';
image = imread(strcat('images/',source,extension));
if(length(size(image)) == 3)
    image = sum(image,3);
end;


[w,h] = size(image);
w = min(w,maxSize);
h = min(h,maxSize);
image = image(1:w,1:h);

mkdir('data', source);

Image = mat2gray(image);
name = strcat('data/',source, '/',source,'.bmp');
imwrite(Image,name);



[cn, r] = HHT(image,approximation);
[k n m] = size(cn);

res = r;



for t = 1 : k
    ct = reshape(cn(t, :, :), n, m);
    Image = mat2gray(ct);
    name = sprintf(strcat('data/', source, '/',source,'_',approximation,'_mode_%d.bmp'), t);
    imwrite(Image,name);
    
    res = res + ct;
    
    hx = hilbert(ct);
    hy = imrotate(hilbert(imrotate(ct,90)),-90);
    
    hx = atan((imag(hx)./real(hx)));
    hy = atan((imag(hy)./real(hy)));

     Image = mat2gray(hx);
     name = sprintf(strcat('data/',source, '/', source,'_',approximation,'_mode_%d_h_x.bmp'), t);
     imwrite(Image,name);
     
     Image = mat2gray(hy);
     name = sprintf(strcat('data/',source, '/' , source,'_',approximation,'_mode_%d_h_y.bmp'), t);
     imwrite(Image,name);
    
    
    hwx = diff(hx);
    hwy = diff(hy);
    hw = diff(hx.*hy);
    
     Image = mat2gray(hw);
     name = sprintf(strcat('data/',source, '/',source,'_',approximation,'_mode_%d_freaquency.bmp'), t);
     imwrite(Image,name);
     
     Image = mat2gray(hwx);
     name = sprintf(strcat('data/',source, '/',source,'_',approximation,'_mode_%d_freaquency_x.bmp'), t);
     imwrite(Image,name);
     
     Image = mat2gray(hwy);
     name = sprintf(strcat('data/',source, '/',source,'_',approximation,'_mode_%d_freaquency_y.bmp'), t);
     imwrite(Image,name);
    
end;
Image = mat2gray(r);
name = sprintf(strcat('data/', source, '/', source,'_',approximation,'_trend.bmp'));
imwrite(Image,name);

Image = mat2gray(res);
name = sprintf(strcat('data/',  source, '/', source,'_',approximation,'_after.bmp'));
imwrite(Image,name);


cl = 5;

[resW, resM, resMW, resWD, resMD] = clustering(cn, cl);
    
    Image = mat2gray(resW);
    name = strcat('data/',source, '/', source,'_resW.bmp');
    imwrite(Image,name);
    
    Image = mat2gray(resM);
    name = strcat('data/',source, '/', source,'_resM.bmp');
    imwrite(Image,name);

    Image = mat2gray(resMW);
    name = strcat('data/',source, '/', source,'_resMW.bmp');
    imwrite(Image,name);
    
    
    Image = mat2gray(resWD);
    name = strcat('data/',source, '/', source,'_resWD.bmp');
    imwrite(Image,name);

    Image = mat2gray(resMD);
    name = strcat('data/',source, '/', source,'_resMD.bmp');
    imwrite(Image,name);
    
end;