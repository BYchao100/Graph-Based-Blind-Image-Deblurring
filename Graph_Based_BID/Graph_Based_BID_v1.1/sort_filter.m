function [ Cf_f ] = sort_filter( Cf,level,f_n,ratio )

% sort parameters
% Written by Yuanchao Bai.

[h,w]=size(Cf{level}{1,1});
num=h*w;

v_cf=zeros(num*f_n*f_n,1);
n=1;
for k=1:f_n
    for t=1:f_n
        v_cf(n:n+num-1)=reshape(Cf{level}{k,t},num,1);
        n=n+num;
    end
end
[~,index]=sort(abs(v_cf));
n=floor(num*f_n*f_n*(1-ratio));
v_cf(index(1:n))=0;
n=1;
for k=1:f_n
    for t=1:f_n
        Cf{level}{k,t}=reshape(v_cf(n:n+num-1),[h,w]);
        n=n+num;
    end
end 
Cf_f=Cf;
end

