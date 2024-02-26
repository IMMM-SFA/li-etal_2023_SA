% This is the Two-Resistance Mechanism attribution method for Qs

function [Diff_T2,...
          Rn_str_ref, Grnd_ref,ro_ref,ra_ref,rs_ref,f_TRM_ref,...
          Rn_str_sel, Grnd_sel,ro_sel,ra_sel,rs_sel,f_TRM_sel,... 
          ra_prime_ref,f_2_TRM_ref,...
          ra_prime_sel,f_2_TRM_sel,...            
          dT2_dswd_TRM_ref,dT2_drld_TRM_ref,dT2_dTa_TRM_ref,dT2_dqa_TRM_ref,dT2_dalpha_TRM_ref,dT2_demis_TRM_ref,dT2_dra_TRM_ref,dT2_drs_TRM_ref,dT2_dGrnd_TRM_ref,dT2_dra_prime_TRM_ref,...
          dT2_dswd_TRM_sel,dT2_drld_TRM_sel,dT2_dTa_TRM_sel,dT2_dqa_TRM_sel,dT2_dalpha_TRM_sel,dT2_demis_TRM_sel,dT2_dra_TRM_sel,dT2_drs_TRM_sel,dT2_dGrnd_TRM_sel,dT2_dra_prime_TRM_sel,...
          Diff_q2, ...
          dq2_dswd_TRM_ref,dq2_drld_TRM_ref,dq2_dTa_TRM_ref,dq2_dqa_TRM_ref,dq2_dalpha_TRM_ref,dq2_demis_TRM_ref,dq2_dra_TRM_ref,dq2_drs_TRM_ref,dq2_dGrnd_TRM_ref,dq2_dra_prime_TRM_ref,...
          dq2_dswd_TRM_sel,dq2_drld_TRM_sel,dq2_dTa_TRM_sel,dq2_dqa_TRM_sel,dq2_dalpha_TRM_sel,dq2_demis_TRM_sel,dq2_dra_TRM_sel,dq2_drs_TRM_sel,dq2_dGrnd_TRM_sel,dq2_dra_prime_TRM_sel] ...
          =REF_Q_TRM(rho_air,Cp,sb,lv,...
              Psurf_ref,swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,Qh_ref,Qle_ref,Ts_ref,T2_ref,q2_ref,...
              Psurf_sel,swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,Qh_sel,Qle_sel,Ts_sel,T2_sel,q2_sel)
          
%% calculate surface humidity difference


Diff_q2 = q2_sel - q2_ref;       
                   
[Diff_T2,...
          Rn_str_ref, Grnd_ref,ro_ref,ra_ref,rs_ref,f_TRM_ref,...
          Rn_str_sel, Grnd_sel,ro_sel,ra_sel,rs_sel,f_TRM_sel,...           
          ra_prime_ref,f_2_TRM_ref,...
          ra_prime_sel,f_2_TRM_sel,...          
          dT2_dswd_TRM_ref,dT2_drld_TRM_ref,dT2_dTa_TRM_ref,dT2_dqa_TRM_ref,dT2_dalpha_TRM_ref,dT2_demis_TRM_ref,dT2_dra_TRM_ref,dT2_drs_TRM_ref,dT2_dGrnd_TRM_ref,dT2_dra_prime_TRM_ref,...
          dT2_dswd_TRM_sel,dT2_drld_TRM_sel,dT2_dTa_TRM_sel,dT2_dqa_TRM_sel,dT2_dalpha_TRM_sel,dT2_demis_TRM_sel,dT2_dra_TRM_sel,dT2_drs_TRM_sel,dT2_dGrnd_TRM_sel,dT2_dra_prime_TRM_sel]= ...
          REF_TRM(rho_air,Cp,sb,lv,...
              Psurf_ref,swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,Qh_ref,Qle_ref,Ts_ref,T2_ref, ...
              Psurf_sel,swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,Qh_sel,Qle_sel,Ts_sel,T2_sel);  


