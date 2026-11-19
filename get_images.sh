#!/bin/bash

url="$1"

server=$(echo "$url" | cut -d '/' -f 1-3)

curl -sL "$url" | 
tr '<' '\n' |
grep '^img ' | sed -nE 's/.*src="([^"]+)".*/\1/p' |
while read -r LINE
do
    if echo "$LINE" | grep '^https:' > /dev/null
    then
        curl -s -O "$LINE"
    else 
        curl -s -O "$server$LINE"
    fi 
done

