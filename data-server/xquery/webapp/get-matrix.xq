(: Author: Marek Pomocka :)

declare option output:method "json";

declare variable $db := db:open('satdata');

declare variable $satellite-names  as xs:string external;
declare variable $satellite-names-loc as xs:string+ := tokenize($satellite-names, ',');
declare variable $time-from as xs:dateTime external;
declare variable $time-to as xs:dateTime external;
declare variable $columns  as xs:string external;
declare variable $columns-loc as xs:string+ := tokenize($columns, ',');
declare variable $allowed-columns := ('HK_EPS_LR_COM',  'HK_EPS_LR_ADCS',  'HK_EPS_LR_CDMS',  'HK_EPS_LR_PL',  'HK_EPS_BAT1_1_V',  'HK_EPS_BAT1_2_V',  'HK_EPS_BAT2_1_V',  'HK_EPS_BAT2_2_V',  'HK_EPS_BAT1_TP',  'HK_EPS_BAT2_TP',  'HK_EPS_PBUS_D_V',  'HK_EPS_PBUS_A_V',  'HK_EPS_EXT_TP',  'HK_EPS_FRAME_TP',  'HK_EPS_MC_TP',  'HK_EPS_PCB_TP',  'HK_EPS_MB_TP',  'HK_EPS_XN_CU',  'HK_EPS_XP_CU',  'HK_EPS_YN_CU',  'HK_EPS_YP_CU',  'HK_EPS_ZN_CU',  'HK_EPS_ZP_CU',  'HK_EPS_XN_TP',  'HK_EPS_XP_TP',  'HK_EPS_YN_TP',  'HK_EPS_YP_TP',  'HK_EPS_ZN_TP',  'HK_EPS_ZP_TP',  'HK_EPS_ED_PL',  'HK_EPS_ED_ADCS',  'HK_EPS_ST_ADS1_2',  'HK_EPS_ST_PL',  'HK_EPS_ST_ADCS',  'HK_EPS_ST_CDMS',  'HK_EPS_ST_BEAC',  'HK_EPS_ST_COM',  'HK_EPS_EF_PL',  'HK_EPS_EF_ADCS',  'HK_EPS_EF_CDMS',  'HK_EPS_EF_COM',  'HK_EPS_EF_EPS',  'HK_EPS_MODE',  'HK_EPS_ERROR_COD',  'HK_EPS_WD_T_OUT');

(: check if column is allowed :)
if ($allowed-columns = $columns-loc) then
  element json {
    attribute objects { 'json measurement' },
    for $val in $db/sat[@name = $satellite-names-loc]/mes/*[name()=$columns-loc]
    let $time := xs:dateTime($val/parent::mes/@time/data())
    let $sat-name := $val/parent::mes/parent::sat/@name/data()
    where $time ge $time-from and $time le $time-to
    return
    element measurement {
      element satellite { $sat-name },
      element column { $val/name() },
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
