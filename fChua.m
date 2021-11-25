%% Chaotic Chua System Function
function ChuaValue = fChua(N)     
% Clears the command window
%%%%%
% Set Chua
% parameters
%%%%%
a=10.0; b=100/7;% constant parameters
%%%%%%%%%%%
% Set initial condition, step length 
% and number of steps
%%%%%%%%%%%
y1 = zeros(1,N); y2 = zeros(1,N); y3 = zeros(1,N);
y1(1)=0.0050000000000000;  y2(1)=0.00700000000000; y3(1)=0.00900000000000; % initial value
% y1(1)=3.5;  y2(1)=4.7; y3(1)=3.9;
h=0.02; 
%R=N; % x Maksimum
h2=h/2;
%%%%%%%%%
% Advance solution
%%%%%%%%%
t = zeros(N,1);
t(1)=0;
i=1;
while i<N %x<R % ode45 fonksiyonunun iþlevi ile benzer
    i=i+1;
%%%
% Step from t(i-1) to t(i) using 
% the provisional points yt1,yt2,yt3 inbetween
%%%
% 1. Compute f(t,y)
     y1m = y1(i-1);
     y2m = y2(i-1);
     y3m = y3(i-1);
         
     % y1m=x1 y2m=y1 y3m=z1
     
	f01 = a*(y2m-(2*y1m^3-y1m/7));
	f02 = y1m-y2m+y3m;
    f03 = -b*y2m;   
% 2. Set provisional values yt1
	yt11 = y1(i-1) + h2*f01;
	yt12 = y2(i-1) + h2*f02;
    yt13 = y3(i-1) + h2*f03;    
% 3. Compute phase speed ft1 at provisional points
	ft11 = a*(yt12-(2*yt11^3-yt11/7));
	ft12 = yt11 - yt12 + yt13;
    ft13 = -b*yt12;  
% 4. Set provisional values yt2
	yt21 = y1(i-1) + h2*ft11;
	yt22 = y2(i-1) + h2*ft12;
    yt23 = y3(i-1) + h2*ft13;
% 5. Compute phase speed ft2 at provisional points
	ft21 = a*(yt22-(2*yt21^3-yt21/7));
	ft22 = yt21 - yt22 + yt23;
    ft23 = -b*yt22;
% 6. Set provisional values yt3
	yt31 = y1(i-1) + h*ft21;
	yt32 = y2(i-1) + h*ft22;
    yt33 = y3(i-1) + h*ft23;    
% 7. Compute phase speed ft3 at provisional points
	ft31 = a*(yt32-(2*yt31^3-yt31/7));
	ft32 = yt31 - yt32 + yt33;
    ft33 = -b*yt32;    
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
% y1 = y1 * 100; y2 = y2 * 100; y3 = y3 * 100; 
ChuaValue = [y1; y2; y3];
save('C:\Users\sefa1\OneDrive\Belgeler\MATLAB\MATLAB_2020_Ocak\Image Encryption\ChuaValue.mat','ChuaValue');
% plot3(y1,y2,y3);
% xlabel('x','fontsize',20);
% ylabel('y','fontsize',20);
% zlabel('z','fontsize',20);
end
