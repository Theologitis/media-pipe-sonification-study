duration=[0,300];
R=1280/720;

%% Importing Variables %%
kpn_=name(frame>25*duration(1) & frame<25*duration(2));
kpw_=name(frame>25*duration(1) & frame<25*duration(2));

Xn=1280*norm_x(frame>25*duration(1) & frame<25*duration(2));
Yn=720*norm_y(frame>25*duration(1) & frame<25*duration(2));
Zn=norm_z(frame>25*duration(1) & frame<25*duration(2));

Xw=world_x(frame>25*duration(1) & frame<25*duration(2));
Yw=world_y(frame>25*duration(1) & frame<25*duration(2));
Zw=world_z(frame>25*duration(1) & frame<25*duration(2));

right_hip_pn=[Xn(kpn_== "RIGHT_HIP"), Yn(kpn_== "RIGHT_HIP"), Zn(kpn_== "RIGHT_HIP")];
left_hip_pn=[Xn(kpn_== "LEFT_HIP"), Yn(kpn_== "LEFT_HIP"), Zn(kpn_== "LEFT_HIP")];
right_shoulder_pn=[Xn(kpn_== "RIGHT_SHOULDER"), Yn(kpn_== "RIGHT_SHOULDER"), Zn(kpn_== "RIGHT_SHOULDER")];
left_shoulder_pn=[Xn(kpn_== "LEFT_SHOULDER"), Yn(kpn_== "LEFT_SHOULDER"), Zn(kpn_== "LEFT_SHOULDER")];
right_knee_pn=[ Xn(kpw_=='RIGHT_KNEE'),Yn(kpw_== "RIGHT_KNEE"),Zn(kpw_== "RIGHT_KNEE")];
left_knee_pn=[ Xn(kpw_=='LEFT_KNEE'),Yn(kpw_== "LEFT_KNEE"),Zn(kpw_== "LEFT_KNEE")];
right_ankle_pn=[Xn(kpw_== "RIGHT_ANKLE"), Yn(kpw_== "RIGHT_ANKLE"),Zn(kpw_== "RIGHT_ANKLE")];
left_ankle_pn=[Xn(kpw_== "LEFT_ANKLE"), Yn(kpw_== "LEFT_ANKLE"),Zn(kpw_== "LEFT_ANKLE")];

left_hip_pw=[Xw(kpw_== "LEFT_HIP"), Yw(kpw_== "LEFT_HIP"), Zw(kpw_== "LEFT_HIP")];
right_hip_pw=[Xw(kpw_== "RIGHT_HIP"), Yw(kpw_== "RIGHT_HIP"), Zw(kpw_== "RIGHT_HIP")];
left_shoulder_pw=[Xw(kpw_== "LEFT_SHOULDER"), Yw(kpw_== "LEFT_SHOULDER"),Zw(kpw_== "LEFT_SHOULDER")];
right_shoulder_pw=[Xw(kpw_== "RIGHT_SHOULDER"), Yw(kpw_== "RIGHT_SHOULDER"),Zw(kpw_== "RIGHT_SHOULDER")];
right_knee_pw=[ Xw(kpw_=='RIGHT_KNEE'),Yw(kpw_== "RIGHT_KNEE"),Zw(kpw_== "RIGHT_KNEE")];
left_knee_pw=[ Xw(kpw_=='LEFT_KNEE'),Yw(kpw_== "LEFT_KNEE"),Zw(kpw_== "LEFT_KNEE")];
right_ankle_pw=[Xw(kpw_== "RIGHT_ANKLE"), Yw(kpw_== "RIGHT_ANKLE"),Zw(kpw_== "RIGHT_ANKLE")];
left_ankle_pw=[Xw(kpw_== "LEFT_ANKLE"), Yw(kpw_== "LEFT_ANKLE"),Zw(kpw_== "LEFT_ANKLE")];

nose_pn=-[Xw(kpn_== "NOSE"), Yw(kpn_== "NOSE"), Zw(kpn_== "NOSE")];
nose_pw=-[Xw(kpw_== "NOSE"), Yw(kpw_== "NOSE"), Zw(kpw_== "NOSE")];


% hip width
hip_width_world_2 = sqrt(sum((left_hip_pw - right_hip_pw).^2,2));
hip_width_normal = sqrt (sum((left_hip_pn - right_hip_pn).^2,2));

