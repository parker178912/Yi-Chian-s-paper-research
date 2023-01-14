clc;
close all;
clear;
%------------------
% load data
%------------------
load Tainan.mat
Acceleration = seismic_data;

%------------------
% Manually Select
%------------------

for ind_case = 1:15
    %==
    tt = Acceleration{1,ind_case}(:,1);
    % 1: Time
    % 2: Up/Down direction
    % 3: North/South direction
    % 4: East/West direction
    for direction = 3:4
        acc = Acceleration{1,ind_case}(:,direction);
        dt = tt(2)-tt(1);
        %~~
        % figure();
        % plot(tt,acc);
        
        %------------------
        % Pre-processing acceleration record
        %------------------
        acc = acc - acc(1);
        
        %------------------
        % Integration
        %------------------
        vel = zeros(size(acc));
        %~~
        for i = 1:(length(vel)-1)
            vel(i+1) = acc(i)*dt + vel(i);
        end
        %~~
        % figure();
        % plot(tt,vel)
        
        %------------------
        % High-pass filter
        %------------------
        ind_exe = 1;
        if ind_exe == 1
            ind_range = 1:length(vel);
            coef = polyfit(tt(ind_range),vel(ind_range),1);
            vel = vel - (tt*coef(1)+coef(2));
            vel = vel - vel(1);
            %==
            [Bf,Af] = butter(2,0.1/100,'high');
            vel = filtfilt(Bf,Af,vel);
        end
        %~~
        % figure();
        % plot(tt,vel);
        
        %------------------
        % Polynomail fitting
        %------------------
        ind_range = 1:length(vel);
        coef = polyfit(tt(ind_range),vel(ind_range),1);
        vel = vel - (tt*coef(1)+coef(2)); % this one is final
        
        %==
        % figure();
        % plot(tt,vel)
        
        %------------------
        % DFT
        %------------------
        % ff = (0:(length(tt)-1))'*1/dt/length(tt);
        % ind = find(ff<=5);
        % vel_fft = fft(vel)/length(ff);
        % %~~
        % figure();
        % plot(ff(ind),abs(vel_fft(ind)));
        % grid on;
        % xlabel('frequency (Hz)');
        % ylabel('amplitude');
        % title('Discrete Fourier Transform');
        
        %------------------
        % Wavelet
        %------------------
        wavename = 'cmor1-1';
        cf = centfrq(wavename);
        ff1 = (0.1:0.02:5);
        scale = (1/dt)*cf./ff1;
        S = cwt(vel,scale,wavename);
        %==
        figure();
        % set(gcf,'position',[50 50 1200 800]);
        subplot(2,1,1);
        hp = pcolor(tt,ff1,abs(S));colormap(flipud(bone(256)));set(hp,'edgecolor','none');
        set(gca,'xlim',[tt(1) tt(end)]);
        xlabel('time (sec)','fontsize',14);
        ylabel('frequency (Hz)','fontsize',14);
        subplot(2,1,2);
        plot(tt,vel,'b-','linewidth',2.5);
        set(gca,'xlim',[tt(1) tt(end)]);
        xlabel('time (sec)','fontsize',14);
        ylabel('velocity (m/sec)','fontsize',14);
    end
end