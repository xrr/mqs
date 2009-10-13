state = [inf*ones(3*n+1,1),zeros(3*n+1,2)]; %�tats du syst�me enregistr�s sous la forme [temps,occupation,attente]
state(1,1) = 0; %initialisation du syst�me

for k=1:length(iA) %pour l'arriv�e k:
    iDS = iA(k); %instant du d�but du service en l'absence d'attente
    index_a = find(state(:,1)>iDS); %on cherche les instants post�rieurs � l'arriv�e..
    index_b = find(state(index_a-1,2)<=s-1,1); %..parmi lesquels � l'�v�nement pr�c�dent il restait une place innocup�e
    pA = index_a(1); %position de l'arriv�e dans le tableau d'�tat
    pDS = index_a(index_b); %position du d�but de service dans le tableau d'�tat
    cDS = state(pDS-1,2); %occupation avant le d�but du service
    if index_b>1 %s'il y a eu attente:
        state(pA+1:end,:) = state(pA:end-1,:); %d�calage du tableau d'�tat
        pDS = pDS + 1; %prise en compte de ce d�calage pour pDS...
        state(pA,:) = [iDS,state(pA-1,2),state(pA-1,3)]; %cr�ation d'une entr�e du tableau d'�tat � l'arriv�e (afin de d'y inscrire le d�but d'une attente suppl�mentaire)
        state(pA:pDS-1,3) = state(pA:pDS-1,3) + 1; %incr�mentation de l'attente sur la plage concern�e
        state(pDS-1,2) = cDS + 0.5; %la place r�cup�r�e n'apparait plus libre artificiellement: occupation<=s-1 �choue
        iDS = state(pDS-1,1); %nouvel instant du d�but du service pris en compte
    end
    state(pDS+1:end,:) = state(pDS:end-1,:); %d�calage du tableau d'�tat
    state(pDS,:) = [iDS,cDS+1,0]; %renseignement du tableau d'�tat pour l'�v�nement du d�but du service
    state(pDS+1:end,2) = state(pDS+1:end,2) + 1; %incr�mentation de l'occupation

    iFS = iDS + dS(k); %instant de fin de service
    pFS = find(state(:,1)>iFS,1); %position de la fin du service dans le tableau d'�tat
    cFS = state(pFS-1,2); %occupation avant la fin du service
    aFS = state(pFS-1,3); %attente avant la fin de service
    state(pFS+1:end,:) = state(pFS:end-1,:); %d�calage du tableau d'�tat
    state(pFS,:) = [iFS,cFS-1,aFS]; %renseignement du tableau d'�tat pour l'�v�nement de la fin du service
    state(pFS+1:end,2) = state(pFS+1:end,2) - 1; %d�cr�mentation de l'occupation
end

state = state(state(:,1)<inf,:); %troncature des entr�es du tableau non utilis�es (3*n+1 au d�part mais il n'y a pas d'attente � chaque arriv�e donc l'entr�e � pA n'est pas forc�mment cr��e)