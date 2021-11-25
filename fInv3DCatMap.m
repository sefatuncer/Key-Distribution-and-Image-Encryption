%% Inverse of 3D Chaotic CAT Map
% Sefa Tunçer / Bilecik Þeyh Edebali Üniversitesi
% 20.3.2016 
% Þifre çözme adýmlarýnda kullanýlan fonksiyon
function mixcube = fInv3DCatMap(N,cube,z1)

if N~=0 % Küpün elemaný var mý?
    k=1;
    if N<10
        k = 10;
    end
    ax = round(z1(100)/60*N*k); ay = round(z1(200)/60*N*k); az = round(z1(300)/60*N*k);
    bx = round(z1(50)/60*N*k); by = round(z1(150)/60*N*k); bz = round(z1(250)/60*N*k);
    A = [1+ax*az*by, az, ay+ax*az+ax*ay*az*by; % 3D Cat Map Matrisi 3x3
        bz+ax*by+ax*az*by*bz, az*bz+1, ay*az+ax*ay*az*by*bz+ax*az*bz+ax*ay*by+ax;
        ax*bx*by+by, bx, ax*ay*bx*by+ax*bx+ay*by+1];
    A = inv(A);
    mixcube = zeros();
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
else
    mixcube=0;
end