function r = HilbertByAngle(data, angle)
F = fft2(data);
[w,h] = size(F);
imagesc(imag(F));
for i = 1 : w
    for j = 1 : h
        Fa(i,j) = 0;
        t = cos(angle)*i + sin(angle)*j;
        if(t == 0)
            Fa(i,j) = F(i,j);
        else
            if(t > 0)
              Fa(i,j) = 2*F(i,j);  
            end;
        end;
    end;
end;
imagesc(imag(Fa));
fa = ifft2(Fa);
imagesc(real(fa));
r = imag(fa);