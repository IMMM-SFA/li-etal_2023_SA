
function m_TRM_sel_opt=m_optimize(Diff_Ts,mask,...
                     dTs_dswd_TRM_ref,dTs_drld_TRM_ref,dTs_dTa_TRM_ref,dTs_dqa_TRM_ref,dTs_dalpha_TRM_ref,dTs_demis_TRM_ref,dTs_dra_TRM_ref,dTs_drs_TRM_ref,dTs_dGrnd_TRM_ref,...
                     dTs_dswd_TRM_sel,dTs_drld_TRM_sel,dTs_dTa_TRM_sel,dTs_dqa_TRM_sel,dTs_dalpha_TRM_sel,dTs_demis_TRM_sel,dTs_dra_TRM_sel,dTs_drs_TRM_sel,dTs_dGrnd_TRM_sel,...
                     swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,ra_ref,rs_ref,Grnd_ref,...
                     swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,ra_sel,rs_sel,Grnd_sel)


% m_TRM_sel_opt = nan(length(Diff_Ts(:,1)),1);
[nrow, ncol, ~] = size(Diff_Ts);
m_TRM_sel_opt = nan(nrow,ncol);

for iRow = 1:nrow
    for iCol = 1:ncol
    
        if all(isnan(Diff_Ts(iRow,iCol,:)))
            continue;
        end
    
        m_sel = 0:0.1:10;
        m_RMSE_TRM = nan(length(m_sel),1);

        for im_sel = 1:length(m_sel)

            m_TRM_ref = 1;
            m_TRM_sel = m_sel(im_sel);

            dTs_dswd_TRM = (m_TRM_ref*dTs_dswd_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dswd_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_dalpha_TRM = (m_TRM_ref*dTs_dalpha_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dalpha_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_demis_TRM = (m_TRM_ref*dTs_demis_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_demis_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_drld_TRM = (m_TRM_ref*dTs_drld_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_drld_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_dra_TRM = (m_TRM_ref*dTs_dra_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dra_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_drs_TRM = (m_TRM_ref*dTs_drs_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_drs_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_dqa_TRM = (m_TRM_ref*dTs_dqa_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dqa_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_dTa_TRM = (m_TRM_ref*dTs_dTa_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dTa_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dTs_dGrnd_TRM = (m_TRM_ref*dTs_dGrnd_TRM_ref(iRow,iCol,:)+m_TRM_sel*dTs_dGrnd_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);

            Diff_swd_TRM = swd_sel(iRow,iCol,:) - swd_ref(iRow,iCol,:);
            Diff_rld_TRM = lwd_sel(iRow,iCol,:) - lwd_ref(iRow,iCol,:);
            Diff_Ta_TRM  = Ta_sel(iRow,iCol,:)  - Ta_ref (iRow,iCol,:);
            Diff_qa_TRM  = qa_sel(iRow,iCol,:)  - qa_ref (iRow,iCol,:);


            Diff_alpha_TRM = alpha_sel(iRow,iCol,:) - alpha_ref(iRow,iCol,:);
            Diff_emis_TRM  = emis_sel - emis_ref;
            Diff_ra_TRM    = ra_sel(iRow,iCol,:) - ra_ref(iRow,iCol,:);
            Diff_rs_TRM    = rs_sel(iRow,iCol,:) - rs_ref(iRow,iCol,:);
            Diff_Grnd_TRM  = Grnd_sel(iRow,iCol,:) - Grnd_ref(iRow,iCol,:);

            Ts_term_swd_TRM = dTs_dswd_TRM.*Diff_swd_TRM;
            Ts_term_rld_TRM = dTs_drld_TRM.*Diff_rld_TRM;
            Ts_term_Ta_TRM = dTs_dTa_TRM.*Diff_Ta_TRM;
            Ts_term_qa_TRM = dTs_dqa_TRM.*Diff_qa_TRM;

            Ts_term_alpha_TRM= dTs_dalpha_TRM.*Diff_alpha_TRM;
            Ts_term_emis_TRM = dTs_demis_TRM.*Diff_emis_TRM;
            Ts_term_ra_TRM   = dTs_dra_TRM.*Diff_ra_TRM;
            Ts_term_rs_TRM   = dTs_drs_TRM.*Diff_rs_TRM;
            Ts_term_Grnd_TRM = dTs_dGrnd_TRM.*Diff_Grnd_TRM;

            Ts_sum_TRM = Ts_term_swd_TRM + Ts_term_alpha_TRM + Ts_term_emis_TRM + Ts_term_rld_TRM...
                    + Ts_term_ra_TRM + Ts_term_rs_TRM + Ts_term_qa_TRM + Ts_term_Ta_TRM + Ts_term_Grnd_TRM;

            % In this code, it uses all data in the time domain to optimize m  

            Diff_TRM = (Diff_Ts(iRow,iCol,:).*mask(iRow,iCol,:)-Ts_sum_TRM.*mask(iRow,iCol,:)).^2;

            m_RMSE_TRM(im_sel,1) = sqrt(nanmean(Diff_TRM(:)));

            if im_sel >= 2 && m_RMSE_TRM(im_sel,1) > m_RMSE_TRM(im_sel-1,1)
                break;
            end   

        end

        [RMSE_TRM_min, RMSE_TRM_index] = min(m_RMSE_TRM);
        m_TRM_sel_opt(iRow,iCol) = m_sel(RMSE_TRM_index);
        disp(['Optimize: iRow = ' num2str(iRow) '; iCol = ' num2str(iCol) '; m_opt = ' num2str(m_TRM_sel_opt(iRow,iCol))])
        
    end

end

