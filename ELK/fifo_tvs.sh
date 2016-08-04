#!/bin/sh

# using fifo to ship essentia category,

##create a category
# ess select s3://asi-opendata --aws_access_key "AKIAJJ2NEBGDF7I7FVZA" --aws_secret_access_key "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"
ess select asi-opendata
ess category add tvs "climate/NOAA/NOAA_SevereWeather/*tvs*" --overwrite --delimiter=',' --archive='*.csv'
# Data source: National Centers for Environmental Information (NCEI) - Asheville NC

# create a fifo to stream category
rm -rf /tmp/esspipe
mkfifo /tmp/esspipe
ess stream tvs '*' '*' "aq_pp -f,+3,eok,qui,csv - -d i:time f:lon f:lat i@16:shear" > /tmp/esspipe &

echo "
input {
    #read standard input
   stdin {
        type => 'seslog' #used for filter activation
    }
}
filter {  # grok filter plugin looks for patterns in the incoming log data, require user to identify patterns of interest
      csv {
          columns => ["Time", "Longitude", "Latitude", "Shear"]
          separator => ','
      }
      mutate {
          convert => {"Longitude" => "float"}
          convert => {"Latitude" => "float"}
          convert => {"Shear" => "integer"}
      }
     mutate {
          rename => {
              "Longitude" => \"[location][lon]\"
              "Latitude" => \"[location][lat]\"
          }
      }
     mutate {
          convert => { \"location\" => "float"}
     }
}
output {
    elasticsearch {
         index => 'tvs_01'
         template => 'tvs_temp.json'
         template_name => 'tvs'
         template_overwrite => true
        }  #indexing to elasticsearch
}
" > conf/fifo_stdin_category.conf

#start streaming
##logstash take standard input and exports to mysql server on local host
cat /tmp/esspipe | logstash -f conf/fifo_stdin_category.conf
