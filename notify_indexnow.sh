#!/bin/sh

SITEMAP_URL="http://angliport.com/sitemap.xml"
HOST="angliport.com"
KEY="fb2ec9f5dffe4263a6bfaa78452ea99c"
KEY_LOCATION="http://angliport.com/fb2ec9f5dffe4263a6bfaa78452ea99c.txt"
INDEXNOW_ENDPOINT="https://api.indexnow.org/IndexNow"

 # Extract URLs from sitemap.xml
# URLS=$(curl -s "$SITEMAP_URL" | sed -n 's:.*<loc>\(.*\)</loc>.*:\1:p' | awk '{print "\"" $0 "\""}' | paste -sd "," -)
URLS="http://angliport.com"

ECHO "Extracted URLs: $URLS"
# Build JSON payload
JSON_PAYLOAD="{\"host\":\"$HOST\",\"key\":\"$KEY\",\"keyLocation\":\"$KEY_LOCATION\",\"urlList\":[ \"$URLS\" ]}"

ECHO "Extracted Payload: $JSON_PAYLOAD"
# Send POST request
curl -X POST "$INDEXNOW_ENDPOINT" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d "$JSON_PAYLOAD"



ECHO "Done"