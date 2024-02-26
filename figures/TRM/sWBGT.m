function [WGT_ref, WGT_sel,...
    dWGT_dTs_ref, dWGT_dqs_ref, dWGT_dps_ref, ...
    dWGT_dTs_sel, dWGT_dqs_sel, dWGT_dps_sel] ...
    = sWBGT(Psurf_ref,Ts_ref,qs_ref,Psurf_sel,Ts_sel,qs_sel)


WGT_ref = 0.567*(Ts_ref-273.15)+0.632/100.*qs_ref.*Psurf_ref+3.94;
WGT_sel = 0.567*(Ts_sel-273.15)+0.632/100.*qs_sel.*Psurf_sel+3.94;


% sensitivity of Wet-Bulb Globe Temperature (WGT) to surface temperature,
dWGT_dTs_ref = 0.567;
dWGT_dTs_sel = 0.567;

% sensitivity of WGT to surface specific humidity
dWGT_dqs_ref = 0.632/100.*Psurf_ref;  % 0.632=0.393/0.622
dWGT_dqs_sel = 0.632/100.*Psurf_sel;

% sensitivity of WGT to surface pressure
dWGT_dps_ref = 0.632/100.*qs_ref;  % DL there was a bug
dWGT_dps_sel = 0.632/100.*qs_sel;

