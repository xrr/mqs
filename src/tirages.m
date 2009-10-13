    n = h * lambda; %nombre d'arrivées lors de la simulation

switch lower(loi)
    case {'p','poisson','e','exp','exponential'}
        %réalisations de variables aléatoires et de loi exponentielle obtenues selon la méthode par inversion:
        %http://www.lsp.ups-tlse.fr/Fp/Gadat/Ens/Agreg/tp2.pdf
        dS = -log(rand(n,1))/mu; %durées de service
    case {'g','gauss','gaussian','n','norm','normal'}
        %réalisations de variables aléatoires et de loi normale obtenues selon la méthode de Box-Muller:
        %http://en.wikipedia.org/wiki/Box-Muller_transform
        %l'espérance est conservée mais l'écart type est fortement diminué pour avoir des valeurs presque sûrement positives
        dS = max(0,sqrt(-2*log(rand(n,1))).*cos(2*pi*rand(n,1))/(4*mu)+1/mu); %suit N(0,1)/4mu+1/mu = N(1/mu,1/16mu²) (ou 0 si négatif)
    case {'ln','log-normal'}
        %distribution log-normale de même espérance;variance que la distribution exponentielle
        %http://en.wikipedia.org/wiki/Log-normal_distribution
        dS =  exp(sqrt(-2*log(rand(n,1))).*cos(2*po*rand(n,1))*sqrt(log(2))-log(2*mu^2)/2); %suit exp(N(-log(2mu²)/2,?log(2))) pour avoir 1/mu;1/mu² d'espérance;variance
end

arrivees = n * prod(journee) / sum(prod(journee)); %nombre d'arrivées au cours des plages horaires
intensitees = arrivees ./ (h *  journee(1,:) / sum(journee(1,:))); %arrivées/unité de temps au cours des plages horaires

dIA = [];
for j=1:size(journee,2) %pour la j-ième tranche horaire:
    dIA = [dIA ;-log(rand(round(arrivees(j)),1))/intensitees(j)]; %durées interarrivées
end
iA = cumsum(dIA); %instants des arrivées