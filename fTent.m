%%Chaotic Tent Map Function
% 25.11.2015
function value = fTent(a,x)
% a = 3x256 matrices y4k
% x = 3x256 matrices Al
S = 256;
%a = 120; % 1<a<S
%x = reshape(cikis,1,256);

for j=1:3
    for i = 1:1:S-1
        if x(j,i)<=a
            value(j,i) = ceil((S/a)*x(j,i));
        elseif x(j,i)>a
            value(j,i) = floor((S/(S-a))*(S-x(j,i)))+1;
        end
    end
end

% for i = 1:1:S-1
%     if x(j,i)<=a
%         value(j,i) = ceil((S/a)*x(j,i));
%     elseif x(j,i)>a
%         value(j,i) = floor((S/(S-a))*(S-x(j,i)))+1;
%     end
% end
