%differentiation techniques

% %FIRST DERIVATIVE:
% 
% %central differences
% 
% Vx=(X(i+1)-X(i-1))/2*h; % second order o=1
% 
% Vx=(-X(i+2)+8*X(i+1)+2*X(i-1)-X(i-2))/(12*h); %fourth order o=2
% 
% 
% %SECOND DERIVATIVE:
% 
% %central differences
% 
% Accx=(X(i+1)-2*X(i)+X(i+1))/(h^2);
% 
% Accx=(-X(i+2)+16*X(i+1)-30*X(i)+16*X(i-1)-X(i-2))/(12*h^2);
% 
% % THIRD DERIVATIVE:
% 
% jitterx=(X(i+2)-2*X(i+1)+2*X(i-1)-X(i-2))/(2*h^3);
% 
% jitterx=(-X(i-3)+8*X(i+2)-13*X(i-1)-8*X(i-2)+X(i-3))/(8*h^3);


function y = first_der(x,h,o)
  % x: 1D vector to calculate derivative of
  % h: time interval 1/fs in seconds 0.04 for fps=25
  % o: order of factors in calculation of derivative
 i=((o+1):(length(x)-o));
 switch o
     case 1
        y=(x(i+1)-x(i-1))/2*h;
     case 2
        y=(-x(i+2)+8*x(i+1)+2*x(i-1)-x(i-2))/(12*h);
     otherwise
        disp(' third argument must be 1(2nd order) or 2(4th order')
 end
end

function y = second_der(x,h,o)
  % x: 1D vector to calculate derivative of
  % h: time interval 1/fs in seconds 0.04 for fps=25
  % o: order of factors in calculation of derivative
 i=((o+1):(length(x)-o));
 switch o
     case 1
        y=(x(i+1)-2*x(i)+x(i+1))/(h^2);
     case 2
        y=(-x(i+2)+16*x(i+1)-30*x(i)+16*x(i-1)-x(i-2))/(12*h^2);

     otherwise
        disp(' third argument must be 1(2nd order) or 2(4th order')
 end
end

function y = third_der(x,h,o)
  % x: 1D vector to calculate derivative of
  % h: time interval 1/fs in seconds 0.04 for fps=25
  % o: order of factors in calculation of derivative
 i=((o+2):(length(x)-o-1));
 switch o
     case 1
        y=(x(i+2)-2*x(i+1)+2*x(i-1)-x(i-2))/(2*h^3);
     case 2
        y=(-x(i-3)+8*x(i+2)-13*x(i-1)-8*x(i-2)+x(i-3))/(8*h^3);

     otherwise
        disp(' third argument must be 1(2nd order) or 2(4th order')
 end
end

