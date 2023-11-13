clear all
close all
clc

%%
addpath('./TRM')
load('./data1.mat','lat','lon','rows','colms','days','dates');
load('./data2_Ts.mat','TS_U_detrend','TS_R_detrend');
load('mask_urban_and_rural.mat')


%%

TS_U_spectra = zeros(rows,colms,2^9/2+1)+NaN;
TS_R_spectra = zeros(rows,colms,2^9/2+1)+NaN;

TS_U_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;
TS_R_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;

%%
TS_U_detrend_test = TS_U_detrend;
TS_U_detrend_test(isnan(TS_U_detrend_test)) = 1;
TS_U_detrend_test2 = reshape(TS_U_detrend_test,rows.*colms,days);

[TS_U_spectra_test,f] = pwelch(TS_U_detrend_test2',2^9,[],[],1,'onesided');

TS_U_spectra_test2 = TS_U_spectra_test';

for i = 1:2^9/2+1

TS_U_spectra(:,:,i) = reshape(TS_U_spectra_test2(:,i),[rows,colms,1]);

TS_U_spectra(:,:,i)  = TS_U_spectra(:,:,i).*mask_urban_temp;

TS_U_spectra_normalized(:,:,i) = TS_U_spectra(:,:,i)./var(TS_U_detrend,0,3,'omitnan');

end


%%

TS_R_detrend_test = TS_R_detrend;
TS_R_detrend_test(isnan(TS_R_detrend_test)) = 1;
TS_R_detrend_test2 = reshape(TS_R_detrend_test,rows.*colms,days);


[TS_R_spectra_test] = pwelch(TS_R_detrend_test2',2^9,[],[],1,'onesided');

TS_R_spectra_test2 = TS_R_spectra_test';

for i = 1:2^9/2+1

TS_R_spectra(:,:,i) = reshape(TS_R_spectra_test2(:,i),[rows,colms,1]);

TS_R_spectra(:,:,i)  = TS_R_spectra(:,:,i).*mask_urban_temp;

TS_R_spectra_normalized(:,:,i) = TS_R_spectra(:,:,i)./var(TS_R_detrend,0,3,'omitnan');

end



%%
save('spectra_data_Ts.mat','f','TS_U_spectra','TS_R_spectra',...
    'TS_U_spectra_normalized','TS_R_spectra_normalized')
