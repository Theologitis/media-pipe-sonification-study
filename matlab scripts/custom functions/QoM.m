function y=QoM(s,fps)
    T=length(s)/fps-1;
    i=(2:length(s));
    y=sum(abs(s(i)-s(i-1)))/T;
end

