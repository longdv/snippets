#! /bin/bash

# go to https://api.slack.com/custom-integrations/legacy-tokens to generate your token

my_token=$1
user_id="AAA"

file1=/tmp/files.json
file2=/tmp/ids.txt
min_size=100

while true; do
    curl "https://slack.com/api/files.list?token=$my_token&user=$user_id" > $file1
    actual_size=$(wc -c <"$file1")
    if [ $actual_size -lt $min_size ]; then
        exit
    fi

    cat $file1 | grep '"id":"[A-Z0-9]+"' -oP | sed 's/"id"://g' | sed 's/"//g' > $file2
    cat $file2 |while read id; do curl "https://slack.com/api/files.delete?token=$my_token&file=$id";done
done
