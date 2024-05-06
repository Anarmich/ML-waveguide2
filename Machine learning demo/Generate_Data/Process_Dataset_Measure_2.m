clear all
sigma_interval = 20;
sigma1 = -2:(2-(-2))/sigma_interval:2;
sigma2 = -2:(2-(-2))/sigma_interval:2;
% Ap = 0.05:0.2:1.05;
% al = 2;
% theta = 1*pi/6;
% Ap = 0.25;
% zeta_physical = 0.01;
ep = [0.2 0.4 0.6 0.8];
theta = [1 2 3 4 5]*pi/6;
Ap = 0.2*[1 2 3 4];
eta = 1;
D = 1;
p = 4;
% sigmaf = -1;
N_dataset = size(sigma1,2)*size(sigma2,2)*size(ep,2);
input_para1 = zeros(5,N_dataset);

input_energy = zeros(1,N_dataset);
output_energy = zeros(1,N_dataset);
Transmissibility = zeros(1,N_dataset);
Nonreciprocity = zeros(1,N_dataset);
count = 0;
index_vec = 0;
for i_Ap = 1:size(Ap,2)
    for i_theta = 1:size(theta,2)
for kk = 1:size(ep,2)
    d = ep(kk)*D;
    for i = 1:size(sigma1,2)
        for j = 1:size(sigma2,2)
            if (d*sigma1(i)>-1 && d*sigma2(j)>-1)
                count = count + 1;
                index_vec = index_vec+1;
                Name1 = ['d=',num2str(d),'_s1=',num2str(sigma1(i)),'_s2=',num2str(sigma2(j)),'_Ap=',num2str(Ap(i_Ap)),'_theta=',num2str(theta(i_theta)/(pi/6)),'pi_6'];
%                 Name1 = ['d=',num2str(d),'_s1=',num2str(sigma1(i)),'_s2=',num2str(sigma2(j)),'.mat'];
                load(['Dataset\',Name1,'.mat'])
                input_para1(:,index_vec) = x;
                downstream_energy1 = w_out;
                input_energy1 = w_in;
                Transmissibility(index_vec) = downstream_energy1/input_energy1;
                Name2 = ['d=',num2str(d),'_s1=',num2str(sigma2(j)),'_s2=',num2str(sigma1(i)),'_Ap=',num2str(Ap(i_Ap)),'_theta=',num2str(theta(i_theta)/(pi/6)),'pi_6'];
%                 Name2 = ['d=',num2str(d),'_s1=',num2str(sigma2(j)),'_s2=',num2str(sigma1(i)),'.mat'];
                load(['Dataset\',Name2,'.mat'])
                downstream_energy2 = w_out;
                Nonreciprocity(index_vec) = log10(downstream_energy1/downstream_energy2);
                if downstream_energy2<0
                    1
                    return
                end
                if downstream_energy1<0
                    1
                    return
                end
                if input_energy1<0
                    1
                    return
                end
            end
        end
    end
end
    end
end
Output_para = [Transmissibility;Nonreciprocity];
input_para1(:,count+1:end) = [];
Output_para(:,count+1:end) = [];
save('Measure.mat','input_para1','Output_para')
% save(['Dataset_coarse_',num2str(coarse_num),'.mat'],'input_sigma','output_peak_full','input_energy')