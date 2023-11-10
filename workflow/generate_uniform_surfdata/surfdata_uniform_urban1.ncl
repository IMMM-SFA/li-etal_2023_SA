;***********************************************
begin
;************************************************
  numrad = 2 
  nlevurb = 5

  f = addfile("/glade/work/wangly/inputdata/user_inputdata/nldas2_78pfts/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform.nc","w")
;print(f)
  CANYON_HWR      = f->CANYON_HWR
  EM_IMPROAD      = f->EM_IMPROAD
  EM_PERROAD      = f->EM_PERROAD
  EM_ROOF         = f->EM_ROOF
  EM_WALL         = f->EM_WALL 
  HT_ROOF         = f->HT_ROOF
  THICK_ROOF      = f->THICK_ROOF
  THICK_WALL      = f->THICK_WALL
  T_BUILDING_MIN  = f->T_BUILDING_MIN
  WIND_HGT_CANYON = f->WIND_HGT_CANYON
  WTLUNIT_ROOF    = f->WTLUNIT_ROOF
  NLEV_IMPROAD    = f->NLEV_IMPROAD
  ALB_IMPROAD_DIR = f->ALB_IMPROAD_DIR
  ALB_IMPROAD_DIF = f->ALB_IMPROAD_DIF
  ALB_PERROAD_DIR = f->ALB_PERROAD_DIR
  ALB_PERROAD_DIF = f->ALB_PERROAD_DIF
  ALB_ROOF_DIR    = f->ALB_ROOF_DIR
  ALB_ROOF_DIF    = f->ALB_ROOF_DIF
  ALB_WALL_DIR    = f->ALB_WALL_DIR
  ALB_WALL_DIF    = f->ALB_WALL_DIF
  TK_ROOF         = f->TK_ROOF
  TK_WALL         = f->TK_WALL 
  TK_IMPROAD      = f->TK_IMPROAD
  CV_ROOF         = f->CV_ROOF
  CV_WALL         = f->CV_WALL 
  CV_IMPROAD      = f->CV_IMPROAD  
  WTROAD_PERV     = f->WTROAD_PERV
  PCT_URBAN       = f->PCT_URBAN
  LATIXY          = f->LATIXY
  LONGXY          = f->LONGXY

  print(LATIXY(141,231))
  print(LONGXY(141,231))
