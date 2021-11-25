%% CHAOS BASED IMAGE ENCRYPTION ~~ KAOT�K TABANLI G�R�NT� ��FRELEME
% Sefa Tun�er / Bilecik �eyh Edebali �niversitesi
% 26.12.2015
%% ~~~~~ Algoritma Ad�mlar� ~~~~~
% Ad�m 1: 128 bit key dizisi olu�tur ve 8 gruba b�l.
% Bu 8 grup ax,bx,ay,by,az,bz,Li,S olarak Ad�m 3'te kullan�lacak.
% Ad�m 2: Gri seviye g�r�nt�y� birka� k�pten olu�acak bi�imde par�ala.
%(N1xN1xN1),(N2xN2xN2),....,(NixNixNi)
% Ad�m 3: ax,bx,ay,by,az,bz parametrelerini kullanarak 3 boyutlu Cat Map'i
% Herbir k�p i�in uygula ve k�pleri kar��t�r.
% Ad�m 4: Dif�zyon s�reci. x(0)= Li ve C(0)=S olsun.
% Ad�m 5: 3 boyutlu k�p haline getirilen g�r�nt�leri tekrar 2 boyutlu
% g�r�nt� haline �evir.

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
Km = [1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6]; %�ifreleme anahtar� 128 bit
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
H = size(I,1); % G�r�nt�n�n boy de�eri
W = size(I,2); % G�r�nt�n�n en de�eri
N = W; % Gri seviye g�r�nt� boyu

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

Li = z1(100)/60; % Ondal�kl� say� / x(1) Logistic Map giri� de�eri
S = round(z1(200)/60*255); % Tamsay� / C(1) de�eri

cubeSize = fNumberOfCube(W*H); % Dizide bulunacak k�plerin boyutlar�n� belirleme
R = W*H-sum(cubeSize); % K�p olmayan k�s�m(R<8) = G�r�nt�n�n boyutu - k�plerin toplam�
[cube1, cube2, cube3, cube4, cube5, cube6, cube7, root] = fThreeDimension(I,W,H,cubeSize); %Olu�an k�pler ve boyutlar�
elemansayisi = numel(cubeSize); % Olu�an k�p say�s�
root = double(root); % K�plerin bir kenarlar�n�n sakland��� dizi
cat = 1; % Cat Map matrisinin kendisi veya tersini almak i�in
% f3DCatMap fonksiyonunda cat 1 ise A, cat 0 ise inv(A)
% ~~T�m k�pler 3D Cat Map ile kar��t�r�l�yor
tic % zaman
mixcube1 = f3DCatMap(root(1),cube1,z1,cat);
mixcube2 = f3DCatMap(root(2),cube2,z1,cat);
mixcube3 = f3DCatMap(root(3),cube3,z1,cat);
mixcube4 = f3DCatMap(root(4),cube4,z1,cat);
mixcube5 = f3DCatMap(root(5),cube5,z1,cat);
mixcube6 = f3DCatMap(root(6),cube6,z1,cat);
mixcube7 = f3DCatMap(root(7),cube7,z1,cat);

% K�pleri birle�tir ve g�r�nt� elde et
Iyeni = fInvThreeDimension(I,W,H,cubeSize,mixcube1,mixcube2,mixcube3,mixcube4,mixcube5,mixcube6,mixcube7);
Iyeni = double(Iyeni);
x = zeros();
x(1) = Li;
for k=2:N*N % Chaotic Logistic Map de�erleri �ret
    x(k) = 4*x(k-1)*(1-x(k-1)); % 0.2-0.8 aral���nda olmas� gerekli(0.5 bad point)
end
min_x = min(x); max_x=max(x);
Q = zeros();
for k=1:N*N % fi de�eri:Normalizasyon 0.2-0.8 aral���
    Q(k) = (x(k)-min_x)/(max_x-min_x)*(0.8-0.2)+0.2;
    Q(k) = floor(Q(k)*400-75); % Digitize edilmi� hali
end

C = zeros();
C(1) = S;
for k=2:N*N % XOR i�lemi
    C(k) = bitxor(bitxor(Q(k),mod(Iyeni(k)+Q(k),256)),C(k-1)); % N (color level 256)
end
toc % zaman

CipherImage = reshape(C,W,H); % W*H boyutuna d�n��t�r.
CipherImage = uint8(CipherImage);

imwrite(CipherImage,cipherFile);

% Call Python Function for Key Sharing
shares = py.SecretSharing.deploy_shares(cipherFile, t, n, secret);
disp(shares)





% figure(1);
% imshow(I);
% title('Orijinal G�r�nt�');
% figure(2);
% imshow(CipherImage);
% title('�ifreli G�r�nt�');
% figure(3);
% imhist(CipherImage);
% title('�ifreli G�r�nt� Histogram�');
% xlabel('Piksel de�eri');
% ylabel('Histogram de�eri');
% figure(4);
% imhist(I);% Orjinal image
% title('Orijinal G�r�nt� Histogram�');
% xlabel('Piksel de�eri');
% ylabel('Histogram de�eri');

% % SHA256 hash olu�tur
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