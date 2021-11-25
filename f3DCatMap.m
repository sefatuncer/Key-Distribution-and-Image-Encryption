%% 3D Chaotic CAT Map
% Sefa Tunçer / Bilecik Þeyh Edebali Üniversitesi
% 17.3.2016
% Görüntüden alýnan küp þeklindeki matrislerde bulunan deðerlerin
%indislerinin yerleri deðiþtirilerek karýþtýrma iþlemi.
% N: Küpün bir kenar boyu
% cubeValue: Küpteki x,y,z deðerleri
% z1: Chen kaotik sisteminden gelen deðerler
% ax,bx,ay,by,az,bz: z1'e baðlý oluþturulan A matrisinde kullanýlacak
% deðerler
% A: Cat Map matrisi 3x3

function mixcube = f3DCatMap(N,cube,z1,cat)
if N~=0 % Küpün elemaný var mý?
    k = 10;
    if N<10
        k = 50;
    end
    %~~~~~~~~~~~~~~~~~~~~~~ Burayý kontrol et. Büyük ihtimalle sorun
    %burada.******************************************************
    ax = round(z1(100)/60*N*k); ay = round(z1(200)/60*N*k); az = round(z1(300)/60*N*k);
    bx = round(z1(50)/60*N*k); by = round(z1(150)/60*N*k); bz = round(z1(350)/60*N*k);
%     dizi = [ax ay az;bx by bz]
    A = [1+ax*az*by, az, ay+ax*az+ax*ay*az*by; % 3D Cat Map Matrisi 3x3
        bz+ax*by+ax*az*by*bz, az*bz+1, ay*az+ax*ay*az*by*bz+ax*az*bz+ax*ay*by+ax;
        ax*bx*by+by, bx, ax*ay*bx*by+ax*bx+ay*by+1];
%     A = [1 3 5; 55 5 6; 7 11 9];
    mixcube = zeros();
    if cat==1 % Þifreleme
        for i=1:N
            for j=1:N
                for k=1:N
                    newcord = mod(A*[i;j;k],N)+1; % i,j,k'nýn küpte yeni konumu belirleniyor
                    xn = newcord(1); % Yeni x koordinatý
                    yn = newcord(2); % Yeni y koordinatý
                    zn = newcord(3); % Yeni z koordinatý
                    mixcube(xn,yn,zn) = cube(i,j,k); % 1.küp karýþtýrýlýyor
                end
            end
        end
    else % cat==0 Deþifreleme ( Tersi alýnýr)
        for i=1:N
            for j=1:N
                for k=1:N
                    newcord = mod(A*[i;j;k],N)+1; % i,j,k'nýn küpte yeni konumu belirleniyor
                    xn = newcord(1); % Yeni x koordinatý
                    yn = newcord(2); % Yeni y koordinatý
                    zn = newcord(3); % Yeni z koordinatý
                    mixcube(i,j,k) = cube(xn,yn,zn); % 1.küp karýþtýrýlýyor
                end
            end
        end
    end
else
    mixcube=0;
end


