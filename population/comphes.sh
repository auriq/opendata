#!/bin/sh
# processes US Labor statistics data

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add comphes 'LaborStats/suppl/EMPSIT.COMPHES.TXT' --overwrite --dateregex=none
ess summary comphes
ess cat 'LaborStats/suppl/EMPSIT.COMPHES.TXT' | head -7
ess stream comphes '*' '*' 'aq_pp -f,+7,eok,qui - -d x: sep:"     " i,trm:year sep:"   " s,trm:jan sep:"       " s:feb sep:"       " s:march sep:"       " s:april sep:"       " s:may sep:"       " s:june sep:"       " s:july sep:"       " s:august sep:"       " s:sep sep:"       " s:oct sep:"       " s:nov sep:"       " s:dec'
ess stream comphes '*' '*' > comphes.csv
