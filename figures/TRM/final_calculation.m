
function [dTs_dswd_TRM,dTs_drld_TRM,dTs_dTa_TRM,dTs_dqa_TRM,dTs_dalpha_TRM,dTs_demis_TRM,dTs_dra_TRM,dTs_drs_TRM,dTs_dGrnd_TRM,...
          Ts_term_swd_TRM,Ts_term_rld_TRM,Ts_term_Ta_TRM,Ts_term_qa_TRM,Ts_term_alpha_TRM,Ts_term_emis_TRM,Ts_term_ra_TRM,Ts_term_rs_TRM,Ts_term_Grnd_TRM,...
          Ts_sum_TRM] = final_calculation(m_TRM_sel_opt,mask,...
                     dTs_dswd_TRM_ref,dTs_drld_TRM_ref,dTs_dTa_TRM_ref,dTs_dqa_TRM_ref,dTs_dalpha_TRM_ref,dTs_demis_TRM_ref,dTs_dra_TRM_ref,dTs_drs_TRM_ref,dTs_dGrnd_TRM_ref,...
                     dTs_dswd_TRM_sel,dTs_drld_TRM_sel,dTs_dTa_TRM_sel,dTs_dqa_TRM_sel,dTs_dalpha_TRM_sel,dTs_demis_TRM_sel,dTs_dra_TRM_sel,dTs_drs_TRM_sel,dTs_dGrnd_TRM_sel,...
                     swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,ra_ref,rs_ref,Grnd_ref,...
                     swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,ra_sel,rs_sel,Grnd_sel)

m_TRM_ref      = 1;
m_TRM_sel      = repmat(m_TRM_sel_opt,1,1,length(mask(1,1,:)));

dTs_dswd_TRM   = (m_TRM_ref*dTs_dswd_TRM_ref+m_TRM_sel.*dTs_dswd_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_drld_TRM   = (m_TRM_ref*dTs_drld_TRM_ref+m_TRM_sel.*dTs_drld_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_dTa_TRM    = (m_TRM_ref*dTs_dTa_TRM_ref+m_TRM_sel.*dTs_dTa_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_dqa_TRM    = (m_TRM_ref*dTs_dqa_TRM_ref+m_TRM_sel.*dTs_dqa_TRM_sel)./(m_TRM_ref+m_TRM_sel);

dTs_dalpha_TRM = (m_TRM_ref*dTs_dalpha_TRM_ref+m_TRM_sel.*dTs_dalpha_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_demis_TRM  = (m_TRM_ref*dTs_demis_TRM_ref+m_TRM_sel.*dTs_demis_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_dra_TRM    = (m_TRM_ref*dTs_dra_TRM_ref+m_TRM_sel.*dTs_dra_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_drs_TRM    = (m_TRM_ref*dTs_drs_TRM_ref+m_TRM_sel.*dTs_drs_TRM_sel)./(m_TRM_ref+m_TRM_sel);
dTs_dGrnd_TRM  = (m_TRM_ref*dTs_dGrnd_TRM_ref+m_TRM_sel.*dTs_dGrnd_TRM_sel)./(m_TRM_ref+m_TRM_sel);

Diff_swd_TRM   = swd_sel - swd_ref;
Diff_rld_TRM   = lwd_sel - lwd_ref;
Diff_Ta_TRM    = Ta_sel  - Ta_ref ;
Diff_qa_TRM    = qa_sel  - qa_ref ;
Diff_alpha_TRM = alpha_sel - alpha_ref;
Diff_emis_TRM  = emis_sel - emis_ref;
Diff_ra_TRM    = ra_sel - ra_ref;
Diff_rs_TRM    = rs_sel - rs_ref;
Diff_Grnd_TRM  = Grnd_sel - Grnd_ref;

Ts_term_swd_TRM = dTs_dswd_TRM.*Diff_swd_TRM;
Ts_term_rld_TRM = dTs_drld_TRM.*Diff_rld_TRM;
Ts_term_Ta_TRM = dTs_dTa_TRM.*Diff_Ta_TRM;
Ts_term_qa_TRM = dTs_dqa_TRM.*Diff_qa_TRM;
Ts_term_alpha_TRM = dTs_dalpha_TRM.*Diff_alpha_TRM;
Ts_term_emis_TRM  = dTs_demis_TRM.*Diff_emis_TRM;
Ts_term_ra_TRM = dTs_dra_TRM.*Diff_ra_TRM;
Ts_term_rs_TRM = dTs_drs_TRM.*Diff_rs_TRM;
Ts_term_Grnd_TRM = dTs_dGrnd_TRM.*Diff_Grnd_TRM;

Ts_sum_TRM = Ts_term_swd_TRM + Ts_term_alpha_TRM + Ts_term_emis_TRM + Ts_term_rld_TRM...
        + Ts_term_ra_TRM + Ts_term_rs_TRM + Ts_term_qa_TRM + Ts_term_Ta_TRM + Ts_term_Grnd_TRM;
