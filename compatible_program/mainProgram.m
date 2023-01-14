function mainProgram
clear all;close all;clc;

fileName = '1998_0816_111303_CHY021.txt';
filePath = [pwd '\'];
headerlines = '11';
scalingFactor = '1.0';
selectedScaling = 1;
selectedLoadCase = 0;

structuralPeriod = '1.0';
structuralDamping = '0.05';
lowBound = '0.2';
highBound = '1.5';
highFix = '1.1';
maxIter = '100';
iterRatio = '0.5';
locationCheck = 0;
isolatedCheck = 0;

considerCase = 1;
SsD = '0.4';
S1D = '0.2';
Na = '1.0';
Nv = '1.0';
Fa = '1.0';
Fv = '1.0';

T0D = 0;
g = 9.80665;

page1ok = 0;
page2ok = 0;
page3ok = 0;
page4ok = 0;
%%
while (page1ok == 0 || page2ok == 0 || page3ok == 0 || page4ok == 0)
%% Page1
if page1ok == 0
    [fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase,w,W,time,scaling,Unit] = page1(fileName,filePath,headerlines,scalingFactor,selectedScaling,selectedLoadCase);

	figure(2)
	plot(time,w/str2double(scalingFactor),'r','LineWidth',1.5);grid on;
	set(gca,'fontsize',12);
    xlabel('time (sec)','FontSize',14);
    if selectedScaling == 3
        ylabel('Ground acceleration','fontsize',14);
    else
        ylabel(['Ground acceleration (' Unit ')'],'fontsize',14);
    end
    title('Earthquake time history','fontSize',18);
    [Max_y,Max_x] = max(abs(w/str2double(scalingFactor)));
    textname=['\leftarrow (' num2str(time(Max_x)) 'sec, ' num2str(w(Max_x)/str2double(scalingFactor),'%10.2f') Unit ')'];
    text(time(Max_x),w(Max_x)/str2double(scalingFactor),textname,'HorizontalAlignment','left','fontsize',14);

    dt = time(2)-time(1);
    timeStep = num2str(dt);
    page1ok = 1;
end

%% Page2
if page2ok == 0
    [structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck,prePage] = page2(structuralPeriod,structuralDamping,lowBound,highBound,highFix,maxIter,iterRatio,timeStep,locationCheck,isolatedCheck);
    
    if prePage == 1
        page1ok = 0;
        continue
    end
    timeStep = str2double(timeStep);
    newTime = 0:timeStep:time(end);
    newRecord = zeros(length(newTime),1);
    dt = timeStep;

    index = 1;
    for k = 1:length(newTime)
        for kk = index:length(time)
            if newTime(k) <= time(kk+1)
                newRecord(k,1) = (newTime(k)-time(kk))/(time(kk+1)-time(kk))*w(kk+1) + (time(kk+1)-newTime(k))/(time(kk+1)-time(kk))*w(kk);
                index = kk;
                break;
            end
        end
    end

    figure(3)
    plot(time,w,'b',newTime,newRecord,'r','LineWidth',1.5);grid on;
    set(gca,'fontsize',12);
    xlabel('time (sec)','FontSize',14);
    if selectedScaling == 3
        ylabel('Ground acceleration','fontsize',14);
    else
        ylabel(['Ground acceleration (' Unit ')'],'fontsize',14);
    end
    title('Earthquake time history','fontSize',18);
    legend('Original earthquake time-history','Sampled earthquake time-history');

    time = newTime;
    w = newRecord;
    W = newRecord;

    if mod(length(time),2) == 1
        time(end) = [];
        w(end) = [];
        W(end) = [];
    end
    page2ok = 1;
end

%% Page3
if page3ok == 0
    if locationCheck == 0
        [SsD,S1D,Fa,Fv,Na,Nv,considerCase,prePage] = page3(SsD,S1D,Fa,Fv,Na,Nv,considerCase);
        if prePage == 1
            page2ok = 0;
            page4ok = 0;
            continue
        end
        S_DS = str2double(SsD)*str2double(Fa)*str2double(Na);
        S_D1 = str2double(S1D)*str2double(Fv)*str2double(Nv);
        T0D = S_D1/S_DS;
    end
    page3ok = 1;
end

%% Page4
if page4ok == 0
    if locationCheck == 1
        [considerCase,S_DS,T0D,selected_area,prePage] = page4(considerCase,T0D);
        if prePage == 1
            page3ok = 0;
            page2ok = 0;
            continue
        end
    end
    page4ok = 1;
end

%% �]�p������
f = (1/dt)/2*linspace(0,1,length(time)/2);
df = f(2)-f(1);
T = 1./f;
T(1) = 10^10; % replace T(1) = inf

