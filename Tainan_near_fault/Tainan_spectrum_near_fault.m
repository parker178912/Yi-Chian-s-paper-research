clc;close all;clear;
load Tainan;
Tainan_near_fault{1} = seismic_data{8}(:,[1 3]);
Tainan_near_fault{2} = seismic_data{8}(:,[1 4]);
Tainan_near_fault{3} = seismic_data{9}(:,[1 3]);
Tainan_near_fault{4} = seismic_data{9}(:,[1 4]);
Tainan_near_fault{5} = seismic_data{10}(:,[1 3]);
Tainan_near_fault{6} = seismic_data{10}(:,[1 4]);
Tainan_near_fault{7} = seismic_data{14}(:,[1 3]);
Tainan_near_fault{8} = seismic_data{14}(:,[1 4]);
Tainan_near_fault{9} = seismic_data{15}(:,[1 3]);
Tainan_near_fault{10} = seismic_data{15}(:,[1 4]);
clear data;
save Tainan_near_fault.mat Tainan_near_fault;
% ~
T = (0.05:0.05:5)';
w = 2*pi./T;
m = 1;
dmp = 0.05;
% ~
for i = 1:size(T,1)
    k = w(i)^2*m;
    c = 2*m*dmp*w(i);
    Ac = [0 1;-k/m -c/m];
    Bc = [0;-1];
    Cc = [eye(2);-k/m -c/m];
    Dc = zeros(3,1);
    sys_SDOF = ss(Ac,Bc,Cc,Dc);
    for n = 1:size(Tainan_near_fault,2)
        acc_tt_input = Tainan_near_fault{1,n};
        acc_input = acc_tt_input(:,2);
        tt = acc_tt_input(:,1);
        y_SDOF = lsim(sys_SDOF,acc_input,tt);
        acc2(i,n) = max(abs(y_SDOF(:,3)));
    end
end
SDS = 0.8;
SD1 = 0.4;
T0D = SD1/SDS;
T2 = (0.01:0.01:5)';
for i = 1:size(T2,1)
    ttt = T2(i);
    if ttt <= 0.2*T0D
        SaD(i) = SDS*(0.4+3*ttt/T0D);
    end
    if ttt >= 0.2*T0D && ttt <= T0D
        SaD(i) = SDS;
    end
    if T2(i) >= T0D
        SaD(i) = SDS*T0D/ttt;
    end
end
figure();
hold on;
for n = 1:10
    plot(T,acc2(:,n)/9.81,'linewidth',2);
end
plot(T2,SaD(:),'k-','linewidth',2);
grid on;
title('Spectrum of Tainan District');
xlabel('Period (sec)');
ylabel('Acceleration (g)');