%% �ki boyutlu g�r�nt�den olu�abilecek minimum k�p adedi
% G�r�nt� boyutu ikiye b�l�n�yor ve bu halde 
% ayn� boyutta 2 tane k�p elde ediliyor
% Daha sonra g�r�nt�n�n kalan k�sm�ndan k�pler 
% elde edilmeye devam ediliyor
% cube: K�plerin boyutlar�n� tutan dizi
% boyut: W*H -> G�r�nt�n�n boyutu
function cube = fNumberOfCube(boyut)
cube = zeros(1,7); % Maksimum k�p say�s� 7
yariboyut = boyut/2; % G�r�nt�y� ikiye b�l
kup2 = floor(yariboyut^(1/3)); % 2 tane ayn� boyutta k�p
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

% Daha �nce yaz�lan kod k�sm�
% W = 512; % width
% H = 500; % height
% cube = W*H;
% it = 1;
% kupT = 0; % K�p toplam
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