S_aD = zeros(1,length(T));

for k = 1:length(T)
    if T(k) <= 0.2*T0D
        S_aD(k) = S_DS*(0.4+3*T(k)/T0D);
    end
    if T(k) > 0.2*T0D && T(k) <= T0D
        S_aD(k) = S_DS;
    end
    if T(k) > T0D && T(k) <= 2.5*T0D
        S_aD(k) = S_DS*T0D/(T(k));
    end
    if T(k) > 2.5*T0D
        if isolatedCheck == 0;
            S_aD(k) = 0.4*S_DS;
        else
            S_aD(k) = S_DS*T0D/(T(k));  % for design isolator.
        end
    end
end

SaD = S_aD*g*100;

figure(4)
subplot(2,1,1)
plot(T,S_aD,'LineWidth',2.5);grid on;
set(gca,'fontsize',12); 
xlabel('Period (sec)','fontsize',14);
ylabel('Acceleration (g)','fontsize',14);
if considerCase == 1
    title('Design Spectrum','fontsize',18);
else
    title('Maximum Considered Spectrum','fontsize',18);
end
axis([0;10;0;1.2*S_DS])

subplot(2,1,2)
plot(T,SaD,'LineWidth',2.5);grid on;
set(gca,'fontsize',12); 
xlabel('Period (sec)','fontsize',14);
ylabel('Acceleration (cm/sec^2)','fontsize',14);
axis([0;10;0;1.2*max(SaD)])

if locationCheck == 0
    if considerCase == 1
        StartString = {['�a�_���ɡG' fileName];
        ['���ɳ��G' scaling];
        ['���c�g���G' structuralPeriod];
        ['���c������G' structuralDamping];
        ['�u�g���]�p�����Х[�t�׫Y��SsD�G' SsD];
        ['1��g���]�p�����Х[�t�׫Y��S1D�G' S1D];
        ['���[�t�׬q�u�}��j�Y��Fa�G' Fa];
        ['�п�J���t�׬q�u�}��j�Y��Fv�G' Fv];
        ['���[�t�׬q���_�h�վ�]�lNa�G' Na];
        ['���t�׬q���_�h�վ�]�lNv�G' Nv];
        [''];
        [''];
        ['���Uok��}�l�i���ഫ�AFigure(5)�[���ഫ���ΡC']};
    else
        StartString = {['�a�_���ɡG' fileName];
        ['���ɳ��G' scaling];
        ['���c�g���G' structuralPeriod];
        ['���c������G' structuralDamping];
        ['�u�g���̤j�Ҷq�����Х[�t�׫Y��SMS�G' SsD];
        ['1��g���̤j�Ҷq�����Х[�t�׫Y��SM1�G' S1D];
        ['���[�t�׬q�u�}��j�Y��Fa�G' Fa];
        ['�п�J���t�׬q�u�}��j�Y��Fv�G' Fv];
        ['���[�t�׬q���_�h�վ�]�lNa�G' Na];
        ['���t�׬q���_�h�վ�]�lNv�G' Nv];
        [''];
        [''];
        ['���Uok��}�l�i���ഫ�AFigure(5)�[���ഫ���ΡC']};
    end
    
