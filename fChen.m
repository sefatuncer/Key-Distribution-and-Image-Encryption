function ChenValue = fChen(N,x0h,y0h,z0h,cax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab code: Chen
a=35; b=3; c=cax; % constant parameters

y1 = zeros(1,N); y2 = zeros(1,N); y3 = zeros(1,N);
y1(1)=x0h;  y2(1)=y0h; y3(1)=z0h; % initial value
h=0.05;
h2=h/2;

t = zeros(1,N);
t(1)=0;
i=1;
while i<N  % ode45 fonksiyonunun iþlevi ile benzer
i=i+1;
%%%
% Step from t(i-1) to t(i) using 
% the provisional points yt1,yt2,yt3 inbetween
%%%
% 1. Compute f(t,y)
     y1m = y1(i-1);
     y2m = y2(i-1);
     y3m = y3(i-1);
         
	f01 = a*(y2m-y1m);
	f02 = (c-a)*y1m - y1m*y3m + c*y2m;
    f03 = y1m*y2m - b*y3m;   
% 2. Set provisional values yt1
	yt11 = y1(i-1) + h2*f01;
	yt12 = y2(i-1) + h2*f02;
    yt13 = y3(i-1) + h2*f03;    
% 3. Compute phase speed ft1 at provisional points
	ft11 = a*(yt12-yt11);
	ft12 = (c-a)*yt11 - yt11*yt13 + c*yt12;
    ft13 = -b*yt13 + yt11*yt12;  
% 4. Set provisional values yt2
	yt21 = y1(i-1) + h2*ft11;
	yt22 = y2(i-1) + h2*ft12;
    yt23 = y3(i-1) + h2*ft13;
% 5. Compute phase speed ft2 at provisional points
	ft21 = a*(yt22-yt21);
	ft22 = (c-a)*yt21 - yt21*yt23 + c*yt22;
    ft23 = -b*yt23 + yt21*yt22;
% 6. Set provisional values yt3
	yt31 = y1(i-1) + h*ft21;
	yt32 = y2(i-1) + h*ft22;
    yt33 = y3(i-1) + h*ft23;    
% 7. Compute phase speed ft3 at provisional points
	ft31 = a*(yt32-yt31);
	ft32 = (c-a)*yt31 - yt31*yt33 + c*yt32;
    ft33 = -b*yt33 + yt31*yt32;    
% 8. Compute final phase speeds ff
	ff1 = (1/6)*( f01 + 2*ft11 + 2*ft21 + ft31 );
	ff2 = (1/6)*( f02 + 2*ft12 + 2*ft22 + ft32 );
    ff3 = (1/6)*( f03 + 2*ft13 + 2*ft23 + ft33 );  
% 9. Set new solution values
	y1(i) = y1(i-1) + h*ff1;
	y2(i) = y2(i-1) + h*ff2;
    y3(i) = y3(i-1) + h*ff3;
% Update independent variable
	t(i) = t(i-1) + h;
%x
end
ChenValue = [y1; y2; y3];
% plot3(y3,y2,y1);
% xlabel('x','fontsize',20);
% ylabel('y','fontsize',20);
% zlabel('z','fontsize',20);

