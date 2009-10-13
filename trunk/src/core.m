state = [inf*ones(3*n+1,1),zeros(3*n+1,2)]; %états du système enregistrés sous la forme [temps,occupation,attente]
state(1,1) = 0; %initialisation du système

for k=1:length(iA) %pour l'arrivée k:
    iDS = iA(k); %instant du début du service en l'absence d'attente
    index_a = find(state(:,1)>iDS); %on cherche les instants postérieurs à l'arrivée..
    index_b = find(state(index_a-1,2)<=s-1,1); %..parmi lesquels à l'évènement précédent il restait une place innocupée
    pA = index_a(1); %position de l'arrivée dans le tableau d'état
    pDS = index_a(index_b); %position du début de service dans le tableau d'état
    cDS = state(pDS-1,2); %occupation avant le début du service
    if index_b>1 %s'il y a eu attente:
        state(pA+1:end,:) = state(pA:end-1,:); %décalage du tableau d'état
        pDS = pDS + 1; %prise en compte de ce décalage pour pDS...
        state(pA,:) = [iDS,state(pA-1,2),state(pA-1,3)]; %création d'une entrée du tableau d'état à l'arrivée (afin de d'y inscrire le début d'une attente supplémentaire)
        state(pA:pDS-1,3) = state(pA:pDS-1,3) + 1; %incrémentation de l'attente sur la plage concernée
        state(pDS-1,2) = cDS + 0.5; %la place récupérée n'apparait plus libre artificiellement: occupation<=s-1 échoue
        iDS = state(pDS-1,1); %nouvel instant du début du service pris en compte
    end
    state(pDS+1:end,:) = state(pDS:end-1,:); %décalage du tableau d'état
    state(pDS,:) = [iDS,cDS+1,0]; %renseignement du tableau d'état pour l'évènement du début du service
    state(pDS+1:end,2) = state(pDS+1:end,2) + 1; %incrémentation de l'occupation

    iFS = iDS + dS(k); %instant de fin de service
    pFS = find(state(:,1)>iFS,1); %position de la fin du service dans le tableau d'état
    cFS = state(pFS-1,2); %occupation avant la fin du service
    aFS = state(pFS-1,3); %attente avant la fin de service
    state(pFS+1:end,:) = state(pFS:end-1,:); %décalage du tableau d'état
    state(pFS,:) = [iFS,cFS-1,aFS]; %renseignement du tableau d'état pour l'évènement de la fin du service
    state(pFS+1:end,2) = state(pFS+1:end,2) - 1; %décrémentation de l'occupation
end

state = state(state(:,1)<inf,:); %troncature des entrées du tableau non utilisées (3*n+1 au départ mais il n'y a pas d'attente à chaque arrivée donc l'entrée à pA n'est pas forcémment créée)