% shoulder width
shoulder_width_world_2= sqrt(sum((left_shoulder_pw - right_shoulder_pw).^2,2));
shoulder_width_normal= sqrt(sum((left_shoulder_pn - right_shoulder_pn).^2,2));


% heights
%left world
left_shoulder_ankle_world= sqrt(sum((left_shoulder_pw - left_ankle_pw).^2,2));
left_shoulder_hip_world= sqrt(sum((left_shoulder_pw - left_hip_pw).^2,2));
left_hip_ankle_world = sqrt (sum((left_hip_pw - left_ankle_pw).^2,2));

%right world
right_shoulder_ankle_world= sqrt(sum((right_shoulder_pw - right_ankle_pw).^2,2));
right_shoulder_hip_world= sqrt(sum((right_shoulder_pw - right_hip_pw).^2,2));
right_hip_ankle_world = sqrt(sum((right_hip_pw - right_ankle_pw).^2,2));

%left normal
left_shoulder_ankle_normal= sqrt(sum((left_shoulder_pn - left_ankle_pn).^2,2));
left_shoulder_hip_normal= sqrt(sum((left_shoulder_pn - left_hip_pn).^2,2));
left_hip_ankle_normal = sqrt (sum((left_hip_pn - left_ankle_pn).^2,2));

%right normal
right_shoulder_ankle_normal= sqrt(sum((right_shoulder_pn - right_ankle_pn).^2,2));
right_shoulder_hip_normal= sqrt(sum((right_shoulder_pn - right_hip_pn).^2,2));
right_hip_ankle_normal = sqrt(sum((right_hip_pn - right_ankle_pn).^2,2));

%center world
center_shoulders_world=-(left_shoulder_pw(:,2)+right_shoulder_pw(:,2))./2;
center_hips_world=-(left_hip_pw(:,2)+right_hip_pw(:,2))./2;
%center normal
center_shoulders_normal=(left_shoulder_pn(:,2)+right_shoulder_pn(:,2))./2;
center_hips_normal=(left_hip_pn(:,2)+right_hip_pn(:,2))./2;

rms_hips=rms(center_hips_normal);
rms_shoulders=rms(center_shoulders_normal);
rms_hips_world=rms(center_hips_world);
rms_shoulders_world=rms(center_shoulders_world);

%% FIGURES %%
% WIDTHS AND HEIGHTS:

% % WORLD:
% 
% widths
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart(100*[shoulder_width_world,hip_width_world])
% title('widths world @ bounce 0 deg ');
% xticklabels({'shoulders','hips'});
% ylabel('distance in cm');
% saveas(gcf,'hip_shoulder_width_solution_world.fig');
% 
% %right side lengths
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart(100*[left_shoulder_ankle_world,left_hip_ankle_world,left_shoulder_hip_world])
% title('right side lengths in cm @ bounce 0 deg ');
% xticklabels({'shoulder-ankle','hip-ankle','shoulder-hip'});
% ylabel('distance in cm');
% saveas(gcf,'right_lengths_solution_world.fig');
% 
% %left side lengths
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart(100*[left_shoulder_ankle_world,left_hip_ankle_world,left_shoulder_hip_world])
% title('left side lengths in cm @ bounce 0 deg ');
% xticklabels({'shoulder-ankle','hip-ankle','shoulder-hip'});
% ylabel('distance in cm');
% saveas(gcf,'left_lengths_solutions_world.fig');
% 
% 
% % NORMAL:
% 
% %widths
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart([shoulder_width_normal,hip_width_normal])
% xticklabels({'shoulders','hips'})
% title('widths normal @ bounce 0 deg');
% ylabel('distance normalized by frame height(720p)');
% saveas(gcf,'hip_shoulder_width_solution_normal.fig');
% 
% %left side heights
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart([left_shoulder_ankle_normal,left_hip_ankle_normal,left_shoulder_hip_normal])
% title('left side heights normal @ bounce 0 deg ');
% xticklabels({'shoulder-ankle','hip-ankle','shoulder-hip'})
% ylabel('distance normalized by frame height(720p)');
% saveas(gcf,'left_heights_solution_normal.fig');
% 
% %right side heights:
% figure(Name='widths and heights @ bounce 0 deg ')
% boxchart([right_shoulder_ankle_normal,right_hip_ankle_normal,right_shoulder_hip_normal])
% title('right side lengths normal @ bounce 0 deg ');
% xticklabels({'shoulder-ankle','hip-ankle','shoulder-hip'})
% ylabel('distance normalized by frame height(720p)');
% saveas(gcf,'right_heights_solution_normal.fig');



