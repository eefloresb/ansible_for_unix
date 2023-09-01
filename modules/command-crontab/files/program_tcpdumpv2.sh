###################### README ################################
#Autor: eflores@canvia.com
#Versión: 1.0
#Licencia: gplv3
# area: SSAA/Unix
#############################################################
#!/bin/bash
######################## crontab ############################
#0 */1 * * * /scripts/./tcpdump_rotate.sh execute
#*/5 * * * * /scripts/./tcpdump_rotate.sh move
#59 */1 * * * /scripts/./tcpdump_rotate.sh kill
########################         ############################
export PATH=$PATH:/usr/sbin/
NAME=TCPDump
DATE=$(date +%d%m%y)
HOUR=$(date +%H%M)
#ETH={{ansible_default_ipv4.interface}}
#ETH=$(ip addr show | grep -Ewo '(eth[[:digit:]]+|ens[[:digit:]]+)' | uniq | head -n1)
ETH=$(ip addr show | grep -Ewo '(eth[[:digit:]]+|ens[[:digit:]]+)\:.*UP.*' | head -n1 | cut -d ":" -f1)
ROUTE_SRC="/home/cnvusers/DATA"
TCDUMP_STORE=300
TCDUMP_STORE_ROLLOVER=20
RANDOMNAME=$(date +%s | md5sum | awk '{ print $1 }' | tr '0123456789' '0lzeAsgtBa' | cut -c 1-6)
ROUTE_DST_LOCAL=/home/cnvusers/DATA/$RANDOMNAME$DATE
KPROCCESS=$(ps axo pid,comm |grep -i tcpdump | grep -v grep | awk '{print $1}')
BAND=
TCPDUMP=$(which tcpdump)
IP=$(ip addr show | grep -E "inet[[:blank:]]+" | awk -F "[V ]+" '{print $3}' |grep -v 127.0.0.1 | head -n1 | cut -d "/" -f 1)
HOSTNAME=$(hostname)
HOSTREMOTE="10.100.13.61"
USEREMOTE="gmdadmin"

if [[ -z $TCPDUMP ]]; then
  echo "Install TCdump program to run this script"
  exit
fi

if [[ ! -d "$ROUTE_SRC" ]]; then
  mkdir -p ${ROUTE_SRC}
fi

function _make_dir(){
  if [[ -d $ROUTE_DST_LOCAL ]]; then
    	mkdir -p ${ROUTE_DST_LOCAL}
  fi
}

function _execute_tcpdump(){
   echo "$ROUTE_DST_LOCAL" > /tmp/ruta_destino.txt
  $TCPDUMP -G 3600 -s 0 -i $ETH -C ${TCDUMP_STORE} -W ${TCDUMP_STORE_ROLLOVER} -w ${ROUTE_SRC}/${HOSTNAME}_${IP}_${NAME}_${DATE}_${HOUR}.pcap
}

function _move_tcdump_local(){
  cd ${ROUTE_SRC}
  ROUTE_DST_LOCAL=$(cat /tmp/ruta_destino.txt)
  if [[ -z $BAND ]]; then
      count=$(ls|wc -l)
      for i in `find . -type f -name "*.pcap*"`; do
        xultimo=$(ls -lt *.pcap*|head -n 1 | awk '{print $9}')
        if [[ ${i} != "./${xultimo}" && $count != "1" ]]; then
          mv -v $i ${ROUTE_DST_LOCAL}/.
        fi
      done
  else
    ls | while read line; do mv -v $line ${ROUTE_DST_LOCAL}/.; done
  fi
}

function _compress_dest(){
  ROUTE_DST_LOCAL=$(cat /tmp/ruta_destino.txt)
  cd ${ROUTE_DST_LOCAL}
  for i in `find . -type f -name "*.pcap*"`; do
      gzip $i > $i.gz
  done
}

function _kill_process(){
  for i in $KPROCCESS; do
    kill -s 9 $i
  done
}

_sftp_upload(){
ROUTE_DST_LOCAL=$(cat /tmp/ruta_destino.txt)
ROUTE_DST_REMOTE=${ROUTE_DST_LOCAL##/*/}
sftp -i /home/gmdadmin/.ssh/id_rsa -v ${USEREMOTE}@${HOSTREMOTE} << EOF
lcd ${ROUTE_SRC}
cd /data
mkdir ${ROUTE_DST_REMOTE}
cd ${ROUTE_DST_REMOTE}
put $1
!rm $1
quit
EOF
}

_upload_file(){
cd ${ROUTE_SRC}
if [[ -z $BAND ]]; then
	count=$(ls|wc -l)
	for i in `find . -type f -name "*.pcap*"`; do
	xultimo=$(ls -lt *.pcap*|head -n 1 | awk '{print $9}')
		if [[ ${i} != "./${xultimo}" && $count != "1" ]]; then
      	chown ${USEREMOTE}: $i
			_sftp_upload $i
		fi
	done
else
	ls | while read line; do chown ${USEREMOTE}: $line; _sftp_upload $line; done
fi
}

case $1 in
  execute)
        _execute_tcpdump
        ;;
  kill_remote)
        BAND=true
        _kill_process
        _upload_file
        ;;
  upload)
        _upload_file
        ;;
  move)
    _move_tcdump_local
    ;;
  kill_local)
      BAND=true 
      _kill_process
      _move_tcdump_local
esac
