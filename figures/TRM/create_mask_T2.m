function mask = create_mask_T2(ra_ref,ra_sel,ra_prime_ref,ra_prime_sel,rs_ref,rs_sel,Qh_ref,Qh_sel,Qle_ref,Qle_sel,limit)

mask = ones(size(ra_ref));

mask(ra_ref < 0) = NaN;
mask(ra_sel < 0) = NaN;
mask(ra_prime_ref < 0) = NaN;
mask(ra_prime_sel < 0) = NaN;
mask(rs_ref < 0) = NaN;
mask(rs_sel < 0) = NaN;

mask(abs(Qh_ref) < limit) = NaN;
mask(abs(Qh_sel) < limit) = NaN;
mask(abs(Qle_ref) < limit) = NaN;
mask(abs(Qle_sel) < limit) = NaN;
