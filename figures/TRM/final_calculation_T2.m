
function [dT2_dswd_TRM,dT2_drld_TRM,dT2_dTa_TRM,dT2_dqa_TRM,dT2_dalpha_TRM,dT2_demis_TRM,dT2_dra_TRM,dT2_drs_TRM,dT2_dGrnd_TRM,dT2_dra_prime_TRM,...
          T2_term_swd_TRM,T2_term_rld_TRM,T2_term_Ta_TRM,T2_term_qa_TRM,T2_term_alpha_TRM,T2_term_emis_TRM,T2_term_ra_TRM,T2_term_rs_TRM,T2_term_Grnd_TRM,T2_term_ra_prime_TRM,...
          T2_sum_TRM] = final_calculation_T2(m_TRM_sel_opt,mask,...
                     dT2_dswd_TRM_ref,dT2_drld_TRM_ref,dT2_dTa_TRM_ref,dT2_dqa_TRM_ref,dT2_dalpha_TRM_ref,dT2_demis_TRM_ref,dT2_dra_TRM_ref,dT2_drs_TRM_ref,dT2_dGrnd_TRM_ref,dT2_dra_prime_TRM_ref,...
                     dT2_dswd_TRM_sel,dT2_drld_TRM_sel,dT2_dTa_TRM_sel,dT2_dqa_TRM_sel,dT2_dalpha_TRM_sel,dT2_demis_TRM_sel,dT2_dra_TRM_sel,dT2_drs_TRM_sel,dT2_dGrnd_TRM_sel,dT2_dra_prime_TRM_sel,...
                     swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,ra_ref,rs_ref,Grnd_ref,ra_prime_ref,...
                     swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,ra_sel,rs_sel,Grnd_sel,ra_prime_sel)

m_TRM_ref      = 1;
m_TRM_sel      = repmat(m_TRM_sel_opt,1,1,length(mask(1,1,:)));

dT2_dswd_TRM   = (m_TRM_ref*dT2_dswd_TRM_ref+m_TRM_sel.*dT2_dswd_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_drld_TRM   = (m_TRM_ref*dT2_drld_TRM_ref+m_TRM_sel.*dT2_drld_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_dTa_TRM    = (m_TRM_ref*dT2_dTa_TRM_ref+m_TRM_sel.*dT2_dTa_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_dqa_TRM    = (m_TRM_ref*dT2_dqa_TRM_ref+m_TRM_sel.*dT2_dqa_TRM_sel)./(m_TRM_ref+m_TRM_sel);

dT2_dalpha_TRM = (m_TRM_ref*dT2_dalpha_TRM_ref+m_TRM_sel.*dT2_dalpha_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_demis_TRM  = (m_TRM_ref*dT2_demis_TRM_ref+m_TRM_sel.*dT2_demis_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_dra_TRM    = (m_TRM_ref*dT2_dra_TRM_ref+m_TRM_sel.*dT2_dra_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_drs_TRM    = (m_TRM_ref*dT2_drs_TRM_ref+m_TRM_sel.*dT2_drs_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_dGrnd_TRM  = (m_TRM_ref*dT2_dGrnd_TRM_ref+m_TRM_sel.*dT2_dGrnd_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dT2_dra_prime_TRM = (m_TRM_ref*dT2_dra_prime_TRM_ref+m_TRM_sel.*dT2_dra_prime_TRM_sel)./(m_TRM_ref+m_TRM_sel);

Diff_swd_TRM   = swd_sel - swd_ref;
Diff_rld_TRM   = lwd_sel - lwd_ref;
Diff_Ta_TRM    = Ta_sel  - Ta_ref ;
Diff_qa_TRM    = qa_sel  - qa_ref ;
Diff_alpha_TRM = alpha_sel - alpha_ref;
Diff_emis_TRM  = emis_sel - emis_ref;
Diff_ra_TRM    = ra_sel - ra_ref;
Diff_rs_TRM    = rs_sel - rs_ref;
Diff_Grnd_TRM  = Grnd_sel - Grnd_ref;
Diff_ra_prime_TRM  = ra_prime_sel - ra_prime_ref;


T2_term_swd_TRM = dT2_dswd_TRM.*Diff_swd_TRM;
T2_term_rld_TRM = dT2_drld_TRM.*Diff_rld_TRM;
T2_term_Ta_TRM = dT2_dTa_TRM.*Diff_Ta_TRM;
T2_term_qa_TRM = dT2_dqa_TRM.*Diff_qa_TRM;
T2_term_alpha_TRM = dT2_dalpha_TRM.*Diff_alpha_TRM;
T2_term_emis_TRM  = dT2_demis_TRM.*Diff_emis_TRM;
T2_term_ra_TRM = dT2_dra_TRM.*Diff_ra_TRM;
T2_term_rs_TRM = dT2_drs_TRM.*Diff_rs_TRM;
T2_term_Grnd_TRM = dT2_dGrnd_TRM.*Diff_Grnd_TRM;
T2_term_ra_prime_TRM = dT2_dra_prime_TRM.*Diff_ra_prime_TRM;

T2_sum_TRM = T2_term_swd_TRM + T2_term_alpha_TRM + T2_term_emis_TRM + T2_term_rld_TRM...
        + T2_term_ra_TRM + T2_term_rs_TRM + T2_term_qa_TRM + T2_term_Ta_TRM + T2_term_Grnd_TRM + T2_term_ra_prime_TRM;