else
    if considerCase == 1
        StartString = {['�a�_���ɡG' fileName];
        ['���ɳ��G' scaling];
        ['���c�g���G' structuralPeriod];
        ['���c������G' structuralDamping];
        ['�O�_�֦a�G' selected_area];
        ['�u�g���]�p�����Х[�t�׫Y��SDS�G0.6'];
        [''];
        [''];
        ['���Uok��}�l�i���ഫ�AFigure(5)�[���ഫ���ΡC']};
    else
        StartString = {['�a�_���ɡG' fileName];
        ['���ɳ��G' scaling];
        ['���c�g���G' structuralPeriod];
        ['���c������G' structuralDamping];
        ['�O�_�֦a�G' selected_area];
        ['�u�g���̤j�Ҷq�����Х[�t�׫Y��SMS�G0.8'];
        [''];
        [''];
        ['���Uok��}�l�i���ഫ�AFigure(5)�[���ഫ���ΡC']};
    end
end

startQuestionDialog = questdlg(StartString,'Continue?','OK','Cancel','OK');
if strcmp(startQuestionDialog,'Cancel')
    if locationCheck == 0
        page3ok = 0;
        page4ok = 0;
        continue
    end
    if locationCheck == 1
        page4ok = 0;
        continue
    end
elseif strcmp(startQuestionDialog,'')
    return
end

%% while end
end

%%
tic
T0 = str2double(structuralPeriod);
Zetas = str2double(structuralDamping);
lowBound = str2double(lowBound);
highBound = str2double(highBound);
highFix = str2double(highFix);
maxIter = str2double(maxIter);
iterRatio = str2double(iterRatio);

SaD_spectrum = zeros(1,length(T));
e = [0;-1];
% fix:�L����˥h�p�ơFceil:�L����i��
Low = ceil(1/(lowBound*T0)/df)+1; 
High = ceil(1/(highBound*T0)/df);

Low2 = ceil(1/(lowBound*T0)/df)+21; %Low period bound index add 20 point
High2 = ceil(1/(highBound*T0)/df)-10; %High period bound index ad 10 point

if Low > length(T)
    Low = length(T);
end
if Low2 > length(T)
    Low2 = length(T);
end
if High < 1
    High = 1;
end
if High2 < 1
    High2 = 1;
end

%-----Sclae Peak ground motion----%
w=w./max(abs(w))*0.4*S_DS*g*100;
check_index = 0;

calculatedAlgorithm = 1;
try
    zd = zeros(length(time),length(T(High2:Low2)));
    zv = zeros(length(time),length(T(High2:Low2)));
    abs_acc = zeros(length(time),length(T(High2:Low2)));
    SaD_spectrum(High2:Low2) = max(abs(abs_acc));
    w0 = (2*pi./T(High2:Low2));
    wd = (sqrt(1-Zetas^2)*2*pi./T(High2:Low2));
    a11 = exp(-Zetas*w0*dt).*(cos(wd*dt) + Zetas*sqrt(1-Zetas^2).*sin(wd*dt));
    a12 = exp(-Zetas*w0*dt).*sin(wd*dt)./wd;
    a21 = -w0/sqrt(1-Zetas^2).*exp(-Zetas.*w0*dt).*sin(wd*dt);
    a22 = exp(-Zetas*w0*dt).*(cos(wd*dt) - Zetas*sqrt(1-Zetas^2).*sin(wd*dt));
    b1 = 1./w0.^2-1./w0.^2.*exp(-Zetas*w0*dt).*(cos(wd*dt)+Zetas/sqrt(1-Zetas^2).*sin(wd*dt));
    b2 = 1./wd.*exp(-Zetas*w0*dt).*sin(wd*dt);
catch
	errorinformation = lasterror;
    if strcmp(errorinformation.identifier,'MATLAB:nomem')
        errorMessageBox = msgbox('�O����Ŷ�����! �N�ϥλݭn���ְO���餧�t��k(�ɶ�����)�C           .','WARNING!','warn');
        uiwait(errorMessageBox);
    end
    
    clear zd zv abs_acc w0 wd a11 a12 a21 a22 b1 b2
    calculatedAlgorithm = 0;
end
set(figure(1),'Visible','off');
close(figure(1));

