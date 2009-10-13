lambda = 96; %arrivées moyennes par unité de temps
mu = 54; %services moyens par unité de temps

journee = [1 2 2 2 1;  %durée relatives des tranches horaires
           1 1 3 1 2]; %intensitée des arrivées au cours des tranches
%journee = [1;1];

%loi = 'normal';
loi = 'gauss'; %type de loi pour la durée de service

h = 8; %durée de la simulation

s_range = 1:10; %plage à tester pour le nombre de serveurs
disp_range = [3 4]; %plage de valeurs de s à afficher