% differentiating and smoothening data.

%diff_()
%diff
%movmean()
%sgolayfilt()
%mocaptoolbox mctimder and mcsmooth and mctimeintegr
%cumsum
%std : standard deviation
%mape: mean absolut error
D1=importSession('C:\Users\Yannis Theologitis\Documents\master thesis code\gain AHRS tests\gain 0');
D2=importSession('C:\Users\Yannis Theologitis\Documents\master thesis code\gain AHRS tests\gain 0.2');
D3=importSession('C:\Users\Yannis Theologitis\Documents\master thesis code\gain AHRS tests\gain 0.5');
D4=importSession('C:\Users\Yannis Theologitis\Documents\master thesis code\gain AHRS tests\gain 0.8');
D5=importSession('C:\Users\Yannis Theologitis\Documents\master thesis code\gain AHRS tests\gain 1');


plot(D1.ngimu00360081.euler.pitch(2684:2984))
hold on;
plot(D2.ngimu00360081.euler.pitch(4422:4722))
hold on;
plot(D3.ngimu00360081.euler.pitch(4612:4912))
hold on;
plot(D4.ngimu00360081.euler.pitch(4222:4522))
hold on;
plot(D5.ngimu00360081.euler.pitch(3964:4264))

plot(D1.ngimu00360081.magnitudes.accelerometer(2750:3350))
hold on;
plot(D2.ngimu00360081.magnitudes.accelerometer(4450:5650))
hold on;
plot(D3.ngimu00360081.magnitudes.accelerometer(5970:6614))
hold on;
plot(D4.ngimu00360081.magnitudes.accelerometer(2755:3200))
hold on;
plot(D5.ngimu00360081.magnitudes.accelerometer(4558:5135))

figure;
boxchart([D1.ngimu00360081.magnitudes.gyroscope(2800:3200) ,D2.ngimu00360081.magnitudes.gyroscope(4450:4850) ,D3.ngimu00360081.magnitudes.gyroscope(6000:6400) ...
    D4.ngimu00360081.magnitudes.gyroscope(2800:3200) ,D5.ngimu00360081.magnitudes.gyroscope(4600:5000)])

