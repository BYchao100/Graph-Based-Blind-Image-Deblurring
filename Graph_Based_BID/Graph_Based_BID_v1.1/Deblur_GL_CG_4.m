function [ x ] = Deblur_GL_CG_4( Y_b,k,W,we,max_iter )
% Restore skeleton image
% Written by Yuanchao Bai

d1=[1,-1,0];
d1_c=[0,-1,1];
d2=d1';
d2_c=d1_c';
d3=[0,-1,1];
d3_c=[1,-1,0];
d4=d3';
d4_c=d3_c';

Y_b_padding=Y_b;
[h_p,w_p]=size(Y_b_padding);
x=Y_b_padding;
mask=ones(h_p,w_p);

[vertex,neighbours_num]=size(W);
if vertex~=h_p*w_p || neighbours_num~=4
    error('Weights matrix W is not correct, please check.');
end
    
b=imfilter(x.*mask,rot90(k,2),'replicate','conv');

if (max(size(k)<25))
    Ax=imfilter(imfilter(x,k,'replicate','conv').*mask,rot90(k,2),'replicate','conv');
else
    Ax=fftconv(fftconv(x,k,'same').*mask,rot90(k,2),'same');
end

w1=reshape(W(:,1),h_p,w_p);
w2=reshape(W(:,2),h_p,w_p);
w3=reshape(W(:,3),h_p,w_p);
w4=reshape(W(:,4),h_p,w_p);

Ax=Ax+we*imfilter(w1.*imfilter(x,d1,'replicate','conv'),d1_c,'replicate','conv');
Ax=Ax+we*imfilter(w2.*imfilter(x,d2,'replicate','conv'),d2_c,'replicate','conv');
Ax=Ax+we*imfilter(w3.*imfilter(x,d3,'replicate','conv'),d3_c,'replicate','conv');
Ax=Ax+we*imfilter(w4.*imfilter(x,d4,'replicate','conv'),d4_c,'replicate','conv');

r = b - Ax;

for i=1:max_iter
    
     rho = (r(:)'*r(:));

     if ( i > 1 ),                       % direction vector
        beta = rho / rho_1;
        p = r + beta*p;
     else
        p = r;
     end
    
     if (max(size(k)<25))
        Ap=imfilter(imfilter(p,k,'replicate','conv').*mask,rot90(k,2),'replicate','conv');
     else
        Ap=fftconv(fftconv(p,k,'same').*mask,rot90(k,2),'same');
     end

    Ap=Ap+we*imfilter(w1.*imfilter(p,d1,'replicate','conv'),d1_c,'replicate','conv');
    Ap=Ap+we*imfilter(w2.*imfilter(p,d2,'replicate','conv'),d2_c,'replicate','conv');
    Ap=Ap+we*imfilter(w3.*imfilter(p,d3,'replicate','conv'),d3_c,'replicate','conv');
    Ap=Ap+we*imfilter(w4.*imfilter(p,d4,'replicate','conv'),d4_c,'replicate','conv');


     q = Ap;
     alpha = rho / (p(:)'*q(:) );
     x = x + alpha * p;                    % update approximation vector

     r = r - alpha*q;                      % compute residual

     rho_1 = rho;
    
     x(x>1)=1;
     x(x<0)=0;
    
end

end