for kk = 1:maxIter % max�ץ�����
    if calculatedAlgorithm == 1
        for k = 1:length(time)-1
            zd(k+1,:) = a11.*zd(k,:) + a12.*zv(k,:) + b1*w(k);
            zv(k+1,:) = a21.*zd(k,:) + a22.*zv(k,:) + b2*w(k);
            abs_acc(k,:) = -zd(k,:).*w0.^2 - 2*Zetas*zv(k,:).*w0;
        end
        SaD_spectrum(High2:Low2) = max(abs(abs_acc));
        
        clc    
        disp('iteration number:')
        disp(kk)
    else
        z = zeros(2,length(time));
        for p = High2:Low2
            A=[0 1;-(2*pi/T(p))^2 -2*Zetas*(2*pi/T(p))];
            Ad=expm(A*dt);
            Ed=inv(A)*(Ad-eye(2))*e;
            z(:,1)=[0;0];
            for k = 1:length(time)-1
                z(:,k+1) = Ad*z(:,k)+Ed*w(k);
            end
            Abs_Acc = [-(2*pi/T(p))^2 -2*Zetas*(2*pi/T(p))]*z;
            SaD_spectrum(p) = max(abs(Abs_Acc));
                
            clc    
            disp('iteration number:')
            disp(kk)
            disp('achieved percentage(%):')
            disp((p-High2+1)/length(High2:Low2)*100)
        end        
    end
       
    %-----Check Every Point----%
    for p = High:Low
        if SaD_spectrum(p) > 0.9*SaD(p) && SaD_spectrum(p) < highFix*SaD(p)
            check_index = 1;
        else
            check_index = 0;
            break
        end
    end
    
    if check_index == 0
        w_fft = fft(w);
        w_fft(High2:Low2)=(1+iterRatio*(SaD(High2:Low2)-SaD_spectrum(High2:Low2))./SaD(High2:Low2))'.*w_fft(High2:Low2);
        w_fft(end:-1:length(w_fft)/2+2) = conj(w_fft(2:length(w_fft)/2));
        w=ifft(w_fft);
    end

    if check_index == 1
        %-----Check SUM----%
        if sum(SaD_spectrum(High:Low)) < sum(SaD(High:Low))
            w=(sum(SaD(High:Low))/sum(SaD_spectrum(High:Low)))*w;
            check_index = 2;
        else
            break
        end
    end
    
    figure(5)
    set(figure(5),'Resize','off');
    plot(T,SaD,T,SaD_spectrum,T,0.9*SaD,'-.',T,highFix*SaD,'-.','LineWidth',2.5);
    set(gca,'fontsize',12);
    xlabel('Period (sec)','fontsize',14);
    ylabel('Acceleration (cm/sec^2)','fontsize',14);
    if considerCase == 1
        title('Modifing Earthquake to Design Spectrum','fontsize',18);
    else
        title('Modifing Earthquake to Maximum Considered Spectrum','fontsize',16);
    end
    axis([lowBound*T0;highBound*T0;0;(highFix+0.1)*S_DS*g*100])
    set(figure(11),'Visible','off');
    set(figure(12),'Visible','off');
end

%% �a�_������
for k = 1:length(T)
    if T(k) >= 1.0 && T(k+1) <= 1.0
        index1 = k;
    end
    if T(k) >= 10 && T(k+1) <= 10
        index2 = k;
    end
end
period = [0.0001 0.01:0.01:1 T(index1:-1:index2)];
Acc_spectr = zeros(1,length(period));
Ori_spectr = zeros(1,length(period));

calculatedAlgorithm = 1;
try
    zd = zeros(length(time),length(period));
    Zd = zeros(length(time),length(period));
    zv = zeros(length(time),length(period));
    Zv = zeros(length(time),length(period));
    Abs_Acc = zeros(length(time),length(period));
    Abs_ACC = zeros(length(time),length(period));
    Acc_spectr = max(abs(Abs_Acc));
    Ori_spectr = max(abs(Abs_ACC));
    w0 = (2*pi./period);
    wd = (sqrt(1-Zetas^2)*2*pi./period);
    a11 = exp(-Zetas*w0*dt).*(cos(wd*dt) + Zetas*sqrt(1-Zetas^2).*sin(wd*dt));
    a12 = exp(-Zetas*w0*dt).*sin(wd*dt)./wd;
    a21 = -w0/sqrt(1-Zetas^2).*exp(-Zetas.*w0*dt).*sin(wd*dt);
    a22 = exp(-Zetas*w0*dt).*(cos(wd*dt) - Zetas*sqrt(1-Zetas^2).*sin(wd*dt));
    b1 = 1./w0.^2-1./w0.^2.*exp(-Zetas*w0*dt).*(cos(wd*dt)+Zetas/sqrt(1-Zetas^2).*sin(wd*dt));
    b2 = 1./wd.*exp(-Zetas*w0*dt).*sin(wd*dt);
