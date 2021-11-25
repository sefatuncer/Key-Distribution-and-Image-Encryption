%% 3D Chaotic CAT Map
% Sefa Tun�er / Bilecik �eyh Edebali �niversitesi
% 17.3.2016
% G�r�nt�den al�nan k�p �eklindeki matrislerde bulunan de�erlerin
%indislerinin yerleri de�i�tirilerek kar��t�rma i�lemi.
% N: K�p�n bir kenar boyu
% cubeValue: K�pteki x,y,z de�erleri
% z1: Chen kaotik sisteminden gelen de�erler
% ax,bx,ay,by,az,bz: z1'e ba�l� olu�turulan A matrisinde kullan�lacak
% de�erler
% A: Cat Map matrisi 3x3

function mixcube = f3DCatMap(N,cube,z1,cat)
if N~=0 % K�p�n eleman� var m�?
    k = 10;
    if N<10
        k = 50;
    end
    %~~~~~~~~~~~~~~~~~~~~~~ Buray� kontrol et. B�y�k ihtimalle sorun
    %burada.******************************************************
    ax = round(z1(100)/60*N*k); ay = round(z1(200)/60*N*k); az = round(z1(300)/60*N*k);
    bx = round(z1(50)/60*N*k); by = round(z1(150)/60*N*k); bz = round(z1(350)/60*N*k);
%     dizi = [ax ay az;bx by bz]
    A = [1+ax*az*by, az, ay+ax*az+ax*ay*az*by; % 3D Cat Map Matrisi 3x3
        bz+ax*by+ax*az*by*bz, az*bz+1, ay*az+ax*ay*az*by*bz+ax*az*bz+ax*ay*by+ax;
        ax*bx*by+by, bx, ax*ay*bx*by+ax*bx+ay*by+1];
%     A = [1 3 5; 55 5 6; 7 11 9];
    mixcube = zeros();
    if cat==1 % �ifreleme
        for i=1:N
            for j=1:N
                for k=1:N
                    newcord = mod(A*[i;j;k],N)+1; % i,j,k'n�n k�pte yeni konumu belirleniyor
                    xn = newcord(1); % Yeni x koordinat�
                    yn = newcord(2); % Yeni y koordinat�
                    zn = newcord(3); % Yeni z koordinat�
                    mixcube(xn,yn,zn) = cube(i,j,k); % 1.k�p kar��t�r�l�yor
                end
            end
        end
    else % cat==0 De�ifreleme ( Tersi al�n�r)
        for i=1:N
            for j=1:N
                for k=1:N
                    newcord = mod(A*[i;j;k],N)+1; % i,j,k'n�n k�pte yeni konumu belirleniyor
                    xn = newcord(1); % Yeni x koordinat�
                    yn = newcord(2); % Yeni y koordinat�
                    zn = newcord(3); % Yeni z koordinat�
                    mixcube(i,j,k) = cube(xn,yn,zn); % 1.k�p kar��t�r�l�yor
                end
            end
        end
    end
else
    mixcube=0;
end


