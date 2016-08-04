#!/bin/sh

# using fifo to ship essentia category,

##create a category
# ess select s3://asi-opendata --aws_access_key "AKIAJJ2NEBGDF7I7FVZA" --aws_secret_access_key "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"
ess select asi-opendata
ess category add ssa "SSA/SSA_Disability_Claim_Data.csv" --delimiter=',' --overwrite

#create a fifo to stream category
rm -rf /tmp/esspipe
mkfifo /tmp/esspipe
ess stream ssa '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s,trm@5:state i@7:year i@8:pop1864 f@10:pct' > /tmp/esspipe &

echo "
input {
    #read standard input
   stdin {
        type => 'seslog' #used for filter activation
    }
}
filter {  # grok filter plugin looks for patterns in the incoming log data, require user to identify patterns of interest
      csv {
          columns => ["State", "Year", "Population_1864", "Percent"]
          separator => ','
         # convert => {"Year" => "integer"}
         # convert => {"Population_1864" => "integer"}
      }
      mutate {
        convert => {"Percent" => "float"}
        convert => {"Population_1864" => "integer"}
      }
}
output {
    elasticsearch {
         index => 'ssa'
        }  #indexing to elasticsearch
}
" > conf/fifo_stdin_category.conf

#start streaming
##logstash take standard input and exports to mysql server on local host
cat /tmp/esspipe | logstash -f conf/fifo_stdin_category.conf
