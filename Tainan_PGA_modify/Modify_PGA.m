clc;close all;clear;
load Tainan_NE_original;
load Tainan_NE_compatible;
% ~
% find PGA of compatible earthquake
for i = 1:size(Tainan_NE_original,2)
    PGA_compatible(i) = max(abs(Tainan_NE_compatible{i}(:,2)));
    PGA_original(i) = max(abs(Tainan_NE_original{i}(:,2)));
end
% modify PGA
for i = 1:size(Tainan_NE_original,2)
    Tainan_NE_PGA_modified{i}(:,2) = (PGA_compatible(i)/PGA_original(i))*Tainan_NE_original{i}(:,2);
    Tainan_NE_PGA_modified{i}(:,1) = Tainan_NE_original{i}(:,1);
end
% check modify result
% for i = 1:size(Tainan_NE_PGA_modified,2)
%     PGA_modified(i) = max(abs(Tainan_NE_PGA_modified{i}(:,2)));
%     PGA_modified(i)
%     PGA_compatible(i)
% end
save Tainan_NE_PGA_modified;
% ~
% before far field EQ modified
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
    for n = 1:size(Tainan_NE_original,2)
        acc_tt_input = Tainan_NE_original{1,n};
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
for n = 1:size(Tainan_NE_original,2)
    plot(T,acc2(:,n)/9.81,'linewidth',2);
end
plot(T2,SaD(:),'k-','linewidth',2);
grid on;
title('before modification');
xlabel('Period (sec)');
ylabel('Acceleration (g)');
ylim([0 2.2]);
% ~
% compatible far field EQ
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
    for n = 1:size(Tainan_NE_compatible,2)
        acc_tt_input = Tainan_NE_compatible{1,n};
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
for n = 1:size(Tainan_NE_compatible,2)
    plot(T,acc2(:,n)/9.81,'linewidth',2);
end
plot(T2,SaD(:),'k-','linewidth',2);
grid on;
title('after compatible modification');
xlabel('Period (sec)');
ylabel('Acceleration (g)');
ylim([0 2.2]);
% ~
% after far field EQ modified
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
    for n = 1:size(Tainan_NE_PGA_modified,2)
        acc_tt_input = Tainan_NE_PGA_modified{1,n};
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
for n = 1:size(Tainan_NE_PGA_modified,2)
    plot(T,acc2(:,n)/9.81,'linewidth',2);
end
plot(T2,SaD(:),'k-','linewidth',2);
grid on;
title('after PGA modification');
xlabel('Period (sec)');
ylabel('Acceleration (g)');
ylim([0 2.2]);