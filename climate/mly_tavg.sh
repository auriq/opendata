#!/bin/bash
# cleans and reformats NOAA climate normals data, extracts desired values
# These data were obtained from National Centers for Environmental Information (NCEI) - Asheville NC 

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add mly_tavg "climate/NOAA/normals/1981-2010/products/temperature/mly-tavg-normal.txt" --noprobe --dateregex=none --overwrite 
echo "Data source: National Centers for Environmental Information (NCEI) - Asheville NC" > mly_tavg.csv
ess stream mly_tavg '*' '*' 'aq_pp -f,eok,qui - -d s:stnid sep:"         " s:Jan sep:"   " s:Feb sep:"   " s:Mar sep:"   " s:Apr sep:"   " s:May sep:"   " s:Jun sep:"   " s:Jul sep:"   " s:Aug sep:"   " s:Sep sep:"   " s:Oct sep:"   " s:Nov sep:"   " s:Dec -filt "stnid==\"USC00049152\" || stnid==\"USC00047767\" || stnid==\"USW00024233\"" -eval s:station \"temp\" -map Jan "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Feb "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Mar "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Apr "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map May "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Jun "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Jul "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Aug "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Sep "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Oct "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Nov "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%" -map Dec "%%var%%%%var2:0-1%%%?" "%%var%%.%%var2%%"  -if -filt "stnid==\"USC00049152\"" -eval station "\"Los Angeles\"" -elif -filt "stnid==\"USC00047767\"" -eval station "\"San Francisco\"" -else -eval station "\"Seattle\"" -endif' >> mly_tavg.csv
