#!/bin/bash
now="$(date)"
printf "Current date and time %s\n" "$now"
 
now="$(date +'%d/%m/%Y')"
printf "Current date in dd/mm/yyyy format %s\n" "$now"
 
echo "Starting backup at $now, please wait..."

#mkdir twitters-$(date '+%d%m%Y%H%M%S')

curl --get 'https://stream.twitter.com/1.1/statuses/filter.json' --data 'track=dilma' --header 'Authorization: OAuth oauth_consumer_key="", oauth_nonce="", oauth_signature="", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1452098876", oauth_token="", oauth_version="1.0"' --verbose > twitters-$(date '+%d%m%Y%H%M%S').js
