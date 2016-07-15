#!/bin/sh
# processes US Transportation aviation data (airline on-time performance)
# Southwest Airline's airline ID is 19393

ess server reset
ess create database airline --ports=1
ess create vector vector1 s,pkey:year i,+add:numflights f,+add:totaldelay f:avgdelay f,+add:numdelay15
ess server commit

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add airlineontime 'USTransportation/aviation/airline_ontime/old/*.zip' --archive='*.csv' --dateregex='[:%Y:]' --overwrite
ess summary airlineontime
ess stream airlineontime --threads 3 --progress '*' '*' "aq_pp -f,+1,eok,csv - -d i:yearint i@3:month i@4:dayofmonth s@6:date s@7:carrier i@8:airlineid f@26:delay f@28:delay15 -filt \"airlineid==19393\" -eval s:year \"ToS(yearint)\" -eval i:numflights \"1\" -eval f:totaldelay \"delay\" -eval f:avgdelay \"totaldelay/numflights\" -eval f:numdelay15 \"delay15\" -udb_imp airline:vector1" 
aq_udb -exp airline:vector1 > wn.csv