[Diff_Ts,...
          Rn_str_ref, Grnd_ref,ro_ref,ra_ref,rs_ref,f_TRM_ref,...
          Rn_str_sel, Grnd_sel,ro_sel,ra_sel,rs_sel,f_TRM_sel,...          
          dTs_dswd_TRM_ref,dTs_drld_TRM_ref,dTs_dTa_TRM_ref,dTs_dqa_TRM_ref,dTs_dalpha_TRM_ref,dTs_demis_TRM_ref,dTs_dra_TRM_ref,dTs_drs_TRM_ref,dTs_dGrnd_TRM_ref,...
          dTs_dswd_TRM_sel,dTs_drld_TRM_sel,dTs_dTa_TRM_sel,dTs_dqa_TRM_sel,dTs_dalpha_TRM_sel,dTs_demis_TRM_sel,dTs_dra_TRM_sel,dTs_drs_TRM_sel,dTs_dGrnd_TRM_sel]=...
          TRM(rho_air,Cp,sb,lv,...
              Psurf_ref,swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,Qh_ref,Qle_ref,Ts_ref,...
              Psurf_sel,swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,Qh_sel,Qle_sel,Ts_sel);           
%% calculate sensitivities based on reference state
Ta_c_ref  = Ta_ref-273.15;
qa_sat_ref = qsat(Psurf_ref, Ta_ref);
lambda_o_ref = 1./(4*emis_ref*sb*Ta_ref.^3);
          
% sensitivity of surface saturated specific humidity to surface temperature
dqa_sat_dTa_ref = 0.622./Psurf_ref.*(2508.3./((Ta_c_ref + 237.3).^2).*exp((17.3.*Ta_c_ref)./(Ta_c_ref+237.3)))*1000;
Ts_modeled_ref = ((Rn_str_ref-Grnd_ref)-rho_air.*lv./(ra_ref+rs_ref).*(qa_sat_ref-qa_ref))./((1./lambda_o_ref)+rho_air.*Cp./ra_ref+rho_air.*lv./(ra_ref+rs_ref).*dqa_sat_dTa_ref)+Ta_ref;
T2_modeled_ref = f_2_TRM_ref.*(Ts_modeled_ref-Ta_ref)+ Ta_ref;

qs_sat_modeled_ref = qsat(Psurf_ref, Ts_modeled_ref); % modeled surface saturated specific humidity
% qs_modeled_ref = ra_ref./(ra_ref+rs_ref).*(qs_sat_modeled_ref-qa_ref)+qa_ref; % modeled surface specific humidity
q2_modeled_ref = ra_prime_ref./(ra_ref+rs_ref).*(qs_sat_modeled_ref-qa_ref)+qa_ref; % modeled 2m specific humidity

Ts_c_ref  = Ts_modeled_ref-273.15;
dqs_sat_dTs_ref = 0.622./Psurf_ref.*(2508.3./((Ts_c_ref + 237.3).^2).*exp((17.3.*Ts_c_ref)./(Ts_c_ref+237.3)))*1000; % de*/dT in kPa/K -- > Pa/K

% sensitivity of 2m saturated specific humidity to albedo
BB = ra_prime_ref./(ra_ref+rs_ref).*dqs_sat_dTs_ref;
dq2_dalpha_TRM_ref = BB.*dTs_dalpha_TRM_ref;

% sensitivity of 2m specific humidity to aerodynamic resistance
dq2_dra_TRM_ref = -ra_prime_ref./(ra_ref+rs_ref).^2.*(qs_sat_modeled_ref-qa_ref)+BB.*dTs_dra_TRM_ref;

% sensitivity of 2m specific humidity to surface resistance
dq2_drs_TRM_ref = -ra_prime_ref./(ra_ref+rs_ref).^2.*(qs_sat_modeled_ref-qa_ref)+BB.*dTs_drs_TRM_ref;

% sensitivity of 2m specific humidity to ground heat flux
dq2_dGrnd_TRM_ref = BB.*dTs_dGrnd_TRM_ref;

% sensitivity of 2m specific humidity to ra_prime
dq2_dra_prime_TRM_ref = (1./(ra_ref+rs_ref)).*(qs_sat_modeled_ref-qa_ref);

