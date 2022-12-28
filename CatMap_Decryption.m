%% CHAOS BASED IMAGE DECRYPTION ~~ KAOTÝK TABANLI GÖRÜNTÜ ÞÝFRE ÇÖZME
% Sefa Tunçer / Bilecik Þeyh Edebali Üniversitesi
% 20.3.2020
clc;
clear all, close all;
cipherImageLocation = "Encrypted/enc_image_baboon512.bmp";
CipherImage = imread(cipherImageLocation);
% CipherImage = rgb2gray(CipherImage);
H = size(CipherImage,1); % Görüntünün boy deðeri
W = size(CipherImage,2); % Görüntünün en deðeri
N = W; % Gri seviye görüntü boyu

secret = num2str(py.SecretSharing.unify_secret(cipherImageLocation));
s1=str2double(secret(1));
s2=str2double(secret(2));
s3=str2double(secret(3));
s4=str2double(secret(4));

% Km = [str2double(secret(1)) str2double(secret(2)) str2double(secret(3)) str2double(secret(4)) 5 6 7 8 9 0 1 2 3 4 5 6]; %Þifreleme anahtarý 128 bit
Km = [s1 s2 s3 s4 5 6 7 8 9 0 1 2 3 4 5 6];
kax = (Km(1)*10+Km(2))/100;
kbx = (Km(3)*10+Km(4))/100;
% kay = (Km(5)*10+Km(6))/100;
% kby = (Km(7)*10+Km(8))/100; 
% kaz = Km(9)*10+Km(10);
% kbz = Km(11)*10+Km(12);
% kl  = Km(13)*10+Km(14);
% ks  = Km(15)*10+Km(16);
cax = kax*8.4+20;
x0h = kbx*80-40;
y0h = kax*80-40;
z0h = kbx*60;
xyz1 = fChen(500,x0h,y0h,z0h,cax); % Chen kaotik sistemi
% x1 = xyz1(1,:); y1 = xyz1(2,:); 
z1 = xyz1(3,:);

Li = z1(100)/60; % Ondalýklý sayý / Logistic Map giriþ deðeri
S = round(z1(200)/60*255); % Tamsayý
C = double(reshape(CipherImage,1,W*H)); % Þifreli görüntüyü 1 boyutlu diziye çevir

x = zeros();
x(1) = Li;
for k=2:N*N % Chaotic Logistic Map deðerleri üret
    x(k) = 4*x(k-1)*(1-x(k-1)); % 0.2-0.8 aralýðýnda olmasý gerekli(0.5 bad point)
end
min_x = min(x); max_x=max(x);
Q = zeros();
for k=1:N*N % fi deðeri:Normalizasyon 0.2-0.8 aralýðý
    Q(k) = (x(k)-min_x)/(max_x-min_x)*(0.8-0.2)+0.2;
    Q(k) = floor(Q(k)*400-75); % Digitize edilmiþ hali
end
Iyeni = zeros();
Iyeni(1) = S;
for k=2:N*N % Þifrelemedeki XOR iþleminin tersi
    Iyeni(k) = mod(bitxor(bitxor(Q(k),C(k)),C(k-1))+256-Q(k),256); % N (color level 256)
end
Iyeni = double(reshape(Iyeni,W,H));

cubeSize = fNumberOfCube(W*H); % Dizide bulunacak küplerin boyutlarýný belirleme
R = W*H-sum(cubeSize); % Küp olmayan kýsým(R<8) = Görüntünün boyutu - küplerin toplamý
[cube1,cube2,cube3,cube4,cube5,cube6,cube7,root] = fThreeDimension(Iyeni,W,H,cubeSize); %Oluþan küpler ve boyutlarý
elemansayisi = numel(cubeSize); % Oluþan küp sayýsý
root = double(root); % Küplerin bir kenarlarýnýn saklandýðý dizi

cat = 0; % Cat Map matrisinin kendisi veya tersini almak için
% f3DCatMap fonksiyonunda cat 1 ise A, cat 0 ise inv(A)
% ~~Tüm karýþýk küplerin 3D Cat Map ile tersi alýnýyor
mixcube1 = f3DCatMap(root(1),cube1,z1,cat);
mixcube2 = f3DCatMap(root(2),cube2,z1,cat);
mixcube3 = f3DCatMap(root(3),cube3,z1,cat);
mixcube4 = f3DCatMap(root(4),cube4,z1,cat);
mixcube5 = f3DCatMap(root(5),cube5,z1,cat);
mixcube6 = f3DCatMap(root(6),cube6,z1,cat);
mixcube7 = f3DCatMap(root(7),cube7,z1,cat);

I = fInvThreeDimension(Iyeni,W,H,cubeSize,mixcube1,mixcube2,mixcube3,mixcube4,mixcube5,mixcube6,mixcube7);
I = uint8(I);

imwrite(I,'SymmetricDecrypted.bmp');
imshow(I);
title('Deþifre Görüntü');
% hold on
% imshow('');
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');
% title('Kýrmýzý Renk Histogramý');