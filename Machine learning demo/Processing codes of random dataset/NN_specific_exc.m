clearvars
addpath(['4_50'])

Ap = 0.35;
theta = 7/12*pi;
d = 0.5;
sigma_min = max(ceil(-10/d)/10,-2);
sigma_max = 2;
sigma1 = sigma_min:0.1:sigma_max;
sigma2 = sigma_min:0.1:sigma_max;
% Measure_temp = zeros(size(sigma1,2),size(sigma2,2));
Transmissibility = zeros(size(sigma1,2),size(sigma2,2));
Nonreciprocity = zeros(size(sigma1,2),size(sigma2,2));

% Measure_opt = zeros(size(Ap,2),size(sigmaf,2));
% output = [Transmissibility;Nonreciprocity];
for i = 1:size(sigma1,2)
    for j = 1:size(sigma2,2)
        input_NN = [sigma1(i);sigma2(j);d;Ap;theta];
        eval(['output_NN = neural_function(input_NN);'])
        Transmissibility(i,j) = output_NN(1);
        Nonreciprocity(i,j) = output_NN(2);
    end
end


%%
figure(2)
pcolor(sigma1,sigma2,Transmissibility')
colormap jet
shading interp
colorbar
% title([num2str(N_layers),' layers ',num2str(N_neurons),' neurons',...
%     newline,'Transmissibility,',' \sigma_f=',num2str(sigmaf),'; A_p=',num2str(Ap)])
title(['Transmissibility'])
set(gca,'fontsize',14)
xlabel(['\sigma_1'])
ylabel(['\sigma_2'])
caxis([0 0.2])
xlim([-2 2])
ylim([-2 2])
set(gcf,'position',[100 100 400 400])
%%
figure(3)
pcolor(sigma1,sigma2,Nonreciprocity')
colormap jet
shading interp
colorbar
% title([num2str(N_layers),' layers ',num2str(N_neurons),' neurons',...
%     newline,'Log10 Nonreciprocity,',' \sigma_f=',num2str(sigmaf),'; A_p=',num2str(Ap)])
title(['Log10 Nonreciprocity'])

set(gca,'fontsize',14)
xlabel(['\sigma_1'])
ylabel(['\sigma_2'])
caxis([0 2])
xlim([-2 2])
ylim([-2 2])
set(gcf,'position',[100 100 400 400])
% xticks([-0.9 -0.6 -0.3 0 0.2 0.5 0.85])
% yticks([0.05:0.2:1.05])
%%
%%
figure(4)
contourf(sigma1,sigma2,(Transmissibility>0.2 & Nonreciprocity>1)',1)
% colormap jet
% shading interp
% colorbar
% title([num2str(N_layers),' layers ',num2str(N_neurons),' neurons',...
%     newline,'Good region,',' \sigma_f=',num2str(sigmaf),'; A_p=',num2str(Ap)])
title(['Neural net desired region,',newline,' A_p=',num2str(Ap),'; \theta=',num2str(theta/pi*6),'/6\pi','; d=',num2str(d)])
set(gca,'fontsize',16)
xlabel(['\sigma_1'])
ylabel(['\sigma_2'])
set(gcf,'position',[100 100 400 400])

caxis([0 1])
xlim([-2 2])
ylim([-2 2])
%%
for i_kern = 1:21
% kernx = 20;
% kerny = 20;
conv_kernel = ones(i_kern,i_kern);
flag_exc = (Transmissibility>0.2 & Nonreciprocity>1)';
    if max(max(conv2(flag_exc,conv_kernel)))<i_kern^2
        kern_max = (i_kern-1)*sqrt(mean(diff(sigma1))*mean(diff(sigma2)))
        return
    end
end
