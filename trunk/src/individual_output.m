disp(['[Asynchronous M/M/s Queue Simulation] s = ' num2str(s) ' --> L: ' num2str(total_em) ' / Wq: ' num2str(attente_tm) ' / W: ' num2str(total_tm)])
disp('')
disp(['// co�t total: ' num2str(objective) ' (pour la journ�e)'])


figure

subplot(3,2,1)
hold on
stairs(state(:,1),state(:,2),'Color',[0 0 1])
plot(xlim,[occup_em occup_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel('�tats d''occupation')
legend({'instantan�',['moyen (' num2str(occup_em) ')']})

subplot(3,2,3)
hold on
stairs(state(:,1),state(:,3),'Color',[0 0 1])
plot(xlim,[attente_em attente_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel('�tats d''attente')
legend({'instantan�',['moyen (' num2str(attente_em) ')']})

subplot(3,2,5)
hold on
stairs(state(:,1),state(:,2)+state(:,3),'Color',[0 0 1])
plot(xlim,[total_em total_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel(['�tats du syst�me (s=' num2str(s) ')'])
legend({'instantan�', ['moyen (' num2str(total_em) ')']})

subplot(3,2,2)
hold on
bar(occup(:,1),occup_fe,'yellow')
plot([occup_em occup_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('�tats d''occupation')
ylabel('% du temps total')
legend({'fr�quence',['�tat d''occupation moyen (' num2str(occup_em) ')']})

subplot(3,2,4)
hold on
bar(attente(:,1),attente_fe,'yellow')
plot([attente_em attente_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('�tats d''attente')
ylabel('% du temps total')
legend({'fr�quence',['�tat d''attente moyen (' num2str(attente_em) ')']})

subplot(3,2,6)
hold on
bar(total(:,1),total_fe,'yellow')
plot([total_em total_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('�tats')
ylabel('% du temps total')
legend({'fr�quence',['�tat moyen (' num2str(total_em) ')']})