#!/bin/bash
# extracts desired fields from SSA disability claim data

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add ssa "SSA/SSA_Disability_Claim_Data.csv" --delimiter=',' --overwrite
ess stream ssa '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s,trm@5:state i@7:year i@8:pop1864 f@10:pct' > ssa.csv
