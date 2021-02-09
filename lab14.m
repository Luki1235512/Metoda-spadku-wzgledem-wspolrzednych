clc
close all
clear all

wybor = 1;

switch wybor
case 1
	f = @(x1,x2) x1.^2+x2.^2;
	x1p = -10;
	x1k = 10;
	x2p = -10;
	x2k = 10;
	x10 = 8;
	x20 = -10;
	krok = 1;
case 2
	f=@(x1,x2) -cos(x1).*cos(x2).*exp(-((x1-pi).^2+(x2-pi).^2));
	x1p = 2;
	x1k = 4;
	x2p = 2;
	x2k = 4;
	x10 = 2;
	x20 = 2;
	krok = 0.1;
otherwise
	f=@(x1,x2) (1-8*x1 + 7 * x1.^2 - 7/3 * x1.^3 +1/4*x1.^4).*(x2.^2).*exp(-x2);
	x1p = 0;
	x1k = 5;
	x2p = 0;
	x2k = 5;
	x10 = 5;
	x20 = 5;
	krok = 0.2;
end

%eps = ...

[x1, x2, dx1, dx2, it]= sww(f, x10, x20, krok, x1p, x1k, x2p, x2k)

subplot(2 ,1 ,1)
% wykres funkcji 3d na zadanym przedziale - meshgrid + mesh
[x ,y ]= meshgrid( linspace(x1p,x1k,100),linspace(x2p,x2k,100) ) ;
mesh (x, y, f(x, y));
hold on
% zaznaczone minimum - plot3

subplot(2, 1, 2);
z= f(x, y);
[c, h]= contour(x, y, z);
clabel(c, h);
hold on
% zaznaczenie i podpisanie punktu startowego
plot (x10,x20, 'r*');
text (x10,x20, 'START');
% zaznaczenie i podpisanie punktu koncowego - minimum
plot (x1,x2, 'r*');
text (x1,x2, 'STOP');

% narysowanie sciezki - linie pomiedzy kolejnymi punktami
for i =1:length(dx1)-1
	line([dx1(i) ,dx1(i+1) ], [dx2(i) ,dx2(i+1) ], 'Color', 'k', 'Linewidth', 1);
	contour(x, y, z, [f(dx1(i), dx2(i)), f(dx1(i), dx2(i))]);
end

function [x10, x20, dx1, dx2, it] = sww (f, x10, x20, krok, ~, ~, ~, ~)
it=0;
dx1=[x10];
dx2=[x20];
while (1)
    
    
    it=it+1;
    center=f(x10,x20);
    up=f(x10,x20+krok);
    right=f(x10+krok,x20);
    down=f(x10,x20-krok);
    left=f(x10-krok,x20);
    minimum=min([up right down left]);
    
    
    
    if (minimum<center)
        if(minimum==up)
            x20=x20+krok;
        elseif(minimum==right)
            x10=x10+krok;
        elseif(minimum==down)
            x20=x20-krok;  
        elseif(minimum==left)
            x10=x10-krok;
        end
        
        dx1=[dx1,x10];
        dx2=[dx2,x20];
        
    else
        break;
    end
end
end