#!/bin/bash
# organizes NASA SSE radiation data
# These data were obtained from the NASA Langley Research Center Atmospheric Science Data Center Surface meteorological and Solar Energy (SSE) web portal supported by the NASA LaRC POWER Project.

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add radiation "climate/NASA_SSE/NASA_SSE_RADIATION_1983-2005/22yr_clr_sky.gz" --overwrite --noprobe --archive='*.csv'
echo "These data were obtained from the NASA Langley Research Center Atmospheric Science Data Center Surface meteorological and Solar Energy (SSE) web portal supported by the NASA LaRC POWER Project." > radiation.csv
ess stream radiation '*' '*' 'aq_pp -f,+14,eok,qui - -d s:latitude sep:" " s:longitude sep:" " f:January sep:" " f:February sep:" " f:March sep:" " f:April sep:" " f:May sep:" " f:June sep:" " f:July sep:" " f:August sep:" " f:September sep:" " f:October sep:" " f:November sep:" " f:December sep:" " f:annual' >> radiation.csv
