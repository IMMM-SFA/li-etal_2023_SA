% This is the Two-Resistance Mechanism attribution method for T2

function [Diff_T2,...
          Rn_str_ref, Grnd_ref,ro_ref,ra_ref,rs_ref,f_TRM_ref,...
          Rn_str_sel, Grnd_sel,ro_sel,ra_sel,rs_sel,f_TRM_sel,...            
          ra_prime_ref,f_2_TRM_ref,...
          ra_prime_sel,f_2_TRM_sel,...          
          dT2_dswd_TRM_ref,dT2_drld_TRM_ref,dT2_dTa_TRM_ref,dT2_dqa_TRM_ref,dT2_dalpha_TRM_ref,dT2_demis_TRM_ref,dT2_dra_TRM_ref,dT2_drs_TRM_ref,dT2_dGrnd_TRM_ref,dT2_dra_prime_TRM_ref,...
          dT2_dswd_TRM_sel,dT2_drld_TRM_sel,dT2_dTa_TRM_sel,dT2_dqa_TRM_sel,dT2_dalpha_TRM_sel,dT2_demis_TRM_sel,dT2_dra_TRM_sel,dT2_drs_TRM_sel,dT2_dGrnd_TRM_sel,dT2_dra_prime_TRM_sel]= ...
          REF_TRM(rho_air,Cp,sb,lv,...
              Psurf_ref,swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,Qh_ref,Qle_ref,Ts_ref,T2_ref, ...
              Psurf_sel,swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,Qh_sel,Qle_sel,Ts_sel,T2_sel)     
%% calculate 2-m air tempeature difference
          
Diff_T2 = T2_sel - T2_ref;
         
%%

          [Diff_Ts,...
          Rn_str_ref, Grnd_ref,ro_ref,ra_ref,rs_ref,f_TRM_ref,...
          Rn_str_sel, Grnd_sel,ro_sel,ra_sel,rs_sel,f_TRM_sel,...          
          dTs_dswd_TRM_ref,dTs_drld_TRM_ref,dTs_dTa_TRM_ref,dTs_dqa_TRM_ref,dTs_dalpha_TRM_ref,dTs_demis_TRM_ref,dTs_dra_TRM_ref,dTs_drs_TRM_ref,dTs_dGrnd_TRM_ref,...
          dTs_dswd_TRM_sel,dTs_drld_TRM_sel,dTs_dTa_TRM_sel,dTs_dqa_TRM_sel,dTs_dalpha_TRM_sel,dTs_demis_TRM_sel,dTs_dra_TRM_sel,dTs_drs_TRM_sel,dTs_dGrnd_TRM_sel]=...
          TRM(rho_air,Cp,sb,lv,...
              Psurf_ref,swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,Qh_ref,Qle_ref,Ts_ref,...
              Psurf_sel,swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,Qh_sel,Qle_sel,Ts_sel);

%%

ra_prime_ref = rho_air .* Cp .* (T2_ref - Ta_ref) ./ Qh_ref; % aerodynamic resistance for 2 m temperature 

f_2_TRM_ref = ra_prime_ref./ra_ref;

df_2_dra_TRM_ref = - ra_prime_ref./(ra_ref.^2);

df_2_dra_prime_TRM_ref = 1./ra_ref;
%% 

ra_prime_sel = rho_air .* Cp .* (T2_sel - Ta_sel) ./ Qh_sel; % aerodynamic resistance for 2 m temperature 

f_2_TRM_sel = ra_prime_sel./ra_sel;

df_2_dra_TRM_sel = - ra_prime_sel./(ra_sel.^2);

df_2_dra_prime_TRM_sel = 1./ra_sel;

%%

dT2_dswd_TRM_ref = dTs_dswd_TRM_ref.*f_2_TRM_ref;
dT2_drld_TRM_ref = dTs_drld_TRM_ref.*f_2_TRM_ref;
dT2_dTa_TRM_ref  = dTs_dTa_TRM_ref.*f_2_TRM_ref;
dT2_dqa_TRM_ref  = dTs_dqa_TRM_ref.*f_2_TRM_ref;
dT2_dalpha_TRM_ref = dTs_dalpha_TRM_ref.*f_2_TRM_ref;
dT2_demis_TRM_ref  = dTs_demis_TRM_ref.*f_2_TRM_ref;
dT2_dra_TRM_ref    = dTs_dra_TRM_ref.*f_2_TRM_ref + df_2_dra_TRM_ref.*(Ts_ref - Ta_ref);
dT2_drs_TRM_ref    = dTs_drs_TRM_ref.*f_2_TRM_ref;
dT2_dGrnd_TRM_ref  = dTs_dGrnd_TRM_ref.*f_2_TRM_ref;
dT2_dra_prime_TRM_ref  = df_2_dra_prime_TRM_ref;


%%

dT2_dswd_TRM_sel = dTs_dswd_TRM_sel.*f_2_TRM_sel;
dT2_drld_TRM_sel = dTs_drld_TRM_sel.*f_2_TRM_sel;
dT2_dTa_TRM_sel  = dTs_dTa_TRM_sel.*f_2_TRM_sel;
dT2_dqa_TRM_sel  = dTs_dqa_TRM_sel.*f_2_TRM_sel;
dT2_dalpha_TRM_sel = dTs_dalpha_TRM_sel.*f_2_TRM_sel;
dT2_demis_TRM_sel  = dTs_demis_TRM_sel.*f_2_TRM_sel;
dT2_dra_TRM_sel    = dTs_dra_TRM_sel.*f_2_TRM_sel + df_2_dra_TRM_sel.*(Ts_sel - Ta_sel);
dT2_drs_TRM_sel    = dTs_drs_TRM_sel.*f_2_TRM_sel;
dT2_dGrnd_TRM_sel  = dTs_dGrnd_TRM_sel.*f_2_TRM_sel;
dT2_dra_prime_TRM_sel  = df_2_dra_prime_TRM_sel;

