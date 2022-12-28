%% Cat Map Function
% 26.11.2015
function X = fCat(y,N)

p=6;
q=4;
X = zeros();
% it = 1;

for k=1:3
    for i=1:N
        for j=1:N
            newi = mod(((i-1) + p*(j-1)),N)+1;     % get new i coord 
            newj = mod((q*(i-1) + (p*q+1)*(j-1)),N)+1; % get new j coord 
            X(newi,newj,k) = y(i,j,k);
%             it=it+1;
        end 
    end
end

%X = uint8(X);




% it = 1;
% for k=1:3
%     for i=1:N
%         for j=1:N
%             newi = mod(((i-1) + p(it)*(j-1)),N)+1;     % get new i coord 
%             newj = mod((q(it)*(i-1) + (p(it)*q(it)+1)*(j-1)),N)+1; % get new j coord 
%             X(newi,newj,k) = y(i,j,k);
%         end 
%     end
%     it = it+1;
% end