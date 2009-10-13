disp(['[Asynchronous M/M/s Queue Simulation] s = ' num2str(s) ' --> L: ' num2str(total_em) ' / Wq: ' num2str(attente_tm) ' / W: ' num2str(total_tm)])
disp('')
disp(['// coût total: ' num2str(objective) ' (pour la journée)'])


figure

subplot(3,2,1)
hold on
stairs(state(:,1),state(:,2),'Color',[0 0 1])
plot(xlim,[occup_em occup_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel('états d''occupation')
legend({'instantané',['moyen (' num2str(occup_em) ')']})

subplot(3,2,3)
hold on
stairs(state(:,1),state(:,3),'Color',[0 0 1])
plot(xlim,[attente_em attente_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel('états d''attente')
legend({'instantané',['moyen (' num2str(attente_em) ')']})

subplot(3,2,5)
hold on
stairs(state(:,1),state(:,2)+state(:,3),'Color',[0 0 1])
plot(xlim,[total_em total_em],'Color',[1 0 0],'LineStyle',':')
xlabel('temps')
ylabel(['états du système (s=' num2str(s) ')'])
legend({'instantané', ['moyen (' num2str(total_em) ')']})

subplot(3,2,2)
hold on
bar(occup(:,1),occup_fe,'yellow')
plot([occup_em occup_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('états d''occupation')
ylabel('% du temps total')
legend({'fréquence',['état d''occupation moyen (' num2str(occup_em) ')']})

subplot(3,2,4)
hold on
bar(attente(:,1),attente_fe,'yellow')
plot([attente_em attente_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('états d''attente')
ylabel('% du temps total')
legend({'fréquence',['état d''attente moyen (' num2str(attente_em) ')']})

subplot(3,2,6)
hold on
bar(total(:,1),total_fe,'yellow')
plot([total_em total_em],ylim,'Color',[1 0 0],'LineStyle',':')
xlabel('états')
ylabel('% du temps total')
legend({'fréquence',['état moyen (' num2str(total_em) ')']})