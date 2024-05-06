hold on
h1 = scatter(targets(1,tr.testInd),targets(2,tr.testInd),'.');
Index = find(targets(1,tr.testInd)>0.2 & targets(2,tr.testInd)>1);
h2 = scatter(targets(1,tr.testInd(Index)),targets(2,tr.testInd(Index)));
xlim([-0.1 0.6])
ylim([-4 4])
set(gca,'fontsize',20)
title(['ODE results on the test set'])
xticks(0:0.2:0.6)
xlabel(['Transmissiiblity'])
ylabel(['Nonreciprocity'])
legend([h1 h2],'Full test set','Desired region','location','southeast')