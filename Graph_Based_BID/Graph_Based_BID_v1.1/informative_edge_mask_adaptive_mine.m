function [ M ] = informative_edge_mask_adaptive_mine( Y_s,t_s,t_r,h )
% Find informative edge and generate mask
% Written by Yuanchao Bai 

Dx=rot90([0,-1,1],2);
Dy=Dx';

%% t_s
Mx=imfilter(Y_s,Dx,'conv','replicate');
My=imfilter(Y_s,Dy,'conv','replicate');
M=sqrt(Mx.^2+My.^2);

[M3,~]=adaptive_threshold(M,t_s,100);

%% t_r
k_tmp=ones(h);
Mx2=imfilter(Mx,k_tmp,'replicate');
My2=imfilter(My,k_tmp,'replicate');
M4=sqrt(Mx2.^2+My2.^2);

M5=imfilter(M,k_tmp,'replicate');

M4=M4./(M5+0.5);
[M4,~]=adaptive_threshold(M4,t_r,100);

M=M3.*M4;

end

function [M_threshold,r]=adaptive_threshold(M,ratio,max_iter)

n=numel(M);
lower_bound=0;
upper_bound=max(M(:));
threshold=upper_bound/2;
for i=1:max_iter
    M_t=sum(sum(M>threshold));
    r=M_t/n;
    if r>ratio*0.9 && r<ratio*1.1
        break;
    elseif r<=ratio*0.9
        upper_bound=threshold;
        threshold=(lower_bound+upper_bound)/2;
    else 
        lower_bound=threshold;
        threshold=(lower_bound+upper_bound)/2;
    end
end
M_threshold=M;
M_threshold(M>threshold)=1;
M_threshold(M<=threshold)=0;
end



