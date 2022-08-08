clc; 
%clear all;
close all;

% Read image 
cv_img = imread('v16.jpeg');
cv_img_ori = cv_img;

% Add noise 
cv_img = imnoise(cv_img, 'salt & pepper',0.2);
cv_imgd = double(cv_img);

% Proposed Algorithm  
wsize = 3; %window size 
num = 1; %constant 
cycle = 2; %cycle 

[r,c] = size(cv_imgd);
cv_med = zeros(r,c);

while num <= cycle
    for i = ceil(wsize/2) : r- ceil(wsize/2)
        for j = ceil(wsize/2): c- ceil(wsize/2)
            n = [cv_imgd(i-1,j-1),cv_imgd(i-1,j), cv_imgd(i-1,j+1), cv_imgd(i,j-1), cv_imgd(i,j), cv_imgd(i,j+1), cv_imgd(i+1,j-1), cv_imgd(i+1,j), cv_imgd(i+1,j+1)];
            n_med = median(n);
            n_min = min(n);
            n_max = max(n);
            if ((cv_imgd(i,j)> n_min && cv_imgd(i,j)< n_max)&&(n_min > 0 && n_max <255))
                cv_med(i,j) = cv_imgd(i,j);
            else
                cv_med(i,j) = median(n);
            end
            
        end
    end
    cv_imgd = cv_med;
    num = num +1;
end


cv_med = uint8(cv_med);

montage({cv_img,cv_med}), title('Noisy -> Filtered by Proposed Algorithm');