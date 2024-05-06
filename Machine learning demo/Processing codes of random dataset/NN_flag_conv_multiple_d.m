clearvars
addpath(['4_50'])
d = 0.2:0.05:0.8;

for kk = 1:size(d,2)
Ap = 0.2:0.025:0.8;
theta = 1/6*pi:1/24*pi:5/6*pi;
sigma_min = max(ceil(-10/d(kk))/10,-2);
sigma_max = 2;
sigma1 = sigma_min:0.1:sigma_max;
sigma2 = sigma_min:0.1:sigma_max;


% Measure_temp = zeros(size(sigma1,2),size(sigma2,2));
Transmissibility = zeros(size(sigma1,2),size(sigma2,2));
Nonreciprocity = zeros(size(sigma1,2),size(sigma2,2));
kern_max_single_d = zeros(size(theta,2),size(Ap,2));
% Measure_opt = zeros(size(Ap,2),size(sigmaf,2));
% output = [Transmissibility;Nonreciprocity];
for i_theta = 1:size(theta,2)
    for i_Ap = 1:size(Ap,2)
for i = 1:size(sigma1,2)
    for j = 1:size(sigma2,2)
        input_NN = [sigma1(i);sigma2(j);d(kk);Ap(i_Ap);theta(i_theta)];
        eval(['output_NN = neural_function(input_NN);'])
        Transmissibility(i,j) = output_NN(1);
        Nonreciprocity(i,j) = output_NN(2);
    end
end
%%
for i_kern = 1:21
% kernx = 20;
% kerny = 20;
conv_kernel = ones(i_kern,i_kern);
flag_exc = (Transmissibility>0.2 & Nonreciprocity>1)';
    if max(max(conv2(flag_exc,conv_kernel)))<i_kern^2
        kern_max_single_d(i_theta,i_Ap) = (i_kern-1)*sqrt(mean(diff(sigma1))*mean(diff(sigma2)));
        break
    end
end
    end
end
%%
figure(4)
pcolor(theta,Ap,kern_max_single_d');
colormap jet
shading interp
colorbar
title(['Good region, kernel size, d = ',num2str(d(kk))])
set(gca,'fontsize',16)
xlabel(['\theta'])
ylabel(['A_p'])
xticks([1/6:1/6:5/6]*pi)
xticklabels({'1/6\pi','1/3\pi','1/2\pi','2/3\pi','5/6\pi'})
yticks([0.2:0.2:0.8])
set(gcf,'position',[100 100 400 400])
saveas(gcf,['d=',num2str(d(kk)),'.fig'],'fig')
caxis([0 1.2])
close figure 4
end