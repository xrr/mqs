lambda = 96; %arriv�es moyennes par unit� de temps
mu = 54; %services moyens par unit� de temps

journee = [1 2 2 2 1;  %dur�e relatives des tranches horaires
           1 1 3 1 2]; %intensit�e des arriv�es au cours des tranches
%journee = [1;1];

%loi = 'normal';
loi = 'gauss'; %type de loi pour la dur�e de service

h = 8; %dur�e de la simulation

s_range = 1:10; %plage � tester pour le nombre de serveurs
disp_range = [3 4]; %plage de valeurs de s � afficher