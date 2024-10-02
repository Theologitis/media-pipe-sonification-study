duration=[30,80];
% duration for viewing angles [0,28]

kpn_=name(frame>25*duration(1) &frame<25*duration(2));
kpw_=name(frame>25*duration(1) &frame<25*duration(2));

Xn=norm_x(frame>25*duration(1)&frame<25*duration(2));
Yn=norm_y(frame>25*duration(1) &frame<25*duration(2));
Zn=norm_z(frame>25*duration(1) &frame<25*duration(2));

Xw=world_x(frame>25*duration(1) &frame<25*duration(2));
Yw=world_y(frame>25*duration(1) &frame<25*duration(2));
Zw=world_z(frame>25*duration(1) &frame<25*duration(2));


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


figure(Name='Skeleton normal');
plot3(Xn,1-Yn,Zn,'.');
xlim([0 R])
view(0,90);
% saveas(gcf,'skeleton normal task 180.fig')

figure(Name='Skeleton world task 180');
plot3(Xw,-Yw,Zw,'.');
xlim([-1 1]);
ylim([-1 1]);
view(0,90);
% saveas(gcf,'skeleton world task 180.fig')

% %hip wdith world
% hip_width_world_180= sqrt(sum((left_hip_pw - right_hip_pw).^2,2));
% 
% %hip width normal
% hip_width_normal_180= sqrt (sum((left_hip_pn - right_hip_pn).^2,2));
% 
% % shoulder width world
% shoulder_width_world_180= sqrt(sum((left_shoulder_pw - right_shoulder_pw).^2,2));
% 
% % shoulder width normal
% shoulder_width_normal_180= sqrt(sum((left_shoulder_pn - right_shoulder_pn).^2,2));


% figure(Name='hip width@ 50% viewing angles normal');
% boxchart([hip_width_normal_0,hip_width_normal_45,hip_width_normal_90,hip_width_normal_135,hip_width_normal_180])
% title('hip width normal @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance normalized by frame height');
% saveas(gcf,'hip_width_solution_normal_va.fig');
% 
% figure(Name='hip width@ 50% viewing angles world');
% boxchart(100*[hip_width_world_0,hip_width_world_45,hip_width_world_90,hip_width_world_135,hip_width_world_180])
% title('hip width world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylim([15 25]) % prosthesa ayto den to exw dokimasei
% ylabel('distance in cm');
% saveas(gcf,'hip_width_solution_world_va.fig');
% 
% figure(Name='shoulder width@ 50% viewing angles normal');
% boxchart([shoulder_width_normal_0,shoulder_width_normal_45,shoulder_width_normal_90,shoulder_width_normal_135,shoulder_width_normal_180])
% title('shoulder width normal @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance normalized by frame height');
% saveas(gcf,'shoulder_width_solution_normal_va.fig');
% 
% figure(Name='shoulder width@ 50% viewing angles world');
% boxchart(100*[shoulder_width_world_0,shoulder_width_world_45,shoulder_width_world_90,shoulder_width_world_135,shoulder_width_world_180])
% title('shoulder width world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylim=([25,35]) %prosthesa ayto den to exw dokimasei
% ylabel('distance in cm');
% saveas(gcf,'shoulder_width_solution_world_va.fig');
% 
% 
% %HEIGHTS
% % shoulder hip height world
% shoulder_hip_right_world_180=sum((right_shoulder_pw - right_hip_pw).^2,2);
% shoulder_hip_left_world_180=sum((left_shoulder_pw - left_hip_pw).^2,2);
% 
% % shoulder hip height normal
% shoulder_hip_right_normal_180=sum((right_shoulder_pn - right_hip_pn).^2,2);
% shoulder_hip_left_normal_180=sum((left_shoulder_pn-left_hip_pn).^2,2);
% 
% % shoulder ankle height world
% shoulder_ankle_right_world_180=sum((right_shoulder_pw - right_ankle_pw).^2,2);
% shoulder_ankle_left_world_180=sum((left_shoulder_pw - left_ankle_pw).^2,2);
% 
% % shoulder ankle height normal
% shoulder_ankle_right_normal_180=sum((right_shoulder_pn - right_ankle_pn).^2,2);
% shoulder_ankle_left_normal_180=sum((left_shoulder_pn - left_ankle_pn).^2,2);
% 
% % hip ankle height world
% hip_ankle_right_world_180=sum((right_hip_pw - right_ankle_pw).^2,2);
% hip_ankle_left_world_180=sum((left_hip_pw - left_ankle_pw).^2,2);
% 
% % hip ankle height normal
% hip_ankle_right_normal_180=sum((right_hip_pn - right_ankle_pn).^2,2);
% hip_ankle_left_normal_180=sum((left_hip_pn - left_ankle_pn).^2,2);

% figure(Name='hip ankle left distance@ 50% viewing angles world');
% boxchart(100*sqrt([hip_ankle_left_world_0,hip_ankle_left_world_45,hip_ankle_left_world_90,hip_ankle_left_world_135,hip_ankle_left_world_180]))
% title('hip ankle left world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'hip_ankle_left_world_solution_va.fig');
% 
% figure(Name='hip ankle right distance@ 50% viewing angles world');
% boxchart(100*sqrt([hip_ankle_right_world_0,hip_ankle_right_world_45,hip_ankle_right_world_90,hip_ankle_right_world_135,hip_ankle_right_world_180]))
% title('hip ankle right world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'hip_ankle_right_world_solution_va.fig');
% 
% figure(Name='shoulder ankle left distance@ 50% viewing angles world');
% boxchart(100*sqrt([shoulder_ankle_left_world_0,shoulder_ankle_left_world_45,shoulder_ankle_left_world_90,shoulder_ankle_left_world_135,shoulder_ankle_left_world_180]))
% title('shoulder ankle left world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'shoulder_ankle_left_world_solution_va.fig');
% 
% figure(Name='shoulder ankle right distance@ 50% viewing angles world');
% boxchart(100*sqrt([shoulder_ankle_right_world_0,shoulder_ankle_right_world_45,shoulder_ankle_right_world_90,shoulder_ankle_right_world_135,shoulder_ankle_right_world_180]))
% title('shoulder ankle right world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'shoulder_ankle_right_world_solution_va.fig');
% 
% figure(Name='shoulder hip left distance@ 50% viewing angles world');
% boxchart(100*sqrt([shoulder_hip_left_world_0,shoulder_hip_left_world_45,shoulder_hip_left_world_90,shoulder_hip_left_world_135,shoulder_hip_left_world_180]))
% title('shoulder hip left world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'shoulder_hip_left_world_solution_va.fig');
% 
% figure(Name='shoulder hip right distance@ 50% viewing angles world');
% boxchart(100*sqrt([shoulder_hip_right_world_0,shoulder_hip_right_world_45,shoulder_hip_right_world_90,shoulder_hip_right_world_135,shoulder_hip_right_world_180]))
% title('shoulder hip right world @ 50% viewing angles');
% xlabel('angles to camera');
% xticklabels({'0','45','90','135','180'});
% ylabel('distance in cm');
% saveas(gcf,'shoulder_hip_right_world_solution_va.fig');
