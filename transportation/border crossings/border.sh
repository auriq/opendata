#!/bin/sh
# processes US Transportation border crossing data, counts people by year, border, state

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add bordercrossing 'USTransportation/common/"Border Crossing Data"/417923300_T_BDRCROSS_COMBINED_FINAL*.zip' --dateregex=Y --preprocess='aq_pp -f,+1,csv,eok,qui - -d x: f:people x: x: x: x: x: x: x: x: x: x: x: x: x: x: s:border s:state x: x: x: i:year i:month -filt "people>0.0"' --overwrite
ess summary bordercrossing
ess query 'select count(people) from bordercrossing:*:* group by year' > borderyear.csv
ess query 'select count(people) from bordercrossing:*:* group by border' > borderac.csv
ess query 'select count(people) from bordercrossing:*:* group by state' > borderstate.csv
ess query 'select people,state from bordercrossing:*:* where year==1995' > border1995.csv
ess query 'select people,state from bordercrossing:*:* where year==2007' > border2007.csv
