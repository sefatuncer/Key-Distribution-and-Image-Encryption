%% 3 boyuttan 2 boyuta �evirme
% fThreeDimension fonksiyonunun tersi
% K�plere ayr�lan orjinal g�r�nt� tekrar eski boyutlar�na d�nd�r�l�yor
% T�m k�pler ayr�ld��� s�ra ile birle�tiriliyor
function [result] = fInvThreeDimension(I,W,H,cube,mixcube1,mixcube2,mixcube3,mixcube4,mixcube5,mixcube6,mixcube7)

elemansayisi = numel(cube);
cube = uint8(cube.^(1/3));

x=1; % G�r�nt�n�n yatay ba�lang�� de�eri
y=1; % G�r�nt�n�n dikey ba�lang�� de�eri

for it=1:elemansayisi
    maks = cube(it);
    for i=1:maks
        for j=1:maks
            for k=1:maks
                if x<=H && y<=W
                    if it==1
                        I(x,y) = mixcube1(i,j,k);
                    elseif it==2
                        I(x,y) = mixcube2(i,j,k);
                    elseif it==3
                        I(x,y) = mixcube3(i,j,k);
                    elseif it==4
                        I(x,y) = mixcube4(i,j,k);
                    elseif it==5
                        I(x,y) = mixcube5(i,j,k);
                    elseif it==6
                        I(x,y) = mixcube6(i,j,k);
                    elseif it==7
                        I(x,y) = mixcube7(i,j,k);
                    end
                    y=y+1;
                else
                    y=1;
                    x=x+1;   
                    if it==1
                        I(x,y) = mixcube1(i,j,k);
                    elseif it==2
                        I(x,y) = mixcube2(i,j,k);
                    elseif it==3
                        I(x,y) = mixcube3(i,j,k);
                    elseif it==4
                        I(x,y) = mixcube4(i,j,k);
                    elseif it==5
                        I(x,y) = mixcube5(i,j,k);
                    elseif it==6
                        I(x,y) = mixcube6(i,j,k);
                    elseif it==7
                        I(x,y) = mixcube7(i,j,k);
                    end
                    y=y+1;
                end
            end
        end
    end
end
result = I;