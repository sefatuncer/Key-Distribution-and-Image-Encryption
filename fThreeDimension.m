%% Sefa Tunçer / Bilecik Þeyh Edebali Üniversitesi
% Yüksek Lisans
% 17.3.2016 
%% 2 BOYUTTAN 3 BOYUTA ÇEVÝRME
% Fonksiyonda 2 boyutlu görüntü piksel deðerlerini 
% 3 boyutlu bir kübik yapýya çevirme iþlemi gerçekleþtiriliyor
% ve her küp ayrý bir deðiþkene atanýyor.
% 'new1,...,new7' olmasýnýn sebebi: Belirlenen herhangi bir görüntünün
% maksimum 7 küpten oluþacak þekilde ayarlanmasýdýr.
% 'c1,....,c7' deðiþkenleri: Oluþan küplerdeki deðerler
% Örnek: 'c1', 3x3x3 bir küp ise 27 tane veriye sahiptir.
% 'root' deðiþkeni: Her kübün bir kenarýnýn uzunluðunu dizide tutar.
% I: Gri seviye görüntü
% W: En H: Boy
% cube: 
function [c1,c2,c3,c4,c5,c6,c7,root] = fThreeDimension(I,W,H,cubeSize)
elemansayisi = numel(cubeSize);
cubeSize = floor(uint8(cubeSize.^(1/3)));

c1 = zeros(); % Küp 1
c2 = zeros(); % Küp 2
c3 = zeros();
c4 = zeros();
c5 = zeros();
c6 = zeros();
c7 = zeros();

x=1; % Görüntünün yatay baþlangýç deðeri
y=1; % Görüntünün dikey baþlangýç deðeri
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
                else % Görüntünün en saðdaki pikseline ulaþýlýrsa
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

