#!/bin/bash
# extracts desired fields from SEC spread data, filters for Intel ticker

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[secret key]] --aws_secret_access_key [[secret access key]]
ess category add sec "SEC/SEC_Metrics/spreads_and_depth/spreads_by_individual_security_2013.zip" --delimiter=',' --archive='*.csv' --dateregex='[:%Y:][:%m:][:%d:]' --overwrite
ess stream sec '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s@1:ticker i@2:tradevol -filt "ticker==\"INTC\""' > intc.csv
