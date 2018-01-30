%EEE552 Project 1
%Monte-Carlo simulaiton of left 8-QAM constellation
clc;
snr = 0:0.5:12.5;         %SNR of bit in dB
SNR = 10.^(snr./10);%SNR in linear scale
p1 = [];            %Simulation Pe
pl1 = [];           %Lower bound
ph1 = [];           %Upper bound
for k = SNR
    p1  = [p1 QAM2(1,3*k)];
    dmin2 = 3*k*4/(3+sqrt(3)); %Minimum distance
    pl1 = [pl1 qfunc(sqrt(dmin2/2))];
    ph1 = [ph1 3*qfunc(sqrt(dmin2/2))];
    size(p1)/size(SNR)
end
%Plot Pe curve of p1,pl,ph
semilogy(snr,p1);
hold on;
semilogy(snr,pl1,'--');
semilogy(snr,ph1,'-.');
semilogy(snr,ph1-p1,'k:+');
hold on;
legend('simulation Pe','Lower bound','Upper bound','upper bound-Pe');
xlabel('eb/N0');ylabel('Pe');
title('Figure 3.2-4(left) 8-QAM constellation');
%Monte-Carlo simulation of fat 8-QAM constellation
snr = 0:0.5:12.5;         %SNR of bit in dB
SNR = 10.^(snr./10);%SNR in linear scale
p2 = [];            %Simulation Pe
pl2 = [];           %Lower bound
ph2 = [];           %Upper bound
for k = SNR
    p2  = [p2 QAM2(2,3*k)];
    dmin2 = 2*k;    %Minimum distance
    pl2 = [pl2 qfunc(sqrt(dmin2/2))];
    ph2 = [ph2 5/2*qfunc(sqrt(dmin2/2))];
    size(p2)/size(SNR)
end
%Plot Pe curve of p2,pl,ph
figure(2);
semilogy(snr,p2);
hold on;
semilogy(snr,pl2,'--');
semilogy(snr,ph2,'-.');
semilogy(snr,ph2-p2,'k+:');
hold on;
legend('simulation Pe','Lower bound','Upper bound','upper bound-Pe');
xlabel('eb/N0');ylabel('Pe');
title('Figure 3.2-5(fat) 8-QAM constellation');
%Plot of comparation of two different simulation Pe
figure(3);
semilogy(snr,p1);     %Pe of left 8-QAM
hold on;
semilogy(snr,p2,'--');%Pe of fat 8-QAM
hold on;
legend('left 8-QAM','fat 8-QAM');
xlabel('eb/N0');ylabel('Pe');
title('Comparison of two different constellations');