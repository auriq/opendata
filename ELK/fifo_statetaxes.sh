#!/bin/sh

# using fifo to ship essentia category,

##create a category
ess select asi-opendata
ess category add state_taxes "USCensus/US_Census_Bureau_State_Tax_Collections/STC_2014_STC006.US01.zip" --noprobe --dateregex='[:%Y:]' --overwrite

#create a fifo to stream category
rm -rf /tmp/esspipe
mkfifo /tmp/esspipe
ess stream state_taxes '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s@7:state i@8:total i@9:property i@10:sales i@11:license i@12:income i@13:other -notitle' > /tmp/esspipe &

echo "
input {
    #read standard input
   stdin {
        type => 'seslog' #used for filter activation
    }
}
filter {  # grok filter plugin looks for patterns in the incoming log data, require user to identify patterns of interest
      csv {
          columns => ["State", "Total", "Property", "Sales", "License", "Income", "Other"]
          separator => ','
          convert => {"Total" => "integer"}
          convert => {"Property" => "integer"}
          convert => {"Sales" => "integer"}
          convert => {"License" => "integer"}
          convert => {"Income" => "integer"}
          convert => {"Other" => "integer"}
      }
}
output {
    elasticsearch {
         index => 'statetaxes'
        }  #indexing to elasticsearch
}
" > conf/fifo_stdin_category.conf

#start streaming
##logstash take standard input and exports to mysql server on local host
cat /tmp/esspipe | logstash -f conf/fifo_stdin_category.conf
