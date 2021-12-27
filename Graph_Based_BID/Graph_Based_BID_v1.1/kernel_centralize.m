function [ k_c ] = kernel_centralize( k,threshold )
% Centralize restored kernel (trial)
% Written by Yuanchao Bai

[h,w]=size(k);
threshold=max(k(:))*threshold;

for i=1:h
    if sum(k(i,:)) > threshold
        h_begin=i;
        break;
    end
end
for i=h:-1:1
    if sum(k(i,:)) > threshold
        h_end=i;
        break;
    end
end

for i=1:w
    if sum(k(:,i)) > threshold
        w_begin=i;
        break;
    end
end

for i=w:-1:1
    if sum(k(:,i)) > threshold
        w_end=i;
        break;
    end
end

h_center=floor(h_begin+(h_end-h_begin)/2);
w_center=floor(w_begin+(w_end-w_begin)/2);

kh_center=ceil(h/2);
kw_center=ceil(w/2);

dh=kh_center-h_center;
dw=kw_center-w_center;

k_c = shift_kernel(k,[dh,dw]);
k_c=k_c/sum(k_c(:));
end

function [k_s] = shift_kernel(k,hw)

[h,w]=size(k);

if hw(1)>=0
    k_tmp=[zeros(hw(1),w);k(1:end-hw(1),:)];
else
    k_tmp=[k(1-hw(1):end,:);zeros(-hw(1),w)];
end

if hw(2)>=0
    k_s=[zeros(h,hw(2)) k_tmp(:,1:end-hw(2))];    
else
    k_s=[k_tmp(:,1-hw(2):end) zeros(h,-hw(2))];      
end

end



