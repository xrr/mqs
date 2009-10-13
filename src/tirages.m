    n = h * lambda; %nombre d'arriv�es lors de la simulation

switch lower(loi)
    case {'p','poisson','e','exp','exponential'}
        %r�alisations de variables al�atoires et de loi exponentielle obtenues selon la m�thode par inversion:
        %http://www.lsp.ups-tlse.fr/Fp/Gadat/Ens/Agreg/tp2.pdf
        dS = -log(rand(n,1))/mu; %dur�es de service
    case {'g','gauss','gaussian','n','norm','normal'}
        %r�alisations de variables al�atoires et de loi normale obtenues selon la m�thode de Box-Muller:
        %http://en.wikipedia.org/wiki/Box-Muller_transform
        %l'esp�rance est conserv�e mais l'�cart type est fortement diminu� pour avoir des valeurs presque s�rement positives
        dS = max(0,sqrt(-2*log(rand(n,1))).*cos(2*pi*rand(n,1))/(4*mu)+1/mu); %suit N(0,1)/4mu+1/mu = N(1/mu,1/16mu�) (ou 0 si n�gatif)
    case {'ln','log-normal'}
        %distribution log-normale de m�me esp�rance;variance que la distribution exponentielle
        %http://en.wikipedia.org/wiki/Log-normal_distribution
        dS =  exp(sqrt(-2*log(rand(n,1))).*cos(2*po*rand(n,1))*sqrt(log(2))-log(2*mu^2)/2); %suit exp(N(-log(2mu�)/2,?log(2))) pour avoir 1/mu;1/mu� d'esp�rance;variance
end

arrivees = n * prod(journee) / sum(prod(journee)); %nombre d'arriv�es au cours des plages horaires
intensitees = arrivees ./ (h *  journee(1,:) / sum(journee(1,:))); %arriv�es/unit� de temps au cours des plages horaires

dIA = [];
for j=1:size(journee,2) %pour la j-i�me tranche horaire:
    dIA = [dIA ;-log(rand(round(arrivees(j)),1))/intensitees(j)]; %dur�es interarriv�es
end
iA = cumsum(dIA); %instants des arriv�es