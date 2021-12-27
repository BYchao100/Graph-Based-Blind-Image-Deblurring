function cI=fftconv(I,filt,method)

% Convolution with a large kernel accelerated by FFT

[k1,k2]=size(filt);

[I,p_size]=G_padding(I,filt,1);
[n,m]=size(I);

if strcmp(method,'same')
  tI=zeros(n+k1-1,m+k2-1);
  tI(1:n,1:m)=I;
  I=tI;
end
[bn,bm]=size(I);
fI=fft2(I);
ff=fft2(filt,bn,bm);
fI=fI.*ff;

cI=real(ifft2(fI));

hk1d=floor(k1/2);
hk1u=k1-hk1d-1;
hk2d=floor(k2/2);
hk2u=k2-hk2d-1;
if strcmp(method,'same')
  cI=cI(hk1d+1:end-hk1u,hk2d+1:end-hk2u);
  cI=cI(p_size+1:end-p_size,p_size+1:end-p_size);
end

if strcmp(method,'valid')
  cI=cI(hk1d+hk1u+1:end,hk2d+hk2u+1:end);
end
