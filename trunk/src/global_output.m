figure
hold on
plot(s_range,cost_range,'Color',[1 0.5 0])
plot([optim_s optim_s],ylim, 'Color',[1 0 0],'LineStyle',':')
plot(xlim,[optim_cost optim_cost],'Color',[0 0 1],'LineStyle',':')
xlabel('nombre de serveurs')
ylabel('co�t')
legend({'co�t',['nombre de serveurs optimal (' num2str(optim_s) ')'],['co�t optimal (' num2str(optim_cost) ')']})