% to add
dq2_dswd_TRM_ref = zeros(size(dq2_dGrnd_TRM_ref));
dq2_drld_TRM_ref = zeros(size(dq2_dGrnd_TRM_ref));
dq2_dTa_TRM_ref  = zeros(size(dq2_dGrnd_TRM_ref));
dq2_dqa_TRM_ref  = zeros(size(dq2_dGrnd_TRM_ref));
dq2_demis_TRM_ref = zeros(size(dq2_dGrnd_TRM_ref));

%% calculate based on perturbation state
Ta_c_sel  = Ta_sel-273.15;
qa_sat_sel = qsat(Psurf_sel, Ta_sel);
lambda_o_sel = 1./(4*emis_sel*sb*Ta_sel.^3);

% sensitivity of surface saturated specific humidity to surface temperature
dqa_sat_dTa_sel = 0.622./Psurf_sel.*(2508.3./((Ta_c_sel + 237.3).^2).*exp((17.3.*Ta_c_sel)./(Ta_c_sel+237.3)))*1000;
Ts_modeled_sel = ((Rn_str_sel-Grnd_sel)-rho_air.*lv./(ra_sel+rs_sel).*(qa_sat_sel-qa_sel))./((1./lambda_o_sel)+rho_air.*Cp./ra_sel+rho_air.*lv./(ra_sel+rs_sel).*dqa_sat_dTa_sel)+Ta_sel;
T2_modeled_sel = f_2_TRM_sel.*(Ts_modeled_sel-Ta_sel)+ Ta_sel;

qs_sat_modeled_sel = qsat(Psurf_sel, Ts_modeled_sel); % modeled surface saturated specific humidity
% qs_modeled_sel = ra_sel./(ra_sel+rs_sel).*(qs_sat_modeled_sel-qa_sel)+qa_sel; % modeled surface specific humidity
q2_modeled_sel = ra_prime_sel./(ra_sel+rs_sel).*(qs_sat_modeled_sel-qa_sel)+qa_sel; % modeled 2m specific humidity

Ts_c_sel  = Ts_modeled_sel-273.15;
dqs_sat_dTs_sel = 0.622./Psurf_sel.*(2508.3./((Ts_c_sel + 237.3).^2).*exp((17.3.*Ts_c_sel)./(Ts_c_sel+237.3)))*1000; % de*/dT in kPa/K -- > Pa/K

% sensitivity of 2m saturated specific humidity to albedo
BB = ra_prime_sel./(ra_sel+rs_sel).*dqs_sat_dTs_sel;
dq2_dalpha_TRM_sel = BB.*dTs_dalpha_TRM_sel;

% sensitivity of 2m specific humidity to aerodynamic resistance
dq2_dra_TRM_sel = -ra_prime_sel./(ra_sel+rs_sel).^2.*(qs_sat_modeled_sel-qa_sel)+BB.*dTs_dra_TRM_sel;

% sensitivity of 2m specific humidity to surface resistance
dq2_drs_TRM_sel = -ra_prime_sel./(ra_sel+rs_sel).^2.*(qs_sat_modeled_sel-qa_sel)+BB.*dTs_drs_TRM_sel;

% sensitivity of 2m specific humidity to ground heat flux
dq2_dGrnd_TRM_sel = BB.*dTs_dGrnd_TRM_sel;

% sensitivity of 2m specific humidity to ra_prime
dq2_dra_prime_TRM_sel = (1./(ra_sel+rs_sel)).*(qs_sat_modeled_sel-qa_sel);

% to add
dq2_dswd_TRM_sel = zeros(size(dq2_dGrnd_TRM_sel));
dq2_drld_TRM_sel = zeros(size(dq2_dGrnd_TRM_sel));
dq2_dTa_TRM_sel  = zeros(size(dq2_dGrnd_TRM_sel));
dq2_dqa_TRM_sel  = zeros(size(dq2_dGrnd_TRM_sel));
dq2_demis_TRM_sel = zeros(size(dq2_dGrnd_TRM_sel));

