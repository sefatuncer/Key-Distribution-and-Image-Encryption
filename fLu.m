function LuValue = fLu(N)

a=36; b=3; c=28;% constant parameters
%%%%%%%%%%%
% Set initial condition, step length 
% and number of steps
%%%%%%%%%%%
y1 = zeros(1,N); y2 = zeros(1,N); y3 = zeros(1,N);
y1(1)=5.00000000000001;  y2(1)=5.00000000000000; y3(1)=11.00000000000004; % initial value
% y1(1)=5.6;  y2(1)=4.5; y3(1)=12.7;
h=0.02; 
h2=h/2;
%%%%%%%%%
% Advance solution
%%%%%%%%%
t = zeros(N,1);
t(1)=0;
% x=t(1);
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
	f02 = c*y2m - y1m*y3m;
    f03 = y1m*y2m - b*y3m;   
% 2. Set provisional values yt1
	yt11 = y1(i-1) + h2*f01;
	yt12 = y2(i-1) + h2*f02;
    yt13 = y3(i-1) + h2*f03;    
% 3. Compute phase speed ft1 at provisional points
	ft11 = a*(yt12-yt11);
	ft12 = c*yt12 - yt11*yt13;
    ft13 = yt11*yt12 - b*yt13;
% 4. Set provisional values yt2
	yt21 = y1(i-1) + h2*ft11;
	yt22 = y2(i-1) + h2*ft12;
    yt23 = y3(i-1) + h2*ft13;
% 5. Compute phase speed ft2 at provisional points
	ft21 = a*(yt22-yt21);
	ft22 = c*yt22 - yt21*yt23;
    ft23 = yt21*yt22 - b*yt23;
% 6. Set provisional values yt3
	yt31 = y1(i-1) + h*ft21;
	yt32 = y2(i-1) + h*ft22;
    yt33 = y3(i-1) + h*ft23;
% 7. Compute phase speed ft3 at provisional points
	ft31 = a*(yt32-yt31);
	ft32 = c*yt32 - yt31*yt33;
    ft33 = yt31*yt32 - b*yt33;
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
%     x = t(i-1);	
%x
end
LuValue = [y1; y2; y3];
save('C:\Users\sefa1\OneDrive\Belgeler\MATLAB\MATLAB_2020_Ocak\Image Encryption\LuValue.mat','LuValue');