function [ I2,border ] = Copy_Enlarge_h( I,H_size )
% Symmetric padding image
% Written by Yuanchao Bai

s_h=H_size(1);
s_w=H_size(2);

if mod(s_h,2)==0
    s_h=s_h+1;
end
if mod(s_w,2)==0
    s_w=s_w+1;
end
border=[s_h-1,s_w-1];

[h,w]=size(I);


I2=[ I(:,1)*ones(1,border(2)) I I(:,w)*ones(1,border(2)) ];
I2=[ ones(border(1),1)*I2(1,:);I2;ones(border(1),1)*I2(h,:) ];

end

