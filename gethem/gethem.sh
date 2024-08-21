#!/bin/bash

if [ ! -f list.txt ]; then
    echo "I need to my list.txt file beside me."
    exit 1
fi

while IFS= read -r url; do
    if [ -z "$url" ]; then
        continue
    fi

    wget "$url"

    if [ $? -ne 0 ]; then
        echo "Failed to download $url"
    else
        echo "Successfully downloaded $url"
    fi
done < list.txt
