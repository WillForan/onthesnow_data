#!/usr/bin/env bash
# downlload on the snow data and print in tsv
while read url; do
 place=$(echo $url| cut -d/ -f 5 | sed 's/-.*//')
 curl -s $url | tee html/$place.html| ./parse.pl  | sed "s/^/$place\t/"
done < txt/onthesnow.lst | tee txt/onthesnowinfo.tsv
