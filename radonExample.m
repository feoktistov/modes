image = imread('radon.bmp');
if(length(size(image)) == 3)
    image = sum(image,3);
end;
Image = mat2gray(image);
name = strcat('data/','radon','.bmp');
imwrite(Image,name);

fImage = fft2(Image);
F = fImage.*conj(fImage);
theta = 0:180;
[R,xp] = radon(F,theta);

iR = iradon(R,theta);