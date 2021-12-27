function [ x ] = TV_denoising( I,weight,max_it )
% Denoising with TV Prior implemented in the frequency domain
% I: input image
% weight: parameters of regularizers
% max_it: maximum iteration
% x: denoised image

% Written by Yuanchao Bai

h=[0 0 0;0 1 0;0 0 0];
h(h==0)=1e-10;
h=h/sum(h(:));

mu=weight(1);
gamma=weight(2);

[s_h,s_w]=size(h);

[I_sym,border]=Copy_Enlarge_h(I,[s_h,s_w]*3);
I_sym=edgetaper(I_sym,h);
[I_h,I_w]=size(I_sym);

B=h;
Bt=rot90(h,2);
BtB=conv2(Bt,B);
S_h=2*s_h-1;
S_w=2*s_w-1;

vtv_w=[0,-1,2,-1,0];
vtv_h=vtv_w';

VtV_w=zeros(S_h,S_w);
VtV_w(s_h,s_w-2:s_w+2)=vtv_w;

VtV_h=zeros(S_h,S_w);
VtV_h(s_h-2:s_h+2,s_w)=vtv_h;

Bt_tmp=zeros(S_h,S_w);
Bt_tmp(s_h-(s_h-1)/2:s_h+(s_h-1)/2,s_w-(s_w-1)/2:s_w+(s_w-1)/2)=Bt;

vt_w=[0,-1,1];
vt_h=vt_w';

Vt_w=zeros(S_h,S_w);
Vt_w(s_h,s_w-1:s_w+1)=vt_w;

Vt_h=zeros(S_h,S_w);
Vt_h(s_h-1:s_h+1,s_w)=vt_h;

z_h=zeros(I_h,I_w);
z_w=zeros(I_h,I_w);

y_h=zeros(I_h,I_w);
y_w=zeros(I_h,I_w);

v_w=[1,-1,0];
v_h=v_w';

%% FFT
Ftmp=zeros(S_h+I_h-1,S_w+I_w-1);
Ftmp(1:S_h,1:S_w)=BtB;
FBtB=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:S_h,1:S_w)=Bt_tmp;
FBt=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:S_h,1:S_w)=VtV_w;
FVtV_w=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:S_h,1:S_w)=VtV_h;
FVtV_h=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:I_h,1:I_w)=I_sym;
Fb=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:S_h,1:S_w)=Vt_w;
FVt_w=fft2(Ftmp);

Ftmp=Ftmp*0;
Ftmp(1:S_h,1:S_w)=Vt_h;
FVt_h=fft2(Ftmp);

%% Solver
for i=1:max_it
    Ftmp=Ftmp*0;
    Ftmp(1:I_h,1:I_w)=z_h;
    Fz_h=fft2(Ftmp);

    Ftmp=Ftmp*0;
    Ftmp(1:I_h,1:I_w)=z_w;
    Fz_w=fft2(Ftmp);
    
    Ftmp=Ftmp*0;
    Ftmp(1:I_h,1:I_w)=y_h;
    Fy_h=fft2(Ftmp);

    Ftmp=Ftmp*0;
    Ftmp(1:I_h,1:I_w)=y_w;
    Fy_w=fft2(Ftmp);   
    x=ifft2((Fb.*FBt+gamma*FVt_h.*Fz_h+gamma*FVt_w.*Fz_w+gamma*FVt_h.*Fy_h+gamma*FVt_w.*Fy_w)...
        ./(FBtB+gamma*FVtV_w+gamma*FVtV_h));
    x=x(1:I_h,1:I_w);
    
    Vx_h=imfilter(x,v_h,'conv','replicate');
    Vx_h(end,:)=0;
    Vx_w=imfilter(x,v_w,'conv','replicate');  
    Vx_w(:,end)=0;
    
    z_h=z_h*0;
    z_h(Vx_h-y_h>mu/(gamma)) = Vx_h(Vx_h-y_h>mu/(gamma))...
        -y_h(Vx_h-y_h>mu/(gamma)) - mu/(gamma);
    z_h(Vx_h-y_h<-mu/(gamma))=Vx_h(Vx_h-y_h<-mu/(gamma))...
        -y_h(Vx_h-y_h<-mu/(gamma)) + mu/(gamma);   
 
    z_w=z_w*0;
    z_w(Vx_w-y_w>mu/(gamma)) = Vx_w(Vx_w-y_w>mu/(gamma))...
        -y_w(Vx_w-y_w>mu/(gamma)) - mu/(gamma);
    z_w(Vx_w-y_w<-mu/(gamma)) = Vx_w(Vx_w-y_w<-mu/(gamma))...
        -y_w(Vx_w-y_w<-mu/(gamma)) + mu/(gamma); 
    
    y_h=y_h-(Vx_h-z_h);
    y_w=y_w-(Vx_w-z_w);
end

x=x(border(1)+1:I_h-border(1),border(2)+1:I_w-border(2));
end





