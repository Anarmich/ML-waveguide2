clear clc
D = 1;
sigma1_range = [-2 2];
sigma2_range = [-2 2];
ep_range = [0.2 0.8];
Ap_range = [0.2 0.8];
theta_range = [1*pi/6 5*pi/6];
% N_total = 21 * 21 * 4 * 4 * 5;
N_total = 10000;
sigma1_min = min(sigma1_range);
sigma1_max = max(sigma1_range);
sigma2_min = min(sigma2_range);
sigma2_max = max(sigma2_range);
ep_min = min(ep_range);
ep_max = max(ep_range);
Ap_min = min(Ap_range);
Ap_max = max(Ap_range);
theta_min = min(theta_range);
theta_max = max(theta_range);
sigma1_sample = sigma1_min + ( sigma1_max - sigma1_min ) * rand(N_total,1);
sigma2_sample = sigma2_min + ( sigma2_max - sigma2_min ) * rand(N_total,1);
ep_sample = ep_min + ( ep_max - ep_min ) * rand(N_total,1);
Ap_sample = Ap_min + ( Ap_max - Ap_min ) * rand(N_total,1);
theta_sample = theta_min + ( theta_max - theta_min ) * rand(N_total,1);
d_sample = D * ep_sample;
Data_sample = [(1:N_total)' sigma1_sample sigma2_sample ep_sample Ap_sample theta_sample];
Index_eff = find(d_sample.*sigma1_sample>-1 & d_sample.*sigma2_sample>-1);
Data_sample_eff = Data_sample(Index_eff,:);
save('Random_sampling.mat','Index_eff','Data_sample_eff')
% size(Index_eff)
