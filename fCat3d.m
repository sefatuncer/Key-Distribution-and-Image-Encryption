function X = fCat3d(P,ax,ay,az,bx,by,bz,N)

% A = [1+ax*az*by, az, ay+ax*az+ax*ay*az*by;
%     bz+ax*by+ax*az*by*bz, az*bz+1, ay*az+ax*ay*az*by*bz+ax*az*bz+ax*ay*by+ax;
%     ax*bx*by+by, bx, ax*ay*bx*by+ax*bx+ay*by+1];

for i=1:N
    for j=1:N
        for k=1:N
            newx = mod((1+ax*az*by)*(i-1)+az*(j-1)+(ay+ax*az+ax*ay*az*by)*(k-1),N)+1;
            newy = mod((bz*+ax*by+ax*az*by*bz)*(i-1)+(az*bz+1)*(j-1)+(ay*az+ax*ay*az*by*bz+ax*az*bz+ax*ay*by+ax)*(k-1),N)+1;
            newz = mod((ax*bx*by+by)*(i-1)+bx*(j-1)+(ax*ay*bx*by+ax*bx+ay*by+1)*(k-1),N)+1;
            X(newx,newy,newz) = y(i,j,k);
        end
    end
end

















% P = double(imread('C:\Users\Tncr\Documents\MATLAB\lenaa.bmp'));
% newcor = zeros(N,N,3);
% New = zeros(N,N,3);
% k=1;
% for i=1:N
% 	for j=1:N
%             newcor(i,j,:) = mod(A*[i; j ;k],512)+1;
%             x = newcor(i,j,1);
%             y = newcor(i,j,2);
%             New(x,y,:) = P(i,j,:);
% 	end
% end
% mix = New;
% end