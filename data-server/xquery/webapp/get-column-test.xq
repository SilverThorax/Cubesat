(: Author: Marek Pomocka :)

declare option output:method "json";

declare variable $db := db:open('satdata');

declare variable $satellite-name as xs:string := 'Sat1';
declare variable $time-from as xs:dateTime := xs:dateTime('2009-10-05T11:02:37.343');
declare variable $time-to as xs:dateTime := xs:dateTime('2009-10-07T12:42:38.473');
declare variable $column as xs:string := 'HK_EPS_LR_COM';
declare variable $allowed-columns := ('HK_EPS_LR_COM',  'HK_EPS_LR_ADCS',  'HK_EPS_LR_CDMS',  'HK_EPS_LR_PL',  'HK_EPS_BAT1_1_V',  'HK_EPS_BAT1_2_V',  'HK_EPS_BAT2_1_V',  'HK_EPS_BAT2_2_V',  'HK_EPS_BAT1_TP',  'HK_EPS_BAT2_TP',  'HK_EPS_PBUS_D_V',  'HK_EPS_PBUS_A_V',  'HK_EPS_EXT_TP',  'HK_EPS_FRAME_TP',  'HK_EPS_MC_TP',  'HK_EPS_PCB_TP',  'HK_EPS_MB_TP',  'HK_EPS_XN_CU',  'HK_EPS_XP_CU',  'HK_EPS_YN_CU',  'HK_EPS_YP_CU',  'HK_EPS_ZN_CU',  'HK_EPS_ZP_CU',  'HK_EPS_XN_TP',  'HK_EPS_XP_TP',  'HK_EPS_YN_TP',  'HK_EPS_YP_TP',  'HK_EPS_ZN_TP',  'HK_EPS_ZP_TP',  'HK_EPS_ED_PL',  'HK_EPS_ED_ADCS',  'HK_EPS_ST_ADS1_2',  'HK_EPS_ST_PL',  'HK_EPS_ST_ADCS',  'HK_EPS_ST_CDMS',  'HK_EPS_ST_BEAC',  'HK_EPS_ST_COM',  'HK_EPS_EF_PL',  'HK_EPS_EF_ADCS',  'HK_EPS_EF_CDMS',  'HK_EPS_EF_COM',  'HK_EPS_EF_EPS',  'HK_EPS_MODE',  'HK_EPS_ERROR_COD',  'HK_EPS_WD_T_OUT');

(: check if column is allowed :)
if ($allowed-columns = $column) then
  element json {
    attribute objects { 'json measurement' },
    for $val in $db/sat[@name=$satellite-name]/mes/*[name()=$column]
    let $time := xs:dateTime($val/parent::mes/@time/data())
    where $time ge $time-from and $time le $time-to
    return
    element measurement {
      element time { $time },
      element value { $val/data() }
    }
  }
else
  element json {
    attribute objects { 'json' },
    element error {
    'Column not allowed'
    }
  }