% % FIGURES FOR BOUNCE ANALYSIS:
% figure(Name='right side heights normal')
% plot(right_shoulder_ankle_normal)
% hold on;
% plot(right_hip_ankle_normal)
% hold on;
% plot(right_shoulder_hip_normal)
% title('right side heights normal@ 0deg')
% legend('right shoulder ankle normal','right hip ankle normal','right shoulder hip normal')
% saveas(gcf,'right side heights normal@0deg.fig')
% 
% figure(Name='left side heights normal')
% plot(left_shoulder_ankle_normal)
% hold on;
% plot(left_hip_ankle_normal)
% hold on;
% plot(left_shoulder_hip_normal)
% title('left side heights normal @ 0deg')
% legend('left shoulder ankle normal','left hip ankle normal','left shoulder hip normal')
% saveas(gcf,'left side heights normal @ 0deg.fig');
% 
% figure(Name='right side heights world')
% plot(100*right_shoulder_ankle_world)
% hold on;
% plot(100*right_hip_ankle_world)
% hold on;
% plot(100*right_shoulder_hip_world)
% title('right side heights world@ 0deg')
% legend('right shoulder ankle world','right hip ankle world','right shoulder hip world')
% saveas(gcf,'right side heights world.fig')
% 
% figure(Name='left side heights world')
% 
% plot(left_shoulder_ankle_world)
% hold on;
% plot(left_hip_ankle_world)
% hold on;
% plot(left_shoulder_hip_world)
% title('left side heights world @ 0deg')
% legend('left shoulder ankle world','left hip ankle world','left shoulder hip world')
% saveas(gcf,'left side heights world.fig')
% 
% figure(Name='Y vs Euclidean Distance world')
% plot(100*right_shoulder_ankle_world)
% hold on
% plot(100*abs(right_shoulder_pw(:,2) - right_ankle_pw(:,2)))
% hold on
% plot(100*left_shoulder_ankle_world)
% hold on
% plot(100*abs(left_shoulder_pw(:,2) - left_ankle_pw(:,2)))
% title('Y vs Euclidean distance in cm')
% legend('right shoulder ankle world','Y right shoulder - Y right ankle','left shoulder ankle world','Y left shoulder - Y left ankle')
% saveas(gcf,'Y vs Euclidean Distance world.fig')
% 
% figure(Name='Y vs Euclidean Distance normal')
% plot(right_shoulder_ankle_normal)
% hold on
% plot(abs(right_shoulder_pn(:,2) - right_ankle_pn(:,2)))
% hold on
% plot(left_shoulder_ankle_normal)
% hold on
% plot(abs(left_shoulder_pn(:,2) - left_ankle_pn(:,2)))
% title('Y Euclidean distance normalized by frame height')
% legend('right shoulder ankle normal','Y right shoulder - Y right ankle','left shoulder ankle normal','Y left shoulder - left ankle')
% saveas(gcf,'Y vs Euclidean Distance normal.fig')
% 
%% ANGLES
% figure(Name='knee angles world@ 0deg')
% % angles:
% v1=right_knee_pw-right_hip_pw;
% v2=right_ankle_pw-right_knee_pw;
% norm_v1=sum(v1.^2,2);
% norm_v2=sum(v2.^2,2);
% mult=sum(v1.*v2,2);
% divider=sqrt((norm_v1.*norm_v2));
% costheta=mult./divider;
% theta=acos(costheta);
% % radians = atan(Yts(1)-Yts(1), Xts(0)-Xts(0) - atan(a(1)-b(1), a(0)-b(0));
% angle = abs(theta*180.0/pi);
% % angle=bound(angle,-0.2,0.2);
% plot(angle);
% title('knee angle @ 0deg')
% legend('angle knee 3D')
% saveas(gcf,'knee angles 3D world @0deg.fig')
% 
% figure(Name='knee angles normal @0deg')
% % angles:
% v1=right_knee_pn-right_hip_pn;
% v2=right_ankle_pn-right_knee_pn;
% norm_v1=sum(v1.^2,2);
% norm_v2=sum(v2.^2,2);
% mult=sum(v1.*v2,2);
% divider=sqrt((norm_v1.*norm_v2));
% costheta=mult./divider;
% theta=acos(costheta);
% % radians = atan(Yts(1)-Yts(1), Xts(0)-Xts(0) - atan(a(1)-b(1), a(0)-b(0));
% angle = abs(theta*180.0/pi);
% % angle=bound(angle,-0.2,0.2);
% plot(angle);
% title('knee angle normal @ 0deg')
% legend('angle knee 3D')
% saveas(gcf,'knee angles 3D normal@0deg.fig')
% 
%% centers
% figure(Name='center world');
% plot(100*center_shoulders_world)
% hold on;
% plot(100*center_hips_world)
% hold on;
% plot(100*nose_pw(:,2))
% legend('center shoulders world','center hips world','point 0:Nose')
% title('center hips and shoulder and nose world')
% saveas(gcf,'centers world.fig')
% 
% figure(Name='center normal');
% plot(center_shoulders_normal)
% hold on;
% plot(center_hips_normal)
% hold on;
% plot(nose_pn(:,2))
% legend('center shoulders normal','center hips normal','nose_pn')
% title('center hips and shoulder and nose normal')
% saveas(gcf,'centers normal.fig')
% 
% 
% figure(Name='center shoulders normalized by rms');
% plot(center_shoulders_normal./rms_shoulders);
% hold on;
% plot(center_hips_normal./rms_hips);
% legend('center hips normal normalized by rms','center shoulders normal normalized by rms')
% title('center hips and shoulder world normalized by the respective rms values')
% saveas(gcf,'centers normal normalized rms.fig')
% 
% figure;
% plot(center_hips_world./rms_hips_world);
% hold on;
% plot(center_shoulders_world./rms_shoulders_world);
% legend('center hips world normalized by rms','center shoulders world normalized by rms')
% title('center hips and shoulder world normalized by the respective rms values')
% saveas(gcf,'centers world normalized rms.fig')
% 
% figure(Name='center shoulders normalized by hip width normal');
% plot(center_shoulders_normal./hip_width_normal);
% title('center shoulders normalized by hip widths normal');
% legend('Y center/hip width normal')
% saveas(gcf,'center shoulders normalized by hip width normal.fig')
% 
% figure(Name='center shoulders normalized by hip width world');
% plot(center_shoulders_world./hip_width_world);
% title('center shoulders normalized by hip width world');
% legend('Y center/hip width world')
% saveas(gcf,'center shoulders normalized by hip width world.fig')
% 
% % 
% % distance hip ankle
% figure;
% leg=right_hip_pw - right_ankle_pw;
% norm_leg=sum(leg.^2,2);
% boxchart(norm_leg);
% 
% 
% % distance shoulder hip
% shoulder=right_shoulder_pw - right_hip_pw;
% norm_shoulder=sum(shoulder.^2,2);
% figure;
% %plot((1:length(shoulder))*0.04,100*norm_shoulder)
% boxchart(norm_shoulder);
% figure(Name='widths');
% plot(hip./norm_shoulder);
% hold on;
% plot(shoulder_width_world./norm_shoulder);
% % distance shoulder ankle
% body=right_shoulder_pw - right_ankle_pw;
% norm_body=sum(body.^2,2);
% 
% body=right_shoulder_pn - right_ankle_pn;
% norm_body=sum(body.^2,2);
% shoulder_normal=sum((right_shoulder_pn - right_hip_pn).^2,2);
% plot(body./shoulder_normal)
% 
% figure(Name='body distance world')
% p=plot((1:length(norm_body))*0.04,100*norm_body);
% p(1).LineWidth = 1;
% title('Distance right shoulder - ankle bounce 100 pitch');
% xlabel('time in s');
% ylabel('Distance in cm');
% % saveas(gcf,'body.fig');
% 
% figure(Name='Skeleton');
% 
% plot3(Xw,Yw,Zw,'.');
% 
% 
% % tiledlayout(2,1)
% % x = linspace(0,10,1000);
% % y = sin(10*x).*exp(.5*x);
% % ax1 = nexttile;
% % plot(ax1,x,y)
% % 
% % ax2 = nexttile;
% % plot(ax2,x,y)
% % ylim(ax2,[-10 10])

% function y = bound(x,bl,bu)
%   % return bounded value clipped between bl and bu
%   y=min(max(x,mean(x)+bl*mean(x)),mean(x)+mean(x)*bu);
%end
