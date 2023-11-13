clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation.mat


%%

To_urban= zeros(rows,colms);
To_rural= zeros(rows,colms);

To_AR1_urban= zeros(rows,colms);
To_AR1_rural= zeros(rows,colms);

N = max(lags);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend(i,j,1)) && ~isnan(TSA_R_detrend(i,j,1))

temp = zeros(N,1)+NaN;
temp2 = zeros(N,1)+NaN;
temp3 = zeros(N,1)+NaN;

for k=1:N
    temp(k,1)=1-k/N;
    temp2(k,1) = temp(k,1)*acorr_urban(i,j,k+1);
    temp3(k,1) = temp(k,1)*acorr_rural(i,j,k+1);    
end

To_urban(i,j) = 1+2*sum(temp2);
To_rural(i,j) = 1+2*sum(temp3);

To_AR1_urban(i,j) = (1+acorr_urban(i,j,2))/(1-acorr_urban(i,j,2));
To_AR1_rural(i,j) = (1+acorr_rural(i,j,2))/(1-acorr_rural(i,j,2));

         end
    end
end

To_diff = To_urban-To_rural;
To_diff_frac = To_diff./To_rural;

To_AR1_diff = To_AR1_urban-To_AR1_rural;
To_AR1_diff_frac = To_AR1_diff./To_AR1_rural;


%%
save('To.mat','To_urban','To_rural','To_diff','To_diff_frac',...
    'To_AR1_urban','To_AR1_rural','To_AR1_diff','To_AR1_diff_frac');