exit
  CANYON_HWR      = where(CANYON_HWR.ne.0, CANYON_HWR(2,141,231), 0.)
  EM_IMPROAD      = where(CANYON_HWR.ne.0, EM_IMPROAD(2,141,231), 0.)
  EM_PERROAD      = where(CANYON_HWR.ne.0, EM_PERROAD(2,141,231), 0.)
  EM_ROOF         = where(CANYON_HWR.ne.0, EM_ROOF(2,141,231), 0.)
  EM_WALL         = where(CANYON_HWR.ne.0, EM_WALL(2,141,231), 0.)
  HT_ROOF         = where(CANYON_HWR.ne.0, HT_ROOF(2,141,231), 0.)
  THICK_ROOF      = where(CANYON_HWR.ne.0, THICK_ROOF(2,141,231), 0.)
  THICK_WALL      = where(CANYON_HWR.ne.0, THICK_WALL(2,141,231), 0.)
  T_BUILDING_MIN  = where(CANYON_HWR.ne.0, T_BUILDING_MIN(2,141,231), 0.)
  WIND_HGT_CANYON = where(CANYON_HWR.ne.0, WIND_HGT_CANYON(2,141,231), 0.)
  WTLUNIT_ROOF    = where(CANYON_HWR.ne.0, WTLUNIT_ROOF(2,141,231), 0.)
  NLEV_IMPROAD    = where(CANYON_HWR.ne.0, NLEV_IMPROAD(2,141,231), 0)
  do i=0,numrad-1
    ALB_IMPROAD_DIR(i,:,:,:) = where(CANYON_HWR.ne.0, ALB_IMPROAD_DIR(i,2,141,231), 0.)
    ALB_IMPROAD_DIF(i,:,:,:) = where(CANYON_HWR.ne.0, ALB_IMPROAD_DIF(i,2,141,231), 0.)
    ALB_PERROAD_DIR(i,:,:,:) = where(CANYON_HWR.ne.0, ALB_PERROAD_DIR(i,2,141,231), 0.)
    ALB_PERROAD_DIF(i,:,:,:) = where(CANYON_HWR.ne.0, ALB_PERROAD_DIF(i,2,141,231), 0.)
    ALB_ROOF_DIR(i,:,:,:)    = where(CANYON_HWR.ne.0, ALB_ROOF_DIR(i,2,141,231), 0.)
    ALB_ROOF_DIF(i,:,:,:)    = where(CANYON_HWR.ne.0, ALB_ROOF_DIF(i,2,141,231), 0.)
    ALB_WALL_DIR(i,:,:,:)    = where(CANYON_HWR.ne.0, ALB_WALL_DIR(i,2,141,231), 0.)
    ALB_WALL_DIF(i,:,:,:)    = where(CANYON_HWR.ne.0, ALB_WALL_DIF(i,2,141,231), 0.)
  end do
  do i=0,nlevurb-1
    TK_ROOF(i,:,:,:)    = where(CANYON_HWR.ne.0, TK_ROOF(i,2,141,231), 0.)
    TK_WALL(i,:,:,:)    = where(CANYON_HWR.ne.0, TK_WALL(i,2,141,231), 0.)
    TK_IMPROAD(i,:,:,:) = where(CANYON_HWR.ne.0, TK_IMPROAD(i,2,141,231), 0.)
    CV_ROOF(i,:,:,:)    = where(CANYON_HWR.ne.0, CV_ROOF(i,2,141,231), 0.)
    CV_WALL(i,:,:,:)    = where(CANYON_HWR.ne.0, CV_WALL(i,2,141,231), 0.)
    CV_IMPROAD(i,:,:,:) = where(CANYON_HWR.ne.0, CV_IMPROAD(i,2,141,231), 0.)
  end do

  WTROAD_PERV = where(CANYON_HWR.ne.0, 0.0001, 0.)

  PCT_URBAN_TOTAL = dim_sum_n(PCT_URBAN,0)  

  f->CANYON_HWR      = CANYON_HWR
  f->EM_IMPROAD      = EM_IMPROAD
  f->EM_PERROAD      = EM_PERROAD
  f->EM_ROOF         = EM_ROOF
  f->EM_WALL         = EM_WALL
  f->HT_ROOF         = HT_ROOF
  f->THICK_ROOF      = THICK_ROOF
  f->THICK_WALL      = THICK_WALL
  f->T_BUILDING_MIN  = T_BUILDING_MIN
  f->WIND_HGT_CANYON = WIND_HGT_CANYON
  f->WTLUNIT_ROOF    = WTLUNIT_ROOF
  f->NLEV_IMPROAD    = NLEV_IMPROAD
  f->ALB_IMPROAD_DIR = ALB_IMPROAD_DIR
  f->ALB_IMPROAD_DIF = ALB_IMPROAD_DIF
  f->ALB_PERROAD_DIR = ALB_PERROAD_DIR
  f->ALB_PERROAD_DIF = ALB_PERROAD_DIF
  f->ALB_ROOF_DIR    = ALB_ROOF_DIR
  f->ALB_ROOF_DIF    = ALB_ROOF_DIF
  f->ALB_WALL_DIR    = ALB_WALL_DIR
  f->ALB_WALL_DIF    = ALB_WALL_DIF
  f->TK_ROOF         = TK_ROOF
  f->TK_WALL         = TK_WALL
  f->TK_IMPROAD      = TK_IMPROAD
  f->CV_ROOF         = CV_ROOF
  f->CV_WALL         = CV_WALL
  f->CV_IMPROAD      = CV_IMPROAD
  f->WTROAD_PERV     = WTROAD_PERV
  f->PCT_URBAN       = PCT_URBAN
end 

