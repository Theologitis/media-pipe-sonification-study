function [s1,s2]=align_signals(signal1_,signal2_)
% % [r,lag]=xcorr(Zg2,Zg1);
% % plot(lag,r)
% % plot(Times1,)
% 
% % Define two signals

% signal1_ = ss2; % Example signal 1 (random noise)
% signal2_ = ss1; % Example signal 2 (shifted version of signal 1)


% Compute cross-correlation
[crossCorr, lag] = xcorr(signal1_, signal2_);
plot(lag(lag>-40&lag<140),abs(crossCorr(lag>-40&lag<140)));
% Find the lag with maximum cross-correlation
[~, maxIndex] = max(abs(crossCorr));
lagMax = lag(maxIndex);

if lagMax >= 0
    alignedSignal1 = signal1_(1+lagMax:end);
    alignedSignal2 = signal2_(1:end-lagMax);
else
    alignedSignal1 = signal1_(1:end+lagMax);
    alignedSignal2 = signal2_(1-lagMax:end);
end

% t=linspace(0,30,6000);
% plot(t,alignedSignal1(1:6000));
% hold on;
% plot(t,alignedSignal2(1:6000));
% hold on;

s1=alignedSignal1;
s2=alignedSignal2';
end
% Plot the aligned signals
% figure;
% subplot(2,1,1);
% plot(alignedSignal1);
% title('Aligned Signal 1');
% subplot(2,1,2);
% plot(alignedSignal2);
% title('Aligned Signal 2');
% i=(1:length(Zg2)-1)
% velocity=(Zg2(i+1)-Zg2(i)).*Times2(i+1)
% i=(1:length(velocity)-1)
% position=(velocity(i+1)-velocity(i)).*Times2(i+1)
% i=(1:length(Times)-1);
% x=Times(i+1)-Times(i);
% hist(x,100)
% i=(1:length(time_cam)-1);
% x=time_cam(i+1)-time_cam(i);
% % hist(x/10^9,100)
% i=linspace(0,10,length(hand_Y_camera));
% rms_value = sqrt(mean(signal2 .^ 2));
% rms_cam=sqrt(mean(hand_Y_camera.^2));
% %plot(Times_hand,signal2/rms_value,i,hand_Y_camera/rms_cam);
% 
% A=normalize(signal1);
% B=normalize(signal2);
% plot(Times_hand,B,i,A);

