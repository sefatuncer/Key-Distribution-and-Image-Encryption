%% 3 boyuttan 2 boyuta çevirme
% fThreeDimension fonksiyonunun tersi
% Küplere ayrýlan orjinal görüntü tekrar eski boyutlarýna döndürülüyor
% Tüm küpler ayrýldýðý sýra ile birleþtiriliyor
function [result] = fInvThreeDimension(I,W,H,cube,mixcube1,mixcube2,mixcube3,mixcube4,mixcube5,mixcube6,mixcube7)

elemansayisi = numel(cube);
cube = uint8(cube.^(1/3));

x=1; % Görüntünün yatay baþlangýç deðeri
y=1; % Görüntünün dikey baþlangýç deðeri

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