function y = diff_(x,h,n,o)
  % x: 1D vector to calculate derivative of
  % h: time interval 1/fs in seconds 0.04 for fps=25
  % o: order of factors in calculation of derivative
  % n: order of derivative
  % all derivatives are central
 switch n

    case 1 

     i=((o+1):(length(x)-o));

     switch o
         case 1
             y=(x(i+1)-x(i-1))/(2*h);
         case 2
             y=(-x(i+2)+8*x(i+1)-8*x(i-1)+x(i-2))/(12*h);
         otherwise
             disp(' third argument must be 1(2nd order) or 2(4th order')
     end

     case 2   
        i=((o+1):(length(x)-o));
        switch o
            case 1
                y=(x(i+1)-2*x(i)+x(i-1))/(h^2);
            case 2
                y=(-x(i+2)+16*x(i+1)-30*x(i)+16*x(i-1)-x(i-2))/(12*h^2);

            otherwise
                disp(' third argument must be 1(2nd order) or 2(4th order')
        end
    

     case 3 
        i=((o+2):(length(x)-o-1));
        switch o
            case 1
                y=(x(i+2)-2*x(i+1)+2*x(i-1)-x(i-2))/(2*h^3);
            case 2
                y=(-x(i+3)+8*x(i+2)-13*x(i+1)+13*x(i-1)-8*x(i-2)+x(i-3))/(8*h^3);

            otherwise
                disp(' o-fourth argument must be 1(2nd order) or 2(4th order')
        end

     otherwise 
         disp(' n-thrid argument must be 1(1st derivative) ,2(second derivative) or 3(third derivative')
  end

