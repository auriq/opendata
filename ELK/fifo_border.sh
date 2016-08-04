#!/bin/sh

# using fifo to ship essentia category,

##create a category
# ess select s3://asi-opendata --aws_access_key "AKIAJJ2NEBGDF7I7FVZA" --aws_secret_access_key "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"
ess select asi-opendata
ess category add bordercrossing 'USTransportation/common/"Border Crossing Data"/417923300_T_BDRCROSS_COMBINED_FINAL*.zip' --preprocess='aq_pp -f,+1,csv,eok,qui - -d x: f:people x: x: x: x: x: x: x: x: x: x: x: x: x: x: s:border s:state x: x: x: i:year i:month -filt "people>0.0" -filt "border==\"M\""' --overwrite

# create a fifo to stream category
rm -rf /tmp/esspipe
mkfifo /tmp/esspipe
ess query 'select count(people) from bordercrossing:*:* group by year' > /tmp/esspipe &

echo "
input {
    #read standard input
   stdin {
        type => 'seslog' #used for filter activation
    }
}
filter {  # grok filter plugin looks for patterns in the incoming log data, require user to identify patterns of interest
      csv {
          columns => ["Year", "Count"]
          separator => ','
      }
      mutate {
          convert => {"Count" => "integer"}
      }
}
output {
    elasticsearch {
         index => 'border'
        }  #indexing to elasticsearch
}
" > conf/fifo_stdin_category.conf

#start streaming
##logstash take standard input and exports to mysql server on local host
cat /tmp/esspipe | logstash -f conf/fifo_stdin_category.conf
