%% Extract data from sim_results.txt
fname = '.\simulation\ZynqBF_2tx_sim.sim\sim_1\behav\xsim\sim_results.txt';
% data_in = readResults(fname);
data_in = csvread(fname);

%% Extract variables from data and convert to fixed point and then double
xcorr1 = 0.5*data_in(:,1)/(2^15);
xcorr2 = 0.5*data_in(:,2)/(2^15);
state = data_in(:,3);
% ch1_i = 0.5*data_in(:,4)/(2^15);
% ch1_q = 0.5*data_in(:,5)/(2^15);
% ch1_r = 0.5*data_in(:,6)/(2^15);
ch1_i = data_in(:,4)/(2^15);
ch1_q = data_in(:,5)/(2^15);
ch1_r = data_in(:,6)/(2^15);

ch1i = ch1_i*max(ch1_r);
ch1q = ch1_q*max(ch1_r);

t = (1/(128*420e3))*(1:numel(state));

%% Plots
figure(20); clf;
c = get(gca,'colororder');
c1 = c(1,:);
c2 = c(2,:);
c3 = c(3,:);
c4 = c(4,:);
c5 = c(5,:);
c6 = c(6,:);

xmin = 4e-3;
% xmin = min(t);

subplot(311); hold all;
plot(t,state, '.-', 'color', c1);
set(gca, 'fontsize', 10);
title('FPGA State', 'fontweight', 'bold', 'fontsize', 16);
% ylabel('Enabled/Disabled', 'fontweight', 'bold', 'fontsize', 12);
set(gca,'ytick', [0 1 2]);
set(gca,'yticklabel',{'Peak Detect', 'Estimate Channel', 'Reset'});
set(gca,'xlim', [xmin max(t)]);
% leg = legend('Peak Detect', 'Estimate Channel', 'location', 'west');
% leg.FontSize = 12;

subplot(312); hold all;
plot(t,xcorr1,'.-', 'color', c3);
plot(t,xcorr2,'.-', 'color', c4);
set(gca,'xlim', [xmin max(t)]);
set(gca, 'fontsize', 10);
title('Gold Sequence Cross-Correlators', 'fontweight', 'bold', 'fontsize', 16);
ylabel('Xcorr [a.u.]', 'fontweight', 'bold', 'fontsize', 16);
leg = legend('Channel 1', 'Channel 2', 'location', 'northwest');
leg.FontSize = 12;

subplot(313); hold all;
plot(t,ch1i,'.-', 'color', c6);
plot(t,ch1q,'.-', 'color', c5);
set(gca,'xlim', [xmin max(t)]);
set(gca, 'fontsize', 10);
title('Channel 1 CSI', 'fontweight', 'bold', 'fontsize', 16);
ylabel('CSI [a.u.]', 'fontweight', 'bold', 'fontsize', 16);
xlabel('Time [s]', 'fontweight', 'bold', 'fontsize', 16);
leg = legend('Ch1 i', 'Ch1 q', 'location', 'west');
leg.FontSize = 12;
