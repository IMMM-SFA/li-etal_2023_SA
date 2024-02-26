function [Var_spatial,Var_spatial_average,Var_spatial_variability] = spatial_DL(Var_input)

[nrow, ncol , N] = size(Var_input);
Var_spatial = zeros(nrow,ncol);

for i = 1:nrow
    for j=1:ncol
    Var_selected = Var_input(i,j,:);
    Var_spatial(i,j) = nanmean(Var_selected(:));    
    end
end

    
    
Var_spatial_average = nanmean(reshape(Var_spatial,1,nrow*ncol)); 
Var_spatial_variability = nanstd(reshape(Var_spatial,1,nrow*ncol)); 

        

