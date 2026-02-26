#!/bin/sh

SITEMAP_URL="https://angliport.com/sitemap.xml"
HOST="angliport.com"
KEY="f25f2ae156e844228b12042703fb53ed"
KEY_LOCATION="https://angliport.com/f25f2ae156e844228b12042703fb53ed.txt"
INDEXNOW_ENDPOINT="https://api.indexnow.org/IndexNow"

 # Extract URLs from sitemap.xml
# URLS=$(curl -s "$SITEMAP_URL" | sed -n 's:.*<loc>\(.*\)</loc>.*:\1:p' | awk '{print "\"" $0 "\""}' | paste -sd "," -)
URLS=$(
  curl -s "$SITEMAP_URL" \
    | sed -n 's:.*<[^>]*loc>\(.*\)</[^>]*loc>.*:\1:p' \
    | grep '^https://angliport.com' \
    | awk '{print "\"" $0 "\""}' \
    | paste -sd "," -
)

ECHO "Extracted URLs: $URLS"
# Build JSON payload
JSON_PAYLOAD="{\"host\":\"$HOST\",\"key\":\"$KEY\",\"keyLocation\":\"$KEY_LOCATION\",\"urlList\":[ $URLS ]}"

# Send POST request
curl -X POST "$INDEXNOW_ENDPOINT" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d "$JSON_PAYLOAD"
