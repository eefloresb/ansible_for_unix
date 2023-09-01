#!/bin/bash
##### Support to Ubuntu 18.04 20.04 22.04
##### Support to Debian 9 10 11
HOSTNAME=$(hostname -f)
IPADDRESS=`ip addr show |grep -E inet[[:blank:]]+.*|grep -v 127.0.0.1 | awk -F "[V ]+" '{print $3}' | head -1 | awk -F "/" '{print $1}'`
echo hostname,ipaddress,package name,current version,update version
apt list --upgradable 2>&1|sed -re "/(WARNING|Listing|Listando|^$)/d" | while read line;do
NAME=$(echo $line | awk -F "/" '{print $1}')
REPOSITORIO=$(echo $line | awk -F "/" '{print $2}'|awk -F " " '{print $1}'|awk -F "," '{print $1}')
UVERSION=$(echo $line|awk -F "[" '{print $2}'|awk -F ": " '{print $2}'|tr -d "]")
VERSION=$(echo $line|grep -oP '(?<= )[0-9:.a-z-]*(?= amd64)')
echo "$HOSTNAME,$IPADDRESS,$NAME,$VERSION,$UVERSION,$REPOSITORIO"
done
