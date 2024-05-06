al = 2;
zeta_physical = 0.01;
N = 400;
eta = 1;
D = 1;
p = 4;
load(['Random_sampling.mat'])
N_sample = size(Index_eff,1);
Transmissibility = zeros(1,N_sample);
Nonreciprocity = zeros(1,N_sample);
input_para1 = (Data_sample_eff(:,2:7))';
for i = 1:N_sample
    Index_temp = Data_sample_eff(i,1);
    sigma1_temp = Data_sample_eff(i,2);
    sigma2_temp = Data_sample_eff(i,3);
    ep_temp = Data_sample_eff(i,4);
    Ap_temp = Data_sample_eff(i,5);
    theta_temp = Data_sample_eff(i,6);
    d_temp = ep_temp * D;
    Name = [num2str(Index_temp),'_d=',num2str(d_temp),...
        '_s1=',num2str(sigma1_temp),'_s2=',num2str(sigma2_temp),...
        '_Ap=',num2str(Ap_temp),'_theta=',num2str(theta_temp)];
    load(['Dataset\',Name,'.mat'])
    Transmissibility(i) = w_in;
    Nonreciprocity(i) = w_out;
end
Output_para = [Transmissibility;Nonreciprocity];

save('Measure.mat','input_para1','Output_para')

% scatter(Transmissibility,Nonreciprocity)