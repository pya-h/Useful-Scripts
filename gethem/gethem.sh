#!/bin/bash

if [ "$#" -gt 0 ]; then
    if [ "$1" == "clear" ]; then
        > list.txt
        echo "list.txt has been cleared."
        exit 0
    else
        for arg in "$@"; do
            echo "$arg" >> list.txt
            echo "$arg added to list.txt"
        done
        exit 0
    fi
fi

if [ ! -f list.txt ]; then
    echo "i need my list.txt file beside me."
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
        sed -i "\|$url|d" list.txt
    fi
    echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
done < list.txt