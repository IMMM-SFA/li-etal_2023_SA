;***********************************************
begin
;************************************************
  nlevurb = 5
  scale = (/2,5,10,20,50/)
  nscale = dimsizes(scale)
  
  do j=0,nscale-1

    print(scale(j))
    f = addfile("/glade/work/wangly/inputdata/user_inputdata/nldas2_78pfts/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx"+scale(j)+".nc","w")
    CANYON_HWR      = f->CANYON_HWR
    TK_ROOF         = f->TK_ROOF
    TK_WALL         = f->TK_WALL
    TK_IMPROAD      = f->TK_IMPROAD
    CV_ROOF         = f->CV_ROOF
    CV_WALL         = f->CV_WALL
    CV_IMPROAD      = f->CV_IMPROAD

    do i=0,nlevurb-1
      TK_ROOF(i,:,:,:)    = where(CANYON_HWR.ne.0, TK_ROOF(i,2,141,231)*scale(j), 0.)
      TK_WALL(i,:,:,:)    = where(CANYON_HWR.ne.0, TK_WALL(i,2,141,231)*scale(j), 0.)
      TK_IMPROAD(i,:,:,:) = where(CANYON_HWR.ne.0, TK_IMPROAD(i,2,141,231)*scale(j), 0.)
      CV_ROOF(i,:,:,:)    = where(CANYON_HWR.ne.0, CV_ROOF(i,2,141,231)*scale(j), 0.)
      CV_WALL(i,:,:,:)    = where(CANYON_HWR.ne.0, CV_WALL(i,2,141,231)*scale(j), 0.)
      CV_IMPROAD(i,:,:,:) = where(CANYON_HWR.ne.0, CV_IMPROAD(i,2,141,231)*scale(j), 0.)
    end do

    f->TK_ROOF         = TK_ROOF
    f->TK_WALL         = TK_WALL
    f->TK_IMPROAD      = TK_IMPROAD
    f->CV_ROOF         = CV_ROOF
    f->CV_WALL         = CV_WALL
    f->CV_IMPROAD      = CV_IMPROAD
  end do
end 

