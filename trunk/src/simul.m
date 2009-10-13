clear all %vide le workspace
close all %ferme les figures
clc %efface le prompt

parameters %charge les paramètres

for i = 1:length(s_range) %parcourt la gamme de valeurs de s
    s = s_range(i);
    
    tirages %obtention des valeurs aléatoires
    core %fais tourner le modèle
    bilan %calcule les principales grandeurs

    if find(s==disp_range) %valeurs de s où une sortie individuelle doit être affichée
        individual_output %affiche les sorties
    end

    cost_range(i) = objective; %tabule le résultat;
end

[optim_cost optim_index] = min(cost_range); %récupère le coût minimum
optim_s = s_range(optim_index); %nombre de serveur correspondant à ce minimum

global_output