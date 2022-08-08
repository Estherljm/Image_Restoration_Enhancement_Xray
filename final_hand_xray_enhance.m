clc; 
clear all;
close all;

% Read image 
cv_img = imread('h5.png');

%First contrast Stretch 
rmax = (double(max(cv_img(:)))/100) *99;
rmin = (double(max(cv_img(:)))/100) *1;
L = 255;
d = rmax - rmin;
mf = L/d;
s = mf.*abs(cv_img - rmin);

% % Second contrast stretch
rmax2 = (double(max(s(:)))/100) *68;
rmin2 = (double(max(s(:)))/100) *42;
L = 255;
d = rmax2 - rmin2;
mf = L/d;
s2 = mf.*abs(s - rmin);

% Gamma
image_double = im2double(s2);
[row, col] = size(image_double);
cc = 2.1;%constant
ep = 5; %gamma value

for i = 1:row
    for j = 1:col 
        img_out(i,j) = cc*power(image_double(i,j),ep);
    end 
end

%Unsharp masking 
blurf = fspecial('average',[5,5]);
blur_img = imfilter(img_out,blurf);
blur_img2 = 1.5*(img_out - blur_img);
cv_unsharp = img_out+ blur_img2;

% full process
% subplot(1,5,1),imshow(cv_img),title('Original');
% subplot(1,5,2),imshow(s),title('Contrast Stretching 1');
% subplot(1,5,3),imshow(s2),title('Contrast Stretching 2');
% subplot(1,5,4),imshow(img_out),title('Gamma Correction');
% subplot(1,5,5),imshow(cv_unsharp),title('Unsharp Mask');

% contrast stretch 
% subplot(1,3,1),imshow(cv_img),title('Original');
% subplot(1,3,2),imshow(s),title('Contrast Stretching 1');
% subplot(1,3,3),imshow(s2),title('Contrast Stretching 2');

%Gamma correction 
%imshow(img_out);

%Sharpen 
% subplot(1,4,1), imshow(img_out),title('Gamma');
% subplot(1,4,2), imshow(blur_img), title('Blurred');
% subplot(1,4,3), imshow(blur_img2), title('2*Gamma - Blurred');
% subplot(1,4,4), imshow(cv_unsharp),title('Sharpen Image');

%montage of ori vs sharpen 
montage({cv_img,cv_unsharp});

%ori , gamma, sharp
% subplot(1,3,1),imshow(cv_img),title('Original');
% subplot(1,3,2),imshow(img_out),title('Gamma ');
% subplot(1,3,3),imshow(cv_unsharp),title('Sharpen');
