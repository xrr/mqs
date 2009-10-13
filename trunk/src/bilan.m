t = state(end,1); %temps total de simulation

clear occup
occup(:,2) = accumarray(1+floor(state(:,2)),[diff(state(:,1));0]); %temps dans chaque �tat d'occupation
occup(:,1) = 0:size(occup,1)-1; %�tat d'occupation correspondant
occup_fe = occup(:,2)/t; %fr�quence des �tats d'occupation
occup_em = sum(occup(:,1).*occup(:,2))/t; %�tat moyen d'occupation du syst�me
occup_tm = sum(occup(:,1).*occup(:,2))/n; %temps moyen d'occupation par client, =mean(dS) �galement

clear attente
attente(:,2) = accumarray(1+state(:,3),[diff(state(:,1));0]); %temps dans chaque �tat d'attente
attente(:,1) = 0:size(attente,1)-1; %�tat d'attente correspondant
attente_fe = attente(:,2)/t; %fr�quence des �tats d'attente
attente_em = sum(attente(:,1).*attente(:,2))/t; %�tat moyen d'attente du syst�me
attente_tm = sum(attente(:,1).*attente(:,2))/n; %temps moyen d'attente par client

clear total
total(:,2) = accumarray(1+floor(state(:,2))+state(:,3),[diff(state(:,1));0]); %temps dans chaque �tat
total(:,1) = 0:size(total,1)-1; %�tat correspondant
total_fe = total(:,2)/t; %fr�quence des �tats
total_em = sum(total(:,1).*total(:,2))/t; %�tat moyen du syst�me
total_tm = sum(total(:,1).*total(:,2))/n; %temps moyen par client

objective = 60*h*(s-occup_em)+ 30*n*attente_tm; %co�t de la journ�e (� minimiser)