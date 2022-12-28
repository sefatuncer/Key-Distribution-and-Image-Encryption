%% Encryption of CNL
% S. Tunçer / Bilecik
% Yüksek Lisans
clc;
clear all, close all;

Image = 'Ebrar256.bmp';
Original = strcat('Images/',Image);
Cipher = strcat('Encrypted/CNN_',Image);

originalPic = imread(Original);
P = originalPic;
sz = size(originalPic);
N = sz(1); % s = 512
N0 = 160; % secret keys

r = 1; R = 2; %Number of iterations
xyz1 = fChua(N*N*R+N0);
xyz2 = fLorenz(N*N*R+N0);
xyz3 = fLu(N*N*R+N0);
% x1 = xyz1(1,:)*53; y1 = xyz1(2,:)*389; z1 = xyz1(3,:)*92;
% x2 = xyz2(1,:); y2 = xyz2(2,:); z2 = xyz2(3,:);
% x3 = xyz3(1,:)*0.62; y3 = xyz3(2,:)*0.72; z3 = xyz3(3,:)*0.68;
x1 = xyz1(1,:)*279; y1 = xyz1(2,:)*1557; z1 = xyz1(3,:)*196;
x2 = xyz2(1,:)*5; y2 = xyz2(2,:)*4; z2 = xyz2(3,:);
x3 = xyz3(1,:)*3; y3 = xyz3(2,:)*2; z3 = xyz3(3,:);
% x1 = xyz1(1,:)*27.9; y1 = xyz1(2,:)*155.7; z1 = xyz1(3,:)*19.6;
% x2 = xyz2(1,:)*.5; y2 = xyz2(2,:)*.4; z2 = xyz2(3,:);
% x3 = xyz3(1,:)*.3; y3 = xyz3(2,:)*.2; z3 = xyz3(3,:);
% Definition of variable
X       = zeros(3,N*N);
maxy1k  = zeros(R);
miny1k  = zeros(R);
y1k     = zeros(3,N*N);
y2k     = zeros(3,N*N);
y31k    = zeros(3,N*N);
y32k    = zeros(3,N*N);
y4k     = zeros(3,N*N);
y5k     = zeros(3,N*N);
y6k     = zeros(3,N*N);
% Wdl = zeros(3,3,N*N*R);
% a = zeros(3,N*N*R);
% b = zeros(3,N*N*R);
% d = zeros(N*N*R,3);
% Wcl = zeros(3,3,N*N*R);
iWcl = zeros(3,3,N*N*R);
w1 = zeros(N*N*R,1);
w2 = zeros(N*N*R,1);
% p = zeros(N*N*R,1);
% q = zeros(N*N*R,1);
% Bcl = zeros(3,N*N*R);
pic = zeros(N,N,3);


while(r <= R) % Iteration of System
	it=1;
    for k=1:N
        for j=1:N
            X(:,it) = P(k,j,:);
            it=it+1;  
        end
    end
    [Wdl,a,b,d,Wcl,iWdl,Bcl] = EncryptionValues(x1,x2,x3,y1,y2,y3,z1,z2,z3,N,N0,r,R);

%     X = double(reshape(P,3,N,N));
%     [Wdl,a,b,d,Wcl,iWdl,Bcl] = EncryptionValues(x1,x2,x3,y1,y2,y3,z1,z2,z3,N,N0,r,R);
	Al = a;
    X = double(X);
    k=1;
    tic
    for i=((r-1)*(N*N)+1):1:(r*(N*N))
        if k<=N*N
            y1k(:,k) = Wdl(:,:,i)*X(:,k);
            k=k+1;
        end
    end

    maxy1k(r) = max(y1k(:));
    miny1k(r) = min(y1k(:));

    for k=1:N*N % Normalization
        y2k(:,k) = ((y1k(:,k)-miny1k(r))/(maxy1k(r)-miny1k(r)))*(255-1)+1;
        y31k(:,k) = floor(y2k(:,k));
        y32k(:,k) = mod(y2k(:,k),floor(y2k(:,k)));
    end

    y3k = y2k;
    k=1;
    S = 256;
    Bdl = floor(b);
    for i=(r-1)*(N*N)+1:r*(N*N)
        if k<=N*N
            y31k(:,k) = floor(y2k(:,k));
            y32k(:,k) = mod(y2k(:,k),floor(y2k(:,k)));
            y4k(:,k) = bitxor(y31k(:,k),Bdl(:,i)); % XOR Operation  
            for j=1:3
                aa = Al(j,i);
                % Chaotic Activation Function / Tent Map
                if 0<= y4k(j,k) && y4k(j,k)<=aa
                    y5k(j,k) = ceil((S/aa)*y4k(j,k));
                elseif(aa<y4k(j,k) && y4k(j,k)<=S)
                    y5k(j,k) = floor((S/(S-aa))*(S-y4k(j,k)))+1;
                else
                    fprintf('y4k --> UYARI %f\n',y4k(j,k));
                end
            end
            k=k+1;
        end
    end
    disp('Aktivasyon');
    y5k = double(y5k)+y32k; % The output of the CNL is 3*(N*N) matrices
	k=1;
    for i=(r-1)*(N*N)+1:1:r*(N*N)
        if k<=N*N
            y6k(:,k) = Wcl(:,:,i)*y5k(:,k)*0.9922; %mod((Wcl(:,:,i)*y5k(:,k))*5,255); %+ Bcl(:,i); % g(Wcl*y5k+Bcl)
            k = k+1;
        end
    end
    k=1;
    for i=1:N
        for j=1:N
            if k<=N*N
            pic(i,j,:) = y6k(:,k); %RGB
            k=k+1;
            end
        end
    end
  	y7k = fCat(pic,N); % Cat Map Permutation
    encryptPic = y7k;
    r = r+1;
    toc
end %while(r < R)

encryptPic = uint8(encryptPic);
grayPic = rgb2gray(encryptPic);
red = encryptPic(:,:,1);
green = encryptPic(:,:,2);
blue = encryptPic(:,:,3);
imwrite(encryptPic,Cipher);
%!!SUBPLOT (satýr sayýsý,sütun sayýsý,þu an çizilecek olanýn indisi)
%  
% subplot(2,3,1);
figure(1);
imshow(originalPic);
title('Orijinal Görüntü');
% 
% subplot(2,3,2);
figure(2);
imshow(encryptPic);
title('Þifreli Görüntü');

EncryptionValues()
%
% subplot(2,3,3);
% figure(3);
% red = reshape(red,1,N*N);
% hist(double(red),255);
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');
% title('Kýrmýzý Renk Histogramý');
% %         
% % subplot(2,3,4);
% figure(4);
% green = reshape(green,1,N*N);
% hist(double(green),255);
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');
% title('Yeþil Renk Histogramý');
% %         
% % subplot(2,3,5);
% figure(5);
% blue = reshape(blue,1,N*N);
% hist(double(blue),255);
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');
% title('Mavi Renk Histogramý');
% subplot(2,3,6);
% encryptPic = reshape(encryptPic,1,3*N*N);
% hist(double(encryptPic),255);
% figure(2);
% red = reshape(red,1,N*N);
% hist(double(red),255);