catch
    clear zd Zd zv Zv Abs_Acc Abs_ACC w0 wd a11 a12 a21 a22 b1 b2
    calculatedAlgorithm = 0;
end

if calculatedAlgorithm == 1;
    for k = 1:length(time)-1
        zd(k+1,:) = a11.*zd(k,:) + a12.*zv(k,:) + b1*w(k);
        zv(k+1,:) = a21.*zd(k,:) + a22.*zv(k,:) + b2*w(k);
        Abs_Acc(k,:) = -zd(k,:).*w0.^2 - 2*Zetas*zv(k,:).*w0;
        
        Zd(k+1,:) = a11.*Zd(k,:) + a12.*Zv(k,:) + b1*W(k);
        Zv(k+1,:) = a21.*Zd(k,:) + a22.*Zv(k,:) + b2*W(k);
        Abs_ACC(k,:) = -Zd(k,:).*w0.^2 - 2*Zetas*Zv(k,:).*w0;
    end
	Acc_spectr = max(abs(Abs_Acc));
    Ori_spectr = max(abs(Abs_ACC));
    
	clc;
	disp('Max iteration number:')
	disp(kk)
else
    z = zeros(2,length(time));
    Z = zeros(2,length(time));
    
    for p = 1:length(period)
        A=[0 1;-(2*pi/period(p))^2 -2*Zetas*(2*pi/period(p))];
        Ad=expm(A*dt);
        Ed=inv(A)*(Ad-eye(2))*e;
        z(:,1)=[0;0];
        Z(:,1)=[0;0];
        for k = 1:length(time)-1
            z(:,k+1) = Ad*z(:,k)+Ed*w(k);
            Z(:,k+1) = Ad*Z(:,k)+Ed*W(k);
        end
        Abs_Acc = [-(2*pi/period(p))^2 -2*Zetas*(2*pi/period(p))]*z;
        Acc_spectr(1,p) = max(abs(Abs_Acc));
        Abs_ACC = [-(2*pi/period(p))^2 -2*Zetas*(2*pi/period(p))]*Z;
        Ori_spectr(1,p) = max(abs(Abs_ACC));
        
        clc;
        disp('Max iteration number:')
        disp(kk)
        disp('final achieved percentage(%):')
        disp(p/length(period)*100)
    end
end

set(figure(6),'Position',[50 50 1200 650]);
plot(T,SaD,period,Acc_spectr,period,Ori_spectr,T,0.9*SaD,'-.',T,highFix*SaD,'-.',[lowBound*T0 lowBound*T0],[0 2*max(SaD)],'--',[highBound*T0 highBound*T0],[0 2*max(SaD)],'--','LineWidth',2.5);
set(gca,'fontsize',18);
xlabel('Period (sec)','fontsize',18);
ylabel('Acceleration (cm/sec^2)','fontsize',18);
if considerCase == 1
    title('Modify Earthquake to Design Spectrum','fontsize',22);
    legend('Design Spectrum','Modified Spectrum','Oringinal Spectrum','0.9*Design Spectrum',[num2str(highFix) '*Design Spectrum']);
else
    title('Modify Earthquake to Maximum Considered Spectrum','fontsize',22);
    legend('Maximum Considered Spectrum','Modified Spectrum','Oringinal Spectrum','0.9*Maximum Considered Spectrum',[num2str(highFix) '*Maximum Considered Spectrum']);
end
axis([0;10;0;(highFix+0.1)*S_DS*g*100])

