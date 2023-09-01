#!/bin/bash
find /etc/* -type f -exec ls -ld {} \; \
| awk 'BEGIN {print("user,group,sizeB,sizeK,sizeM,sizeG,route");} {tot=tot+$5;} \
-F "[V ]+" {print $3","$4","$5","$5/1024","$5/1024/1024","$5/1024/1024/1024","$9} END {print "Total=",tot/1024/1024/1024;}'

