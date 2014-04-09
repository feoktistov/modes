image = imread('textures/6.jpg');
if(length(size(image)) == 3)
    image = sum(image,3);
end;

[w,h] = size(image);
Image = mat2gray(image);

cl = 5;

cn = reshape(Image,1,w,h);
[resW, resM, resMW, resMWD, resMD] = clustering(cn, cl);

[cnm, r] = HHT(image,'rbf');

[HHTresW, HHTresM, HHTresMW, HHTresMWD, HHTresMD] = clustering(cnm, cl);