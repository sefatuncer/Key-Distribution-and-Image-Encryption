%% CHAOS BASED IMAGE ENCRYPTION ~~ KAOTÝK TABANLI GÖRÜNTÜ ÞÝFRELEME
% Sefa Tunçer / Bilecik Þeyh Edebali Üniversitesi
% 26.12.2015
%% ~~~~~ Algoritma Adýmlarý ~~~~~
% Adým 1: 128 bit key dizisi oluþtur ve 8 gruba böl.
% Bu 8 grup ax,bx,ay,by,az,bz,Li,S olarak Adým 3'te kullanýlacak.
% Adým 2: Gri seviye görüntüyü birkaç küpten oluþacak biçimde parçala.
%(N1xN1xN1),(N2xN2xN2),....,(NixNixNi)
% Adým 3: ax,bx,ay,by,az,bz parametrelerini kullanarak 3 boyutlu Cat Map'i
% Herbir küp için uygula ve küpleri karýþtýr.
% Adým 4: Difüzyon süreci. x(0)= Li ve C(0)=S olsun.
% Adým 5: 3 boyutlu küp haline getirilen görüntüleri tekrar 2 boyutlu
% görüntü haline çevir.

clear all,
clc

% Matlab Functions
% s = 5558; % secret number
% k = 3;
% n = 6;
% d = ShamirSharing(s,k,n);
% c = d(1:4,:);
% r = ShamirReconstruction(c,k);

% Python Functions
Km = [1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6]; %Þifreleme anahtarý 128 bit
secret = Km(1)*1000+Km(2)*100+Km(3)*10+Km(4);
n = 4; t = 2;

sss = int2str(secret);

Image = 'baboon256.bmp';
originalFile = strcat('Images/',Image);
cipherFile = strcat('Encrypted/GrayCatMap_',Image);


I = imread(originalFile);
I = rgb2gray(I);
% I = I(:,:,2);
imwrite(I,'graylevel.bmp');
% imshow(I);
H = size(I,1); % Görüntünün boy deðeri
W = size(I,2); % Görüntünün en deðeri
N = W; % Gri seviye görüntü boyu

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

Li = z1(100)/60; % Ondalýklý sayý / x(1) Logistic Map giriþ deðeri
S = round(z1(200)/60*255); % Tamsayý / C(1) deðeri

cubeSize = fNumberOfCube(W*H); % Dizide bulunacak küplerin boyutlarýný belirleme
R = W*H-sum(cubeSize); % Küp olmayan kýsým(R<8) = Görüntünün boyutu - küplerin toplamý
[cube1, cube2, cube3, cube4, cube5, cube6, cube7, root] = fThreeDimension(I,W,H,cubeSize); %Oluþan küpler ve boyutlarý
elemansayisi = numel(cubeSize); % Oluþan küp sayýsý
root = double(root); % Küplerin bir kenarlarýnýn saklandýðý dizi
cat = 1; % Cat Map matrisinin kendisi veya tersini almak için
% f3DCatMap fonksiyonunda cat 1 ise A, cat 0 ise inv(A)
% ~~Tüm küpler 3D Cat Map ile karýþtýrýlýyor
tic % zaman
mixcube1 = f3DCatMap(root(1),cube1,z1,cat);
mixcube2 = f3DCatMap(root(2),cube2,z1,cat);
mixcube3 = f3DCatMap(root(3),cube3,z1,cat);
mixcube4 = f3DCatMap(root(4),cube4,z1,cat);
mixcube5 = f3DCatMap(root(5),cube5,z1,cat);
mixcube6 = f3DCatMap(root(6),cube6,z1,cat);
mixcube7 = f3DCatMap(root(7),cube7,z1,cat);

% Küpleri birleþtir ve görüntü elde et
Iyeni = fInvThreeDimension(I,W,H,cubeSize,mixcube1,mixcube2,mixcube3,mixcube4,mixcube5,mixcube6,mixcube7);
Iyeni = double(Iyeni);
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

C = zeros();
C(1) = S;
for k=2:N*N % XOR iþlemi
    C(k) = bitxor(bitxor(Q(k),mod(Iyeni(k)+Q(k),256)),C(k-1)); % N (color level 256)
end
toc % zaman

CipherImage = reshape(C,W,H); % W*H boyutuna dönüþtür.
CipherImage = uint8(CipherImage);

imwrite(CipherImage,cipherFile);

% Call Python Function for Key Sharing
shares = py.SecretSharing.deploy_shares(cipherFile, t, n, secret);
disp(shares)





% figure(1);
% imshow(I);
% title('Orijinal Görüntü');
% figure(2);
% imshow(CipherImage);
% title('Þifreli Görüntü');
% figure(3);
% imhist(CipherImage);
% title('Þifreli Görüntü Histogramý');
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');
% figure(4);
% imhist(I);% Orjinal image
% title('Orijinal Görüntü Histogramý');
% xlabel('Piksel deðeri');
% ylabel('Histogram deðeri');

% % SHA256 hash oluþtur
% [m, n, ~] = size(CipherImage);      % Gives rows, columns, ignores number of channels
% % Starts by separating the image into RGB channels
% flat_Image = reshape(CipherImage(:,:,1)',[1 m*n]); % Reshapes Red channel matrix into a 1 by m*n uint8 array
% % flat_RGB = [flat_R, flat_G, flat_B];     % Concatenates all RGB vals, into one long 1 by 3*m*n array
% string_RGB = num2str(flat_Image);                         % Converts numeric matrices to a string
% string_RGB = string_RGB(~isspace(num2str(string_RGB))); % Removes spaces - though this is not strictly necessary I think
% % Perform hashing
% sha256hasher = System.Security.Cryptography.SHA256Managed;           % Create hash object (?) - this part was copied from the forum post mentioned above, so no idea what it actually does
% imageHash_uint8 = uint8(sha256hasher.ComputeHash(uint8(string_RGB))); % Find uint8 of hash, outputs as a 1x32 uint8 array
% imageHash_hex = dec2hex(imageHash_uint8); % Convert uint8 to hex, if necessary. This step is optional depending on your application.

% Bilgileri kaydet
% yaz = fopen('data.txt','w+');
% fprintf(yaz,imageHash_hex);
% 
% % dec2hex(uint8(sha256hasher.ComputeHash(uint8('1234'))))
% % dec2hex(uint8(sha256hasher.ComputeHash(uint8('1235'))))
% 
% for i=1:length(c)
%     hash = dec2hex(uint8(sha256hasher.ComputeHash(uint8(num2str(c(i,2))))));
%     fprintf(yaz,' ');
%     fprintf(yaz,hash);
% end
% fclose(yaz);