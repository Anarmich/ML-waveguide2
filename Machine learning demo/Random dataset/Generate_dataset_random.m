% sigma1 = -2:0.3:1;
% sigma2 = -4.8:0.3:0;
clear clc
load(['Random_sampling.mat'])
% sigma1 = 1;
% sigma2 = 0;
al = 2;
zeta_physical = 0.01;
N = 400;
eta = 1;
D = 1;
p = 4;

y0_IC = zeros(4*N,1);
options=odeset('Reltol',1e-8,'Abstol',1e-8);

N_case_eff = size(Index_eff,1);
tic
parfor i_case = 1:N_case_eff
    Cur_para = Data_sample_eff(i_case,:);
    Index_temp = Cur_para(1);
    sigma1_temp = Cur_para(2);
    sigma2_temp = Cur_para(3);
    ep_temp = Cur_para(4);
    Ap_temp = Cur_para(5);
    theta_temp = Cur_para(6);
    d_temp = ep_temp * D;
    T_Fac = (0.05/d_temp);
    Tspan = 0:0.5*T_Fac:15000*T_Fac;        
    zeta_temp = zeta_physical/d_temp;
    [~,Y1]=ode45(@(t,y) dydtarbi_lattice_full(t,y,N,ep_temp,...
        sigma1_temp,sigma2_temp,eta,D,theta_temp,Ap_temp,al,p,zeta_temp),Tspan,y0_IC,options);
    y0_temp_1 = Y1(:,2*N+1);
    v0_temp_1 = Y1(:,2*N+2);
    y1_temp_1 = Y1(:,2*N+3);
    un_p_temp_1 = Y1(:,2*(N-p));
%     clear Y1
    Y1 = [];
    [~,Y2]=ode45(@(t,y) dydtarbi_lattice_full(t,y,N,ep_temp,...
        sigma2_temp,sigma1_temp,eta,D,theta_temp,Ap_temp,al,p,zeta_temp),Tspan,y0_IC,options);
    y0_temp_2 = Y2(:,2*N+1);
    v0_temp_2 = Y2(:,2*N+2);
    y1_temp_2 = Y2(:,2*N+3);
    un_p_temp_2 = Y2(:,2*(N-p));
%     clear Y2
    Y2 = [];
%     (i-1)*size(sigma1,2)+j
%     Simulation_Num = (i-1)*size(sigma1,2)+j;
    Name = [num2str(Index_temp),'_d=',num2str(d_temp),...
        '_s1=',num2str(sigma1_temp),'_s2=',num2str(sigma2_temp),...
        '_Ap=',num2str(Ap_temp),'_theta=',num2str(theta_temp)];
%     mkdir(Outdir)
    %% Extract values
    Fs = 1/mean(diff(Tspan));
    omega = sqrt(1+4 * d_temp * sin(theta_temp/2).^2);
    Energy_input_time1 = ...
        1/Fs * trapz(un_p_temp_1'.*2*ep_temp*Ap_temp.*cos(omega*Tspan));
    Power_input_downstream_1 ...
        = d_temp * (y0_temp_1 - y1_temp_1) .* v0_temp_1 ;
    Energy_out_1 = trapz(Tspan,Power_input_downstream_1);
    Energy_input_time2 = ...
        1/Fs * trapz(un_p_temp_2'.*2*ep_temp*Ap_temp.*cos(omega*Tspan));
    Power_input_downstream_2 ...
        = d_temp * (y0_temp_2 - y1_temp_2) .* v0_temp_2 ;
    Energy_out_2 = trapz(Tspan,Power_input_downstream_2);
    Transmissibility = Energy_out_1 / Energy_input_time1;
    Nonreciprocity = log10(Energy_out_1/Energy_out_2);
    parsave1(['DataSet','\',Name,'.mat'],Cur_para,Transmissibility,Nonreciprocity)
end
toc
