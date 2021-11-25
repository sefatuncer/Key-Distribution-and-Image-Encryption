%% Inverse Cat Map Function
% 26.11.2015
function X = fInvCat(y,N)

% X = zeros(N,N,3);
p=37;
q=97;
for k=1:3
    for i=1:N
        for j=1:N
            newi = mod(((p*q+1)*(i-1) - p*(j-1)),N)+1; % get new i coord 
            newj = mod((-q*(i-1) + (j-1)),N)+1; % get new j coord 
            X(newi,newj,k) = y(i,j,k);
        end
    end
end
% X = uint8(X);