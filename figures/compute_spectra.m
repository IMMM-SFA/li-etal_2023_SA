clear all
close all
clc

%%
addpath('./TRM')
load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat','TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');
load('mask_urban_and_rural.mat')

%%

TSA_U_spectra = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_spectra = zeros(rows,colms,2^9/2+1)+NaN;
TSA_UHI_spectra = zeros(rows,colms,2^9/2+1)+NaN;

TSA_U_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;
TSA_UHI_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;

TSA_U_MAX_spectra = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_MAX_spectra = zeros(rows,colms,2^9/2+1)+NaN;

TSA_U_MAX_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_MAX_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;

TSA_U_MIN_spectra = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_MIN_spectra = zeros(rows,colms,2^9/2+1)+NaN;

TSA_U_MIN_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;
TSA_R_MIN_spectra_normalized = zeros(rows,colms,2^9/2+1)+NaN;

%%
TSA_U_detrend_test = TSA_U_detrend;
TSA_U_detrend_test(isnan(TSA_U_detrend_test)) = 1;
TSA_U_detrend_test2 = reshape(TSA_U_detrend_test,rows.*colms,days);

[TSA_U_spectra_test,f] = pwelch(TSA_U_detrend_test2',2^9,[],[],1,'onesided');

TSA_U_spectra_test2 = TSA_U_spectra_test';

for i = 1:2^9/2+1

TSA_U_spectra(:,:,i) = reshape(TSA_U_spectra_test2(:,i),[rows,colms,1]);

TSA_U_spectra(:,:,i)  = TSA_U_spectra(:,:,i).*mask_urban_temp;

TSA_U_spectra_normalized(:,:,i) = TSA_U_spectra(:,:,i)./var(TSA_U_detrend,0,3,'omitnan');

end


%%

TSA_R_detrend_test = TSA_R_detrend;
TSA_R_detrend_test(isnan(TSA_R_detrend_test)) = 1;
TSA_R_detrend_test2 = reshape(TSA_R_detrend_test,rows.*colms,days);


[TSA_R_spectra_test] = pwelch(TSA_R_detrend_test2',2^9,[],[],1,'onesided');

TSA_R_spectra_test2 = TSA_R_spectra_test';

for i = 1:2^9/2+1

TSA_R_spectra(:,:,i) = reshape(TSA_R_spectra_test2(:,i),[rows,colms,1]);

TSA_R_spectra(:,:,i)  = TSA_R_spectra(:,:,i).*mask_urban_temp;

TSA_R_spectra_normalized(:,:,i) = TSA_R_spectra(:,:,i)./var(TSA_R_detrend,0,3,'omitnan');

end


%%
TSA_UHI_detrend = TSA_U_detrend - TSA_R_detrend;

TSA_UHI_detrend_test = TSA_UHI_detrend;
TSA_UHI_detrend_test(isnan(TSA_UHI_detrend_test)) = 1;
TSA_UHI_detrend_test2 = reshape(TSA_UHI_detrend_test,rows.*colms,days);


[TSA_UHI_spectra_test] = pwelch(TSA_UHI_detrend_test2',2^9,[],[],1,'onesided');

TSA_UHI_spectra_test2 = TSA_UHI_spectra_test';

for i = 1:2^9/2+1

TSA_UHI_spectra(:,:,i) = reshape(TSA_UHI_spectra_test2(:,i),[rows,colms,1]);

TSA_UHI_spectra(:,:,i)  = TSA_UHI_spectra(:,:,i).*mask_urban_temp;

TSA_UHI_spectra_normalized(:,:,i) = TSA_UHI_spectra(:,:,i)./var(TSA_UHI_detrend,0,3,'omitnan');

end


%%
TSA_U_MAX_detrend_test = TSA_U_MAX_detrend;
TSA_U_MAX_detrend_test(isnan(TSA_U_MAX_detrend_test)) = 1;
TSA_U_MAX_detrend_test2 = reshape(TSA_U_MAX_detrend_test,rows.*colms,days);

[TSA_U_MAX_spectra_test] = pwelch(TSA_U_MAX_detrend_test2',2^9,[],[],1,'onesided');

TSA_U_MAX_spectra_test2 = TSA_U_MAX_spectra_test';

for i = 1:2^9/2+1

TSA_U_MAX_spectra(:,:,i) = reshape(TSA_U_MAX_spectra_test2(:,i),[rows,colms,1]);

TSA_U_MAX_spectra(:,:,i)  = TSA_U_MAX_spectra(:,:,i).*mask_urban_temp;

TSA_U_MAX_spectra_normalized(:,:,i) = TSA_U_MAX_spectra(:,:,i)./var(TSA_U_MAX_detrend,0,3,'omitnan');

end


%%

TSA_R_MAX_detrend_test = TSA_R_MAX_detrend;
TSA_R_MAX_detrend_test(isnan(TSA_R_MAX_detrend_test)) = 1;
TSA_R_MAX_detrend_test2 = reshape(TSA_R_MAX_detrend_test,rows.*colms,days);

[TSA_R_MAX_spectra_test] = pwelch(TSA_R_MAX_detrend_test2',2^9,[],[],1,'onesided');

TSA_R_MAX_spectra_test2 = TSA_R_MAX_spectra_test';

for i = 1:2^9/2+1

TSA_R_MAX_spectra(:,:,i) = reshape(TSA_R_MAX_spectra_test2(:,i),[rows,colms,1]);

TSA_R_MAX_spectra(:,:,i)  = TSA_R_MAX_spectra(:,:,i).*mask_urban_temp;

TSA_R_MAX_spectra_normalized(:,:,i) = TSA_R_MAX_spectra(:,:,i)./var(TSA_R_MAX_detrend,0,3,'omitnan');

end

%%
TSA_U_MIN_detrend_test = TSA_U_MIN_detrend;
TSA_U_MIN_detrend_test(isnan(TSA_U_MIN_detrend_test)) = 1;
TSA_U_MIN_detrend_test2 = reshape(TSA_U_MIN_detrend_test,rows.*colms,days);

[TSA_U_MIN_spectra_test] = pwelch(TSA_U_MIN_detrend_test2',2^9,[],[],1,'onesided');

TSA_U_MIN_spectra_test2 = TSA_U_MIN_spectra_test';

for i = 1:2^9/2+1

TSA_U_MIN_spectra(:,:,i) = reshape(TSA_U_MIN_spectra_test2(:,i),[rows,colms,1]);

TSA_U_MIN_spectra(:,:,i)  = TSA_U_MIN_spectra(:,:,i).*mask_urban_temp;

TSA_U_MIN_spectra_normalized(:,:,i) = TSA_U_MIN_spectra(:,:,i)./var(TSA_U_MIN_detrend,0,3,'omitnan');

end


%%

TSA_R_MIN_detrend_test = TSA_R_MIN_detrend;
TSA_R_MIN_detrend_test(isnan(TSA_R_MIN_detrend_test)) = 1;
TSA_R_MIN_detrend_test2 = reshape(TSA_R_MIN_detrend_test,rows.*colms,days);

[TSA_R_MIN_spectra_test] = pwelch(TSA_R_MIN_detrend_test2',2^9,[],[],1,'onesided');

TSA_R_MIN_spectra_test2 = TSA_R_MIN_spectra_test';

for i = 1:2^9/2+1

TSA_R_MIN_spectra(:,:,i) = reshape(TSA_R_MIN_spectra_test2(:,i),[rows,colms,1]);

TSA_R_MIN_spectra(:,:,i)  = TSA_R_MIN_spectra(:,:,i).*mask_urban_temp;

TSA_R_MIN_spectra_normalized(:,:,i) = TSA_R_MIN_spectra(:,:,i)./var(TSA_R_MIN_detrend,0,3,'omitnan');

end
%%

save('spectra_data.mat','f',...
    'TSA_U_spectra_normalized','TSA_R_spectra_normalized','TSA_UHI_spectra_normalized',...
    'TSA_U_MAX_spectra_normalized','TSA_R_MAX_spectra_normalized',...
    'TSA_U_MIN_spectra_normalized','TSA_R_MIN_spectra_normalized') %'TSA_U_spectra','TSA_R_spectra','TSA_UHI_spectra',...
