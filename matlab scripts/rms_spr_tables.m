SH_0=100*(sqrt(shoulder_hip_right_world_0)+sqrt(shoulder_hip_left_world_0))/2;
SH_45=100*(sqrt(shoulder_hip_right_world_45)+sqrt(shoulder_hip_left_world_45))/2;
SH_90=100*(sqrt(shoulder_hip_right_world_90)+sqrt(shoulder_hip_left_world_90))/2;
SH_135=100*(sqrt(shoulder_hip_right_world_135)+sqrt(shoulder_hip_left_world_135))/2;
SH_180=100*(sqrt(shoulder_hip_right_world_180)+sqrt(shoulder_hip_left_world_180))/2;

%boxchart([SH_0,SH_45,SH_90,SH_135,SH_180]) %SH table

% table of max and mean differences between heights:
%max(abs(shoulder_hip_right_world_90 - shoulder_hip_left_world_90));

SH_true= 52.5;
HW_true= 23.5;
SW_true=34;
HW_normalized_true= HW_true/SH_true;
SW_normalized_true=SW_true/SH_true;

HW_0=100*hip_width_world_0;
HW_45=100*hip_width_world_45;
HW_90=100*hip_width_world_90;
HW_135=100*hip_width_world_135;
HW_180=100*hip_width_world_180;

HW_normalized_0=HW_0./SH_0;
HW_normalized_45=HW_45./SH_45;
HW_normalized_90=HW_90./SH_90;
HW_normalized_135=HW_135./SH_135;
HW_normalized_180=HW_180./SH_180;
HW_normalized_true=HW_normalized_true.*ones(length(HW_normalized_0),1);
% HW rmse as percentage of true value.
table_1=100*[rmse(HW_normalized_0,HW_normalized_true),rmse(HW_normalized_45,HW_normalized_true),rmse(HW_normalized_90,HW_normalized_true)...
        rmse(HW_normalized_135,HW_normalized_true),rmse(HW_normalized_180,HW_normalized_true)]/HW_normalized_true(1);


SW=100*[shoulder_width_world_0,shoulder_width_world_45,shoulder_width_world_90...
    shoulder_width_world_135,shoulder_width_world_180];

SH=[SH_0,SH_45,SH_90,SH_135,SH_180];

SW_normalized_true= SW_normalized_true.*ones(length(SW(:,1)),5);
SW_normalized=zeros(length(SW(:,1)),length(SH(1,:)));
for i=1:length(SH(1,:))
    SW_normalized(:,i)=SW(:,i)./SH(:,i);
end
SW_normalized
% SW rmse as percentage of trule value
table_2=100*rmse(SW_normalized,SW_normalized_true)./SW_normalized_true(1,1);