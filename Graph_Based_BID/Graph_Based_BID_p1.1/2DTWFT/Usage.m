clear
clc

addpath('./2D');

f=imread('k_flower5.png');
if numel(size(f))==2
    f=im2double(f);
else
    f=im2double(rgb2gray(f));
end

frame=1; % type of wavelet frame used: 0 is Haar; 1 is piecewise linear; 3 is piecewise cubic
Level=1; % level of decomposition, typically 1-4.
[D,R]=GenerateFrameletFilter(frame);
W  = @(x) FraDecMultiLevel2D(x,D,Level); % Frame decomposition
WT = @(x,ratio) FraRecMultiLevel2D_filter(x,R,Level,ratio); % Frame reconstruction

Cf=W(f); % wavelet frame transform. Cf is the wavelet frame coefficients.
f_reconstruction=WT(Cf,0.02); % inverse wavelet frame transform.

figure(1);kk=1;
for kn=1:length(D)-1
    for km=1:length(D)-1
        if kn==1 && km==1
            subplot(3,3,kk);imshow(Cf{1}{kn,km},[]);title('Low Frequency Approximation')
        end
        if kn>1 || km>1
            subplot(3,3,kk);imshow(Cf{1}{kn,km},[]);title(['Frame Coefficients of Band (' num2str(km) ', ' num2str(kn) ').'])
        end
        kk=kk+1;
    end
end
% figure(2);kk=1;
% for kn=1:length(D)-1
%     for km=1:length(D)-1
%         if kn==1 && km==1
%             subplot(3,3,kk);imshow(Cf{2}{kn,km},[]);title('Low Frequency Approximation')
%         end
%         if kn>1 || km>1
%             subplot(3,3,kk);imshow(Cf{2}{kn,km},[]);title(['Frame Coefficients of Band (' num2str(km) ', ' num2str(kn) ').'])
%         end
%         kk=kk+1;
%     end
% end
figure;
subplot(1,2,1);
imshow(f,[]);
subplot(1,2,2);
imshow(f_reconstruction,[]);

display(['Reconstruction error = ' num2str(norm(f-f_reconstruction,'fro')) '. (Perfect Reconstruction)'])