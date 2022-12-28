%% Sefa Tun�er / Bilecik �eyh Edebali �niversitesi
% Y�ksek Lisans
% 17.3.2016 
%% 2 BOYUTTAN 3 BOYUTA �EV�RME
% Fonksiyonda 2 boyutlu g�r�nt� piksel de�erlerini 
% 3 boyutlu bir k�bik yap�ya �evirme i�lemi ger�ekle�tiriliyor
% ve her k�p ayr� bir de�i�kene atan�yor.
% 'new1,...,new7' olmas�n�n sebebi: Belirlenen herhangi bir g�r�nt�n�n
% maksimum 7 k�pten olu�acak �ekilde ayarlanmas�d�r.
% 'c1,....,c7' de�i�kenleri: Olu�an k�plerdeki de�erler
% �rnek: 'c1', 3x3x3 bir k�p ise 27 tane veriye sahiptir.
% 'root' de�i�keni: Her k�b�n bir kenar�n�n uzunlu�unu dizide tutar.
% I: Gri seviye g�r�nt�
% W: En H: Boy
% cube: 
function [c1,c2,c3,c4,c5,c6,c7,root] = fThreeDimension(I,W,H,cubeSize)
elemansayisi = numel(cubeSize);
cubeSize = floor(uint8(cubeSize.^(1/3)));

c1 = zeros(); % K�p 1
c2 = zeros(); % K�p 2
c3 = zeros();
c4 = zeros();
c5 = zeros();
c6 = zeros();
c7 = zeros();

x=1; % G�r�nt�n�n yatay ba�lang�� de�eri
y=1; % G�r�nt�n�n dikey ba�lang�� de�eri
for it=1:elemansayisi
    maks = cubeSize(it);
    for i=1:maks
        for j=1:maks
            for k=1:maks
                if x<=H && y<=W
                    if it==1
                        c1(i,j,k) = I(x,y);
                    elseif it==2
                        c2(i,j,k) = I(x,y);
                    elseif it==3
                        c3(i,j,k) = I(x,y);
                    elseif it==4
                        c4(i,j,k) = I(x,y);
                    elseif it==5
                        c5(i,j,k) = I(x,y);
                    elseif it==6
                        c6(i,j,k) = I(x,y);
                    elseif it==7
                        c7(i,j,k) = I(x,y);
                    end
                    y=y+1;
                else % G�r�nt�n�n en sa�daki pikseline ula��l�rsa
                    x=x+1;
                    y=1;
                    if it==1
                        c1(i,j,k) = I(x,y);
                    elseif it==2
                        c2(i,j,k) = I(x,y);
                    elseif it==3
                        c3(i,j,k) = I(x,y);
                    elseif it==4
                        c4(i,j,k) = I(x,y);
                    elseif it==5
                        c5(i,j,k) = I(x,y);
                    elseif it==6
                        c6(i,j,k) = I(x,y);
                    elseif it==7
                        c7(i,j,k) = I(x,y);
                    end
                    y=y+1;
                end
            end
        end
    end
end
root = cubeSize;

