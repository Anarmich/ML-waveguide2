% sigma1 = -2:0.3:1;
% sigma2 = -4.8:0.3:0;
clear clc

% sigma1 = 1;
% sigma2 = 0;

sigma_interval = 20;
sigma1 = -2:(2-(-2))/sigma_interval:2;
sigma2 = -2:(2-(-2))/sigma_interval:2;
al = 2;
theta = [1 2 3 4 5]*pi/6;
Ap = 0.2*[1 2 3 4];
zeta_physical = 0.01;
N = 400;
N_peak = 1;
ep = [0.2 0.4 0.6 0.8];
eta = 1;
D = 1;
p = 4;
% sigma_f = -1:0.1:1;

y0_IC = zeros(4*N,1);
options=odeset('Reltol',1e-8,'Abstol',1e-8);
tic
parfor i_Ap = 1:size(Ap,2)
    for i_theta = 1:size(theta,2)
for kk = 1:size(ep,2)
    d = ep(kk)*D;
    T_Fac = (0.05/ep(kk));
    Tspan1 = 0:0.5*T_Fac:7500*T_Fac;
    Tspan2 = 7500*T_Fac:0.5*T_Fac:15000*T_Fac;
    Tspan = 0:0.5*T_Fac:15000*T_Fac;
for i = 1:size(sigma1,2)
    for j = 1:size(sigma2,2)
        if (d*sigma1(i)>-1 && d*sigma2(j)>-1)
        Cur_para = [d;sigma1(i);sigma2(j);Ap(i_Ap);theta(i_theta)];
        zeta = zeta_physical/d;
    [~,Y1]=ode45(@(t,y) dydtarbi_lattice_full(t,y,N,ep(kk),sigma1(i),sigma2(j),eta,D,theta(i_theta),Ap(i_Ap),al,p,zeta),Tspan1,y0_IC,options);
    y0_Interm = Y1(end,:)';
    y0_temp_1 = Y1(:,2*N+1);
    v0_temp_1 = Y1(:,2*N+2);
    y1_temp_1 = Y1(:,2*N+3);
    un_p_temp_1 = Y1(:,2*(N-p));
%     clear Y1
    Y1 = [];
    [~,Y2]=ode45(@(t,y) dydtarbi_lattice_full(t,y,N,ep(kk),sigma1(i),sigma2(j),eta,D,theta(i_theta),Ap(i_Ap),al,p,zeta),Tspan2,y0_Interm,options);
    y0_temp_2 = Y2(:,2*N+1);
    v0_temp_2 = Y2(:,2*N+2);
    y1_temp_2 = Y2(:,2*N+3);
    un_p_temp_2 = Y2(:,2*(N-p));
%     clear Y2
    Y2 = [];
%     (i-1)*size(sigma1,2)+j
%     Simulation_Num = (i-1)*size(sigma1,2)+j;
    Name = ['d=',num2str(d),'_s1=',num2str(sigma1(i)),'_s2=',num2str(sigma2(j)),'_Ap=',num2str(Ap(i_Ap)),'_theta=',num2str(theta(i_theta)/(pi/6)),'pi_6'];
%     mkdir(Outdir)
    %% Extract values
    
%     x0 = Y1(:,2*N-1);
    Fs = 1/mean(diff(Tspan));
    
%     x0 = Y1(:,2*N-1);
%     y0 = Y1(:,2*N+1);
%     un_p = Y1(:,2*(N-p));
    y0 = [y0_temp_1(1:end-1);y0_temp_2];
    v0 = [v0_temp_1(1:end-1);v0_temp_2];
    y1 = [y1_temp_1(1:end-1);y1_temp_2];
    un_p = [un_p_temp_1(1:end-1);un_p_temp_2];
    y0_temp_1 = []; y1_temp_1 = []; v0_temp_1 = []; un_p_temp_1 = [];
    y0_temp_2 = []; y1_temp_2 = []; v0_temp_2 = []; un_p_temp_2 = [];
%     Power_input_time(:,i) = un_p(:,p).*2*ep*Ap.*cos((1+ep*D+ep*sigmaf)*T);
    omega = sqrt(1+4*d*sin(theta(i_theta)/2).^2);
    Energy_input_time = 1/Fs * trapz(un_p'.*2*ep(kk)*Ap(i_Ap).*cos(omega*Tspan));
    Power_input_downstream_1 = d*(y0-y1).*v0;
    Energy_out = trapz(Tspan,Power_input_downstream_1);
    parsave1(['DataSet','\',Name,'.mat'],Cur_para,Energy_input_time,Energy_out)
    %% Frequency spectrum of y0
%     [freq_FFT, y0_FFT] = my_dft(y0, Fs);
%     y_FFT2 = abs(y0_FFT).^2;
%     y_FFT2_smoothed = smoothdata(smoothdata(y_FFT2));
%     y_FFT2_filt = max(y_FFT2_smoothed)/100;
%     y_FFT2_filtered = y_FFT2;
%     y_FFT2_filtered(y_FFT2_smoothed<y_FFT2_filt)=0;
%     y_FFT2_filtered1 = y_FFT2_filtered(1:end-1);
%     y_FFT2_filtered2 = y_FFT2_filtered(2:end);
%     loc1 = find(y_FFT2_filtered1==0 & y_FFT2_filtered2>0);
%     loc2 = find(y_FFT2_filtered1>0 & y_FFT2_filtered2==0);
%     y_FFT2_discrete_approx = zeros(size(y_FFT2,1),1);

%     if size(loc1,1)==size(loc2,1)
%         N_peak = size(loc1,1);
%         Mag_peak = zeros(N_peak,1);
%         pos_peak = zeros(N_peak,1);
% 
%         for k = 1:size(loc1,1)
%             Mag_peak(k) = trapz(2*pi*freq_FFT(loc1(k):loc2(k)+1),y_FFT2(loc1(k):loc2(k)+1));
%             [~,temp] = max(y_FFT2(loc1(k):loc2(k)+1));
%             pos_peak(k) = 2*pi*freq_FFT(temp-1+loc1(k));
%             y_FFT2_discrete_approx(temp-1+loc1(k)) = Mag_peak(k);
%             Fac = trapz(2*pi*freq_FFT,y_FFT2_filtered)/trapz(2*pi*freq_FFT,y_FFT2);
%             freq_res = mean(diff(2*pi*freq_FFT));
%             cum_y_FFT2 = cumsum(y_FFT2)*freq_res; 
%             y_FFT2_discrete_approx_cum = cumsum(y_FFT2_discrete_approx);
% %             N_peak = max(N_peak,size(loc1,1));
%         end
%     else
%         Outdir = ['Error_Parameter'];
%         mkdir(Outdir);
%         sigma1_temp = sigma1(i);
%         sigma2_temp = sigma2(j);
%         parsave2([Outdir,'\',Name,'.mat'],sigma1_temp,sigma2_temp)
%     end
        end
    end
end
end
    end
end
% save('N_peak.mat','N_peak')
toc
% plot(T,y0)
% semilogy(freq_FFT, abs(y0_FFT))
% xlim(1/(2*pi)*[0.9 1.2])