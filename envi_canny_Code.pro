PRO ENVI_Canny_define_buttons, buttonInfo

; zw52@iu.edu Zhaojie Wang

  ENVI_DEFINE_MENU_BUTTON, buttonInfo,  $
    VALUE = 'Canny', $
    uValue = '', $
    event_pro ='ENVI_Canny', $
    REF_VALUE = 'Filter', $
    POSITION=1

end


PRO ENVI_Canny, event

;zw52@iu.edu Zhaojie Wang

COMPILE_OPT idl2
;Select the input file         zw52
envi_select, fid=fid, /BAND_ONLY, pos=pos
if fid eq -1 then return
print,fid,pos

;Query information             zw52
ENVI_FILE_QUERY, fid, dims=dims, ns=ns, nl=nl, nb=nb
;Get the data                  zw52
data= ENVI_GET_DATA(fid=fid, dims=dims, pos=pos)
;
;Canny function                zw52
result = canny(data)
;
ouput = envi_pickfile(/output)
if output eq "" then begin
  envi_enter_data, result
  endif else begin
    openw, lun, output, /GET_LUN
    writeu, lun, result
    free_lun, lun
    ;Write out the header file       zw52
    ENVI_SETUP_HEAD,fname=output,$
      ns=ns,nl=nl,nb=nb,wl=wl,               $
      interleave=0,data_type=1,              $
      offset=offset, map_info=map_info,      $
      bnames = bnames,                       $
      wavelength_units = wu,                 $
      sensor_type = sensor_type,             $
      file_type = file_type,                 $
      /write,/open,r_fid=r_fid      
      
    ;
    ENVI_DISPLAY_BANDS,r_fid,0
  
  endelse


end