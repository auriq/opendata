#!/bin/bash
# organizes tvs (tornadic vortex signature overlay) data
# extracts time, longitude, latitude, shear data
# NOAA Severe Weather data source: National Centers for Environmental Information (NCEI) - Asheville NC"

ess cluster set local
ess select s3://asi-opendata --aws_access_key AKIAJJ2NEBGDF7I7FVZA --aws_secret_access_key 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
ess category add tvs "climate/NOAA/NOAA_SevereWeather/*tvs*" --dateregex='[:%Y:]' --overwrite --delimiter=',' --archive='*.csv'
echo "Data source: National Centers for Environmental Information (NCEI) - Asheville NC" > tvs.csv
ess stream tvs '*' '*' "aq_pp -f,+3,eok,qui,csv - -d i:time f:lon f:lat i@16:shear" >> tvs.csv 