set(figure(7),'Position',[50 50 1200 650]);
plot(T,SaD/100,period,Acc_spectr/100,period,Ori_spectr/100,T,0.9*SaD/100,'-.',T,highFix*SaD/100,'-.',[lowBound*T0 lowBound*T0],[0 2*max(SaD)/100],'--',[highBound*T0 highBound*T0],[0 2*max(SaD)/100],'--','LineWidth',2.5);
set(gca,'fontsize',18);
xlabel('Period (sec)','fontsize',18);
ylabel('Acceleration (m/sec^2)','fontsize',18);
if considerCase == 1
    title('Modify Earthquake to Design Spectrum','fontsize',22);
    legend('Design Spectrum','Modified Spectrum','Oringinal Spectrum','0.9*Design Spectrum',[num2str(highFix) '*Design Spectrum']);
else
    title('Modify Earthquake to Maximum Considered Spectrum','fontsize',22);
    legend('Maximum Considered Spectrum','Modified Spectrum','Oringinal Spectrum','0.9*Maximum Considered Spectrum',[num2str(highFix) '*Maximum Considered Spectrum']);
end
axis([0;10;0;(highFix+0.1)*S_DS*g])

w = w/str2double(scalingFactor);
W = W/str2double(scalingFactor);
%%
figure(8)
plot(time,w,'r','LineWidth',1.5);grid on;
set(gca,'fontsize',12);
xlabel('time (sec)','FontSize',14);
if selectedScaling == 3
    ylabel('Ground acceleration','fontsize',14);
else
    ylabel(['Ground acceleration (' Unit ')'],'fontsize',14);
end
title('Modified earthquake time history','fontSize',18);
[Max_y,Max_x] = max(abs(w));
textname=['\leftarrow (' num2str(time(Max_x)) 'sec, ' num2str(w(Max_x),'%10.2f') Unit ')'];
text(time(Max_x),w(Max_x),textname,'HorizontalAlignment','left','fontsize',14);

figure(9)
plot(time,w,'r',time,W,'b','LineWidth',1.5);grid on;
set(gca,'fontsize',12);
xlabel('time (sec)','FontSize',14);
if selectedScaling == 3
    ylabel('Ground acceleration','fontsize',14);
else
    ylabel(['Ground acceleration (' Unit ')'],'fontsize',14);
end
title('Earthquake time history','fontSize',18);
legend('Modified','Original');

%% Write Out
if considerCase == 1
    fileID = fopen([fileName '(modify_design).txt'],'wt');
    for k = 1:length(time)
        fprintf(fileID,'%10.4f  %10.4f\n',time(k),w(k));
    end
    fclose(fileID);

    if kk == maxIter
        warnString = {['�F��̤j���N���ơA�ഫ�����ɦs��' fileName '(modify_design).txt           .'];['�p��ɶ��G' num2str(fix(toc/60), '%d\n') ' min ' num2str(mod(toc,60), '%2.0f') ' sec']};
        msgbox(warnString,'WARNING!','warn');
    else
        completeString = {['�ഫ�����A�ഫ�����ɦs��' fileName '(modify_design).txt           .'];['�p��ɶ��G' num2str(fix(toc/60), '%d\n') ' min ' num2str(mod(toc,60), '%2.0f') ' sec']};
        msgbox(completeString,'OK!','warn');
    end
else
    fileID = fopen([fileName '(modify_maximum).txt'],'wt');
    for k = 1:length(time)
        fprintf(fileID,'%10.4f  %10.4f\n',time(k),w(k));
    end
    fclose(fileID);

    if kk == maxIter
        warnString = {['�F��̤j���N���ơA�ഫ�����ɦs��' fileName '(modify_maximum).txt           .'];['�p��ɶ��G' num2str(fix(toc/60), '%d\n') ' min ' num2str(mod(toc,60), '%2.0f') ' sec']};
        msgbox(warnString,'WARNING!','warn');
    else
        completeString = {['�ഫ�����A�ഫ�����ɦs��' fileName '(modify_maximum).txt           .'];['�p��ɶ��G' num2str(fix(toc/60), '%d\n') ' min ' num2str(mod(toc,60), '%2.0f') ' sec']};
        msgbox(completeString,'OK!','warn');
    end
end

fprintf('calculated time: %d min %2.0f sec\n', fix(toc/60), mod(toc,60))