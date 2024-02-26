
function m_TRM_sel_opt=m_optimize_T2(Diff_T2,mask,...
                     dT2_dswd_TRM_ref,dT2_drld_TRM_ref,dT2_dTa_TRM_ref,dT2_dqa_TRM_ref,dT2_dalpha_TRM_ref,dT2_demis_TRM_ref,dT2_dra_TRM_ref,dT2_drs_TRM_ref,dT2_dGrnd_TRM_ref,dT2_dra_prime_TRM_ref, ...
                     dT2_dswd_TRM_sel,dT2_drld_TRM_sel,dT2_dTa_TRM_sel,dT2_dqa_TRM_sel,dT2_dalpha_TRM_sel,dT2_demis_TRM_sel,dT2_dra_TRM_sel,dT2_drs_TRM_sel,dT2_dGrnd_TRM_sel,dT2_dra_prime_TRM_sel, ...
                     swd_ref,lwd_ref,Ta_ref,qa_ref,alpha_ref,emis_ref,ra_ref,rs_ref,Grnd_ref,ra_prime_ref,...
                     swd_sel,lwd_sel,Ta_sel,qa_sel,alpha_sel,emis_sel,ra_sel,rs_sel,Grnd_sel,ra_prime_sel)


% m_TRM_sel_opt = nan(length(Diff_T2(:,1)),1);
[nrow, ncol, ~] = size(Diff_T2);
m_TRM_sel_opt = nan(nrow,ncol);

for iRow = 1:nrow
    for iCol = 1:ncol
    
        if all(isnan(Diff_T2(iRow,iCol,:)))
            continue;
        end
    
        m_sel = 0:0.1:20;
        m_RMSE_TRM = nan(length(m_sel),1);

        for im_sel = 1:length(m_sel)

            m_TRM_ref = 1;
            m_TRM_sel = m_sel(im_sel);

            dT2_dswd_TRM = (m_TRM_ref*dT2_dswd_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dswd_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dalpha_TRM = (m_TRM_ref*dT2_dalpha_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dalpha_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_demis_TRM = (m_TRM_ref*dT2_demis_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_demis_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_drld_TRM = (m_TRM_ref*dT2_drld_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_drld_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dra_TRM = (m_TRM_ref*dT2_dra_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dra_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_drs_TRM = (m_TRM_ref*dT2_drs_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_drs_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dqa_TRM = (m_TRM_ref*dT2_dqa_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dqa_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dTa_TRM = (m_TRM_ref*dT2_dTa_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dTa_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dGrnd_TRM = (m_TRM_ref*dT2_dGrnd_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dGrnd_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);
            dT2_dra_prime_TRM = (m_TRM_ref*dT2_dra_prime_TRM_ref(iRow,iCol,:)+m_TRM_sel*dT2_dra_prime_TRM_sel(iRow,iCol,:))/(m_TRM_ref+m_TRM_sel);

            Diff_swd_TRM = swd_sel(iRow,iCol,:) - swd_ref(iRow,iCol,:);
            Diff_rld_TRM = lwd_sel(iRow,iCol,:) - lwd_ref(iRow,iCol,:);
            Diff_Ta_TRM  = Ta_sel(iRow,iCol,:)  - Ta_ref (iRow,iCol,:);
            Diff_qa_TRM  = qa_sel(iRow,iCol,:)  - qa_ref (iRow,iCol,:);


            Diff_alpha_TRM = alpha_sel(iRow,iCol,:) - alpha_ref(iRow,iCol,:);
            Diff_emis_TRM  = emis_sel - emis_ref;
            Diff_ra_TRM    = ra_sel(iRow,iCol,:) - ra_ref(iRow,iCol,:);
            Diff_rs_TRM    = rs_sel(iRow,iCol,:) - rs_ref(iRow,iCol,:);
            Diff_Grnd_TRM  = Grnd_sel(iRow,iCol,:) - Grnd_ref(iRow,iCol,:);
            Diff_ra_prime_TRM  = ra_prime_sel(iRow,iCol,:) - ra_prime_ref(iRow,iCol,:);
            

            T2_term_swd_TRM = dT2_dswd_TRM.*Diff_swd_TRM;
            T2_term_rld_TRM = dT2_drld_TRM.*Diff_rld_TRM;
            T2_term_Ta_TRM = dT2_dTa_TRM.*Diff_Ta_TRM;
            T2_term_qa_TRM = dT2_dqa_TRM.*Diff_qa_TRM;

            T2_term_alpha_TRM= dT2_dalpha_TRM.*Diff_alpha_TRM;
            T2_term_emis_TRM = dT2_demis_TRM.*Diff_emis_TRM;
            T2_term_ra_TRM   = dT2_dra_TRM.*Diff_ra_TRM;
            T2_term_rs_TRM   = dT2_drs_TRM.*Diff_rs_TRM;
            T2_term_Grnd_TRM = dT2_dGrnd_TRM.*Diff_Grnd_TRM;
            
            T2_term_ra_prime_TRM = dT2_dra_prime_TRM.*Diff_ra_prime_TRM;

            T2_sum_TRM = T2_term_swd_TRM + T2_term_alpha_TRM + T2_term_emis_TRM + T2_term_rld_TRM...
                    + T2_term_ra_TRM + T2_term_rs_TRM + T2_term_qa_TRM + T2_term_Ta_TRM + T2_term_Grnd_TRM + T2_term_ra_prime_TRM;

            % In this code, it uses all data in the time domain to optimize m  

            Diff_TRM = (Diff_T2(iRow,iCol,:).*mask(iRow,iCol,:)-T2_sum_TRM.*mask(iRow,iCol,:)).^2;

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

%           m_TRM_sel_opt(m_TRM_sel_opt==max(m_sel)) = nan;    


