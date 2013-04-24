Satellite data server
---------------------

The directory contains XQuery scripts for demonstration satellite data server developed
during *Space Apps Challenge 2013* in Lausanne.

It serves JSON responses that represent monitored satellite parameters (e.g. temperature or voltage levels on a battery) based on supplied query criteria.

The served data is intended to be used by mobile the application running on iPad or an Android device, which can be found in root directory under `mobile_app` directory.

## Setup
The XQuery scripts were written for [BaseX open source XML database](http://basex.org/) version 7.6, which needs to be installed on your server.

### Data import
In order for the scripts to run, you need to import data representing satellite parameters into BaseX database using [CSV importer](http://docs.basex.org/wiki/Parsers#CSV_Parser).
The CSV files should be imported into database *satdata* (name can customized using XQuery *$db* variable) and the CSV file should have the following format:

The 1st line is the header field

    timestamp (e.g. 07/10/2009 12:43:06.103), name_of_param_1, name_of_param_2, ... name_of_param_n

Line 2 until the end of the file should contain the values.

The allowed parameters are `HK_EPS_LR_COM`, `HK_EPS_LR_ADCS`, `HK_EPS_LR_CDMS`, `HK_EPS_LR_PL`, `HK_EPS_BAT1_1_V`, `HK_EPS_BAT1_2_V`, `HK_EPS_BAT2_1_V`, `HK_EPS_BAT2_2_V`, `HK_EPS_BAT1_TP`, `HK_EPS_BAT2_TP`, `HK_EPS_PBUS_D_V`, `HK_EPS_PBUS_A_V`, `HK_EPS_EXT_TP`, `HK_EPS_FRAME_TP`, `HK_EPS_MC_TP`, `HK_EPS_PCB_TP`, `HK_EPS_MB_TP`, `HK_EPS_XN_CU`, `HK_EPS_XP_CU`, `HK_EPS_YN_CU`, `HK_EPS_YP_CU`, `HK_EPS_ZN_CU`, `HK_EPS_ZP_CU`, `HK_EPS_XN_TP`, `HK_EPS_XP_TP`, `HK_EPS_YN_TP`, `HK_EPS_YP_TP`, `HK_EPS_ZN_TP`, `HK_EPS_ZP_TP`, `HK_EPS_ED_PL`, `HK_EPS_ED_ADCS`, `HK_EPS_ST_ADS1_2`, `HK_EPS_ST_PL`, `HK_EPS_ST_ADCS`, `HK_EPS_ST_CDMS`, `HK_EPS_ST_BEAC`, `HK_EPS_ST_COM`, `HK_EPS_EF_PL`, `HK_EPS_EF_ADCS`, `HK_EPS_EF_CDMS`, `HK_EPS_EF_COM`, `HK_EPS_EF_EPS`, `HK_EPS_MODE`, `HK_EPS_ERROR_COD`, `HK_EPS_WD_T_OUT`.
However, you can change the list by modyfing the *$allowed-columns* XQuery variable

After importing the CSV file, run script located at `xquery/management/convert-to-db.xq`, which will convert the CSV file to the format expected by the scripts.
As this is demonstration purpose server, it will also create a second database with values randomly changed by 10%.

### Setting up the BaseX XML database and web application
Configure `WEBPATH` BaseX server variable to point to `xquery/webapp` directory. It is also advisable to create a database user
with limited permissions for use by the web server and grant this user read rights to *satdata* database. For details, see
[BaseX web application configuration](http://docs.basex.org/wiki/Web_Application).

You can additionally proxy the BaseX web application, e.g. using Apache mod_http_proxy.

## Querying data on the server

The scripts can be run using `/rest?run=script_name.xq` syntax with parameters following the script name and question mark
The following methods are available:

### Queries without parameters

#### get-satellite-names

Returns a list of satellite names available.

Example output:

    {
      "sateliteNames": [
        "Sat1",
        "Sat2"
      ]
    }

#### get-column-names

Returns list of possible parameters to query.

Example output:

    {
      "columnNames": [
        "HK_EPS_LR_COM",
        "HK_EPS_LR_ADCS",
        "HK_EPS_LR_CDMS",
        "HK_EPS_LR_PL",
        "HK_EPS_BAT1_1_V",
        "HK_EPS_BAT1_2_V",
        "HK_EPS_BAT2_1_V",
        "HK_EPS_BAT2_2_V",
        "HK_EPS_BAT1_TP",
        .....
      ]
    }

### Queries with parameters

#### get-column

Returns values for the particular parameter in specified period of time for particular cubesat, e.g.

    /rest?run=get-column.xq&satellite-name=Sat1&column=HK_EPS_MODE&time-from=2009-10-05T11:02:37.343&time-to=2009-10-07T12:42:38.473

would return

    {
      "measurement": {
        "time": "2009-10-07T12:42:38.473",
        "value": "1230618.625"
      },
      "measurement": {
        "time": "2009-10-07T12:42:26.797",
        "value": "1230606.9375"
      },
      "measurement": {
        "time": "2009-10-07T12:42:25.73",
        "value": "1230605.875"
      },
      ....
    }

#### get-matrix

`get-matrix` is similar to `get-column`, but it accepts multiple satellites and multiple
monitored parameters, separated by comma. Consequently, the return format takes into
account multiple parameters, e.g. such query

    /rest?run=get-matrix.xq&satellite-names=Sat1,Sat2&columns=HK_EPS_LR_COM,HK_EPS_LR_ADCS,HK_EPS_LR_CDMS&time-from=2009-10-05T11:02:37.343&time-to=2009-10-07T12:42:38.473

would return

    {
      "measurement": {
        "satellite": "Sat1",
        "column": "HK_EPS_LR_COM",
        "time": "2009-10-07T12:42:38.473",
        "value": "1230618.625"
      },
      "measurement": {
        "satellite": "Sat1",
        "column": "HK_EPS_LR_ADCS",
        "time": "2009-10-07T12:42:38.473",
        "value": "1230610.125"
      },
      "measurement": {
        "satellite": "Sat1",
        "column": "HK_EPS_LR_CDMS",
        "time": "2009-10-07T12:42:38.473",
        "value": "0"
      },
      ....
      "measurement": {
        "satellite": "Sat2",
        "column": "HK_EPS_LR_CDMS",
        "time": "2009-10-05T11:03:01.69",
        "value": "0"
      },
      "measurement": {
        "satellite": "Sat2",
        "column": "HK_EPS_LR_COM",
        "time": "2009-10-05T11:02:37.343",
        "value": "1019822.0462183164"
      },
      ...
    }

#### get-chart-data

The method was specifically designed for implementation of chart library used
in the mobile application. It accepts the same parameters as `get-matrix`, but
returns the data in different format, e.g.

    /rest?run=get-chart-data.xq&satellite-names=Sat1,Sat2&columns=HK_EPS_LR_COM,HK_EPS_LR_ADCS,HK_EPS_LR_CDMS&time-from=2009-10-05T11:02:37.343&time-to=2009-10-07T12:42:38.473

would return

    {
      "Sat1": {
        "time1254919358473": {
          "HK_EPS_LR_COM": "1230618.625",
          "HK_EPS_LR_ADCS": "1230610.125",
          "HK_EPS_LR_CDMS": "0",
          "HK_EPS_LR_COM": "1228306.4114367624",
          "HK_EPS_LR_ADCS": "1216305.3761977046",
          "HK_EPS_LR_CDMS": "0"
        },
        "time1254919346797": {
          "HK_EPS_LR_COM": "1230606.9375",
          "HK_EPS_LR_ADCS": "1230600.125",
          "HK_EPS_LR_CDMS": "0",
          "HK_EPS_LR_COM": "1189500.1991403142",
          "HK_EPS_LR_ADCS": "1202930.567779574",
          "HK_EPS_LR_CDMS": "0"
        },
        .....
      },
      "Sat2": {
        "time1254919358473": {
          "HK_EPS_LR_COM": "1230618.625",
          "HK_EPS_LR_ADCS": "1230610.125",
          "HK_EPS_LR_CDMS": "0",
          "HK_EPS_LR_COM": "1228306.4114367624",
          "HK_EPS_LR_ADCS": "1216305.3761977046",
          "HK_EPS_LR_CDMS": "0"
        },
        "time1254919346797": {
          "HK_EPS_LR_COM": "1230606.9375",
          "HK_EPS_LR_ADCS": "1230600.125",
          "HK_EPS_LR_CDMS": "0",
          "HK_EPS_LR_COM": "1189500.1991403142",
          "HK_EPS_LR_ADCS": "1202930.567779574",
          "HK_EPS_LR_CDMS": "0"
        },
        .....
      }
    }
