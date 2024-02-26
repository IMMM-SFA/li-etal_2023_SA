function [Var_temporal,Var_temporal_average,Var_temporal_variability] = temporal_DL(Var_input)

[nrow, ncol , N] = size(Var_input);
Var_temporal = zeros(N,1);

for k = 1:N
    Var_selected = Var_input(:,:,k);
    Var_temporal(k,1) = nanmean(Var_selected(:));    
end

    
    
Var_temporal_average = nanmean(Var_temporal); 
Var_temporal_variability = nanstd(Var_temporal); 

        

