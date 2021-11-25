%% İki boyutlu görüntüden oluşabilecek minimum küp adedi
% Görüntü boyutu ikiye bölünüyor ve bu halde 
% aynı boyutta 2 tane küp elde ediliyor
% Daha sonra görüntünün kalan kısmından küpler 
% elde edilmeye devam ediliyor
% cube: Küplerin boyutlarını tutan dizi
% boyut: W*H -> Görüntünün boyutu
function cube = fNumberOfCube(boyut)
cube = zeros(1,7); % Maksimum küp sayısı 7
yariboyut = boyut/2; % Görüntüyü ikiye böl
kup2 = floor(yariboyut^(1/3)); % 2 tane aynı boyutta küp
cube(1) = kup2^3;
cube(2) = kup2^3;
kupT = 2*kup2^3;
it = 3;
while boyut-kupT > 7
   for i=1:(boyut-kupT)
       if i^3>boyut-kupT
            cube(it) = (i-1)^3;
            kupT = kupT + cube(it);
            it = it+1;
            break;
       end
   end
end

% Daha önce yazılan kod kısmı
% W = 512; % width
% H = 500; % height
% cube = W*H;
% it = 1;
% kupT = 0; % Küp toplam
% while boyut-kupT > 7
%    for i=1:1:(boyut-kupT)/2
%        if i^3>boyut-kupT
%             kup(it) = (i-1)^3;
%             kupT = kupT + kup(it);
%             it = it+1;
%             break;
%        end
%    end
% end
% cube = kup;