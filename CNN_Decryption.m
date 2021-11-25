%% Decryption of CNL
% 27.11.2015
% S. Tunçer / Bilecik Þeyh Edebali University
clear all, 
close all, 
clc
H = imread('crypto_image.bmp'); % Pfinal
D = H;
load Pc.mat %Encrypted Pc
load maxy1k.mat
load miny1k.mat
load('Wdl.mat');
load('iWdl.mat');
load('a.mat'); Al = a;
load('b.mat'); Bdl = floor(b);
load('d.mat');
load('Wcl.mat');
% load decPc.mat
R = 2; % Number of iterations
r = R;
sz = size(H);
N = sz(1);
N0 = 160; % Complementary secret keys
pc1 = encryptPic;

xyz1 = fChua(N*N*R+N0);
xyz2 = fLorenz(N*N*R+N0);
xyz3 = fLu(N*N*R+N0);
x1 = xyz1(1,:)*279; y1 = xyz1(2,:)*1557; z1 = xyz1(3,:)*196;
x2 = xyz2(1,:)*5; y2 = xyz2(2,:)*4; z2 = xyz2(3,:);
x3 = xyz3(1,:)*3; y3 = xyz3(2,:)*2; z3 = xyz3(3,:);
% x1 = xyz1(1,:)*53; y1 = xyz1(2,:)*389; z1 = xyz1(3,:)*92;
% x2 = xyz2(1,:); y2 = xyz2(2,:); z2 = xyz2(3,:);
% x3 = xyz3(1,:)*0.62; y3 = xyz3(2,:)*0.72; z3 = xyz3(3,:)*0.68;
% x1 = xyz1(1,:)*27.9; y1 = xyz1(2,:)*155.7; z1 = xyz1(3,:)*19.6;
% x2 = xyz2(1,:)*.5; y2 = xyz2(2,:)*.4; z2 = xyz2(3,:);
% x3 = xyz3(1,:)*.3; y3 = xyz3(2,:)*.2; z3 = xyz3(3,:);
Wdl = zeros(3,3,N*N*R);
iWdl = zeros(3,3,N*N*R);
a = zeros(3,N*N*R);
b = zeros(3,N*N*R);
d = zeros(N*N*R,3);
Wcl = zeros(3,3,N*N*R);
iWcl = zeros(3,3,N*N*R);
w1 = zeros(N*N*R,1);
w2 = zeros(N*N*R,1);
% p = zeros(N*N*R,1);
% q = zeros(N*N*R,1);
Bcl = zeros(3,N*N*R);
H1 = zeros(3,N*N);
H2 = zeros(3,N*N);
H3 = zeros(3,N*N);
H31 = zeros(3,N*N);
H32 = zeros(3,N*N); 
H4 = zeros(3,N*N);
H5 = zeros(3,N*N);
H6 = zeros(3,N*N);
H7 = zeros(3,N*N);
H8 = zeros(3,N*N);
% Pc = y7k

while (r > 1)   
    [Wdl,a,b,d,Wcl,iWdl,Bcl] = EncryptionValues(x1,x2,x3,y1,y2,y3,z1,z2,z3,N,N0,r,R);
     Bdl = floor(b);   
     Al = a;
    % Inverse of Cat Map Function
    invPic = fInvCat(encryptPic,N); % NxNx3 matrix  (y6k)
    k=1;
    tic
    for i=1:N % Convert 3xN operation
        for j=1:N
            if k<=N*N
            H1(:,k) = invPic(i,j,:); % (y6k)
            k=k+1;
            end
        end
    end

    k=1; S = 256;
    % Inverse of Chaotic Tent Map
    for i=(r-1)*(N*N)+1:r*(N*N)
        if k<=N*N
            iWcl(:,:,i) = inv(Wcl(:,:,i));
            H2(:,k) = iWcl(:,:,i)*H1(:,k)/0.9922; % (y5k) %eq(16) g ve Bcl kullanýlmýyor
            H31(:,k) = floor(H2(:,k)); 
            H32(:,k) = mod(H2(:,k),floor(H2(:,k)));
            H3(:,k) = H31(:,k) + H32(:,k); % (y5k)
            for j=1:3 % Inverse of tent map
                aa = Al(j,i);   
                yy = H31(j,k); % (y5k)
%                 fprintf('Al:%f H31:%f\n',aa,yy);
                if (floor(aa*yy/S)-ceil(aa*yy/S)==-1 && floor(aa*yy/S)/aa>-(ceil((aa/S-1)*yy)/(S-aa))) || floor(aa*yy/S)-ceil(aa*yy/S)==0
%                 if floor(aa*yy/S)/aa>(S-ceil((aa/S-1)*yy+S))/(S-aa)
                    H4(j,k) = floor(aa*yy/S);                  
                elseif floor(aa*yy/S)-ceil(aa*yy/S)==-1 && floor(aa*yy/S)/aa<=-(ceil((aa/S-1)*yy)/(S-aa))
%                 elseif floor(aa*yy/S)/aa<=(S-ceil((aa/S-1)*yy+S))/(S-aa)
                    H4(j,k) = ceil((aa/S-1)*yy+S);      
                else
                    fprintf('UYARI --> H4:%f Al:%f  H31:%f i:%f j:%f k:%f\n',H4(j,k),aa,yy,i,j,k);
                    disp(iWcl(:,:,i));
                end
            end
            H5(:,k) = bitxor(H4(:,k),Bdl(:,i));
            H6(:,k) = H5(:,k) + H32(:,k);  % y3k
            maxH6 = maxy1k(r); %max(H6(:));
            minH6 = miny1k(r); %min(H6(:));
            H7(:,k) = (H6(:,k)-1)*(maxH6-minH6)/(255-1)+minH6; % H7 = y2k
            H8(:,k) = iWdl(:,:,i) * H7(:,k);
            k=k+1;
        end % if k<=N*N
    end %for i=(r-1)*(N*N)+1:r*(N*N)
    it=1;
    for k=1:N 
    	for j=1:N
            encryptPic(k,j,:) = H8(:,it);
            it=it+1;  
        end
    end
    toc
%      Pc = mod(Pc,255);
    encryptPic = uint8(encryptPic);
    r = r-1;
    
end %while (r > 0)

%save('C:\Users\Tncr\Documents\MATLAB\decPc.mat', 'Pc');
imwrite(encryptPic,'C:\Users\Tncr\Documents\MATLAB\decrypto_lena.bmp');
figure(1);
imshow('C:\Users\Tncr\Documents\MATLAB\decrypto_lena.bmp');
title('Deþifre Görüntü');
red = encryptPic(:,:,1);
green = encryptPic(:,:,2);
blue = encryptPic(:,:,3);
red = reshape(red,1,N*N);

figure(2);
red = reshape(red,1,N*N);
hist(double(red),255);
xlabel('Piksel deðeri');
ylabel('Histogram deðeri');
title('Kýrmýzý Renk Histogramý');
%         
% subplot(2,3,4);
figure(3);
green = reshape(green,1,N*N);
hist(double(green),255);
xlabel('Piksel deðeri');
ylabel('Histogram deðeri');
title('Yeþil Renk Histogramý');
%         
% subplot(2,3,5);
figure(4);
blue = reshape(blue,1,N*N);
hist(double(blue),255);
xlabel('Piksel deðeri');
ylabel('Histogram deðeri');
title('Mavi Renk Histogramý');