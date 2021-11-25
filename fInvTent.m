%% Inverse of Chaotic Tent Map
% 28.11.2015
% S. Tunçer / Bilecik Þeyh Edebali University

function value = fInvTent(a,x)
% a = 3x256 matrices y4k
% x = 3x256 matrices Al
S = 256;
%a = 120; % 1<a<S
%x = reshape(cikis,1,256);

for j=1:3
    for i = 1:1:S
        if ceil(a*x(j,i)/S)-floor(a*x(j,i)/S)==-1 && ceil(a*x(j,i)/S)/a>(-floor((a/S-1)*y)/(S-a)) || ceil(a*x(j,i)/S)-floor(a*x(j,i)/S)==0
            phi(j,i) = ceil(a*x(j,i)/S);
        elseif x(j,i)>a
            phi(j,i) = floor((a/S-1)*x(j,i)+S);
        end
    end
end
value = phi;