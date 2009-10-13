clear all %vide le workspace
close all %ferme les figures
clc %efface le prompt

parameters %charge les param�tres

for i = 1:length(s_range) %parcourt la gamme de valeurs de s
    s = s_range(i);
    
    tirages %obtention des valeurs al�atoires
    core %fais tourner le mod�le
    bilan %calcule les principales grandeurs

    if find(s==disp_range) %valeurs de s o� une sortie individuelle doit �tre affich�e
        individual_output %affiche les sorties
    end

    cost_range(i) = objective; %tabule le r�sultat;
end

[optim_cost optim_index] = min(cost_range); %r�cup�re le co�t minimum
optim_s = s_range(optim_index); %nombre de serveur correspondant � ce minimum

global_output