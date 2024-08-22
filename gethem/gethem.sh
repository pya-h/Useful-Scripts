#!/bin/bash

if [ ! -f list.txt ]; then
    echo "i need to my list.txt file beside me."
    exit 1
fi

while IFS= read -r url; do
    if [ -z "$url" ]; then
        continue
    fi

    wget "$url"

    filename=$(basename "$url")

    if [ $? -ne 0 ]; then
        echo "x failed to download: $filename"
    else
        echo "* $filename downloaded."
    fi
    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
done < list.txt

