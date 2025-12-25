#!/bin/bash
echo Wiping: $2     Root Address: $1 
find $1  -type d -name $2  -prune -print  -exec rm -rf {} +
