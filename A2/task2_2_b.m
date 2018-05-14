close all
hold on

%axis stuff
%axis manual  % tell matlab not adjust the axis automatically
%axis equal   % prevent matlab from scaling x and y direction differently 
%axis off

%n = randperm(9,1)+1;
n = 10;
l = -2;
r = 2;

%x = linspace(l,r,n);
x = sort(-5 + (5+5)*rand(1,10));
y = polynomial_rep(x,1,3);
xx = linspace(-3,3,100);
yy = lagrange(xx,x,y);

plot(x,y,'-ko',xx,yy,'.');
xlim([-3 3]);
ylim([-30 30]);



% L=ones(n,size(x,2));
% for i=1:n
%     li = 1;
%     for j=1:n
%         if (i~=j)
%             li = li .* (x - x(j))/(x(i) - x(j));
%         end
%     end
%     plot(x,li,'-ko')
% end

hold off


function y = polynomial_rep(x,coeff,degree)
    a = coeff;
    m = degree;

    %n = randperm(9,1)+1;
%     n = 10;
%     l = -2;
%     r = 2;
    
    
    
    y = a * x .^ m;
    %plot(x,y,'-ko');
    %xlim([-3 3]);
end

function y=lagrange(x,pointx,pointy)
%
%LAGRANGE   approx a point-defined function using the Lagrange polynomial interpolation
%
%      LAGRANGE(X,POINTX,POINTY) approx the function definited by the points:
%      P1=(POINTX(1),POINTY(1)), P2=(POINTX(2),POINTY(2)), ..., PN(POINTX(N),POINTY(N))
%      and calculate it in each elements of X
%
%      If POINTX and POINTY have different number of elements the function will return the NaN value
%
%      function wrote by: Carlo Castoldi carlo.castoldi(at)gmail.com
%      7-oct-2001
%
n=size(pointx,2);
L=ones(n,size(x,2));
if (size(pointx,2)~=size(pointy,2))
   fprintf(1,'\nERROR!\nPOINTX and POINTY must have the same number of elements\n');
   y=NaN;
else
   for i=1:n
      for j=1:n
         if (i~=j)
            L(i,:)=L(i,:).*(x-pointx(j))/(pointx(i)-pointx(j));
         end
      end
      %plot(x,x.*L(i,:));
   end
   y=0;
   for i=1:n
      y=y+pointy(i)*L(i,:);
   end
end
end
