import mlreportgen.dom.*
%duration=[0,25]; %viewing angles 1
% duration=[0,28]; % viewing angles 50

duration=[15,30,50,65,150,165]; %sides distance

% duration=[50,80,130,160,200,230]; %depth distance
fps=25;
SH_true= 52.5;
HW_true= 23.5;
SW_true= 34;

X=[world_x(frame>fps*duration(1) &frame<fps*duration(2)),...
    world_x(frame>25*duration(3) &frame<25*duration(4)),...
    world_x(frame>25*duration(5) &frame<25*duration(6)),...
    % world_x3(frame>25*duration(1) &frame<25*duration(2)),...
    % world_x4(frame>25*duration(1) &frame<25*duration(2))];
    ];

Y=[world_y(frame>25*duration(1) &frame<25*duration(2)),...
    world_y(frame>25*duration(3) &frame<25*duration(4)),...
    world_y(frame>25*duration(5) &frame<25*duration(6)),...
    % world_y3(frame>25*duration(1) &frame<25*duration(2)),...
    % world_y4(frame>25*duration(1) &frame<25*duration(2))];
    ];

Z=[world_z(frame>25*duration(1) &frame<25*duration(2)),...
    world_z(frame>25*duration(3) &frame<25*duration(4)),...
    world_z(frame>25*duration(5) &frame<25*duration(6)),...
    % world_z3(frame>25*duration(1) &frame<25*duration(2)),...
    % world_z4(frame>25*duration(1) &frame<25*duration(2))];
    ];

key=keypoint(frame>25*duration(1) &frame<25*duration(2));

S=zeros(length(X(key==1,1)),length(X(1,:)),33,3);

for k=1:33
    for j=1:length(X(1,:))
        S(:,j,k,1)=X(key==k-1,j);
        S(:,j,k,2)=Y(key==k-1,j);
        S(:,j,k,3)=Z(key==k-1,j);
    end
end

k=[11,12,23,24,25,26,27,28];

for j=1:length(X(1,:))
    for i=1:length(k)
        %for w=0:2 S(w*230:w+1*230)
        x_spr(j,i)=1000*SpR(S(:,j,k(i)+1,1));
        y_spr(j,i)=1000*SpR(S(:,j,k(i)+1,2));
        z_spr(j,i)=1000*SpR(S(:,j,k(i)+1,3));
        d=sqrt(sum(S(:,j,k(i)+1,:).^2,4));
        % d=sqrt(S(:,j,k(i)+1,1).^2+S(:,j,k(i)+1,2).^2+S(:,j,k(i)+1,3).^2);
        d_spr(j,i)=1000*SpR(d);

        x_qom(j,i)=1000*QoM(S(:,j,k(i)+1,1),fps);
        y_qom(j,i)=1000*QoM(S(:,j,k(i)+1,2),fps);
        z_qom(j,i)=1000*QoM(S(:,j,k(i)+1,3),fps);
        d_qom(j,i)=1000*QoM(d,fps);
    end
end

%% write Spr and QoM tables to document%%

file="result_tables_viewing_angles_1";


% Open the document outside the loop
% d = Document(file, 'docx');
% open(d);
% 
% data={x_spr,y_spr,z_spr,d_spr,x_qom,y_qom,z_qom,d_qom}; %select data to be written
% headerLabels = name(k+1)'; % define headers of each column
% tablenames={'x_spr','y_spr','z_spr','d_spr','x_qom','y_zom','z_qom','d_qom'};
% 
% for i = 1:numel(data)
%     % Get the table data from the current cell
%     tableData = data{i};
% 
%     % Call writeTableToDocument function for the current table
%     writeTableToDocument(tableData, headerLabels, d,tablenames{i});
% end
% 
% close(d)
% rptview(d)

%% Figures widths
%shoulder wdith world
shoulder_width= 100*sqrt(sum((S(:,:,12,:) - S(:,:,13,:)).^2,4));

%hip width normal
hip_width= 100*sqrt(sum((S(:,:,24,:) - S(:,:,25,:)).^2,4));

figure(Name='shoulder width world @ viewing angles 1%');
boxchart(shoulder_width)
title('shoulder width world @ viewing angles 50%');
xlabel('viewing angle of camera');
xticklabels({'0','45','90','135','180'});
yline(SW_true, 'r--', 'LineWidth', 4);
ylabel('distance in cm');
% saveas(gcf,'shoulder_width_world_va_1.fig')
% 
figure(Name='hip width world @ viewing angles 1%');
boxchart(hip_width)
title('hip width world @ viewing angles 1%');
xlabel('viewing angle of camera');
xticklabels({'0','45','90','135','180'});
yline(HW_true, 'r--', 'LineWidth', 4);
ylabel('distance in cm');
% saveas(gcf,'hip_width_world_va_1.fig')


%% RMSE tables
SH=(100*sqrt(sum((S(:,:,12,:) - S(:,:,24,:)).^2,4))+100*sqrt(sum((S(:,:,13,:) - S(:,:,25,:)).^2,4)))/2;



HW_normalized_true= HW_true/SH_true*ones(size(SH));
SW_normalized_true=SW_true/SH_true*ones(size(SH));
HW_normalized=hip_width./SH;
SW_normalized=shoulder_width./SH;

rmse_hip=100*rmse(HW_normalized,HW_normalized_true)./HW_normalized_true(1,1);
rmse_shoulder=100*rmse(SW_normalized,SW_normalized_true)./SW_normalized_true(1,1);

% data={x_spr,y_spr,z_spr,d_spr,x_qom,y_qom,z_qom,d_qom}; %select data to be written
% headerLabels = name(k+1)'; % define headers of each column
% tablenames={'x_spr','y_spr','z_spr','d_spr','x_qom','y_zom','z_qom','d_qom'};

