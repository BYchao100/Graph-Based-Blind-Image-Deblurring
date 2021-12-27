function [ W ] = weights_computation( x,sigma,nei_num,type )
% weight computation
% Written by Yuanchao Bai

[h,w]=size(x);
if nei_num==4 && type==1
    W=zeros(h*w,4);
    d1=[1,-1,0];
    d2=d1';
    d3=[0,-1,1];
    d4=d3';
    W(:,1)=reshape(imfilter(x,d1,'conv','replicate'),h*w,1);
    W(:,1)=exp(-W(:,1).^2/sigma^2);
    
    W(:,2)=reshape(imfilter(x,d2,'conv','replicate'),h*w,1);
    W(:,2)=exp(-W(:,2).^2/sigma^2);
    
    W(:,3)=reshape(imfilter(x,d3,'conv','replicate'),h*w,1);
    W(:,3)=exp(-W(:,3).^2/sigma^2);
    
    W(:,4)=reshape(imfilter(x,d4,'conv','replicate'),h*w,1);
    W(:,4)=exp(-W(:,4).^2/sigma^2);

elseif nei_num==4 && type==2
    W=zeros(h*w,4);
    d1=[1,-1,0];
    d2=d1';
    d3=[0,-1,1];
    d4=d3';
    W(:,1)=reshape(imfilter(x,d1,'conv','replicate'),h*w,1);
    W(:,1)=weight_function_l1(W(:,1));
    
    W(:,2)=reshape(imfilter(x,d2,'conv','replicate'),h*w,1);
    W(:,2)=weight_function_l1(W(:,2));
    
    W(:,3)=reshape(imfilter(x,d3,'conv','replicate'),h*w,1);
    W(:,3)=weight_function_l1(W(:,3));
    
    W(:,4)=reshape(imfilter(x,d4,'conv','replicate'),h*w,1);
    W(:,4)=weight_function_l1(W(:,4));  
else
    W=0;
end

end



