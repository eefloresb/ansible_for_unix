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
NAME=TCPDump
DATE=$(date +%d%m%y)
HOUR=$(date +%H%M)
#ETH={{ansible_default_ipv4.interface}}
ETH=$(ip addr show | grep -Ewo '(eth[[:digit:]]+|ens[[:digit:]]+)' | uniq | head -n1)
ROUTE_SRC="/home/cnvusers/DATA"
TCDUMP_STORE=300
TCDUMP_STORE_ROLLOVER=20
RANDOMNAME=$(date +%s | md5sum | awk '{ print $1 }' | tr '0123456789' '0lzeAsgtBa' | cut -c 1-6)
ROUTE_DST="/hana/log/archive_tcpdumps/"
KPROCCESS=$(ps axo pid,comm |grep -i tcpdump | grep -v grep | awk '{print $1}')
BAND=
TCPDUMP=$(which tcpdump)
IP=$(ip addr show | grep -E "inet[[:blank:]]+" | awk -F "[V ]+" '{print $3}' |grep -v 127.0.0.1 | head -n1 | cut -d "/" -f 1)
HOSTNAME=$(hostname)
HOSTREMOTE="10.100.13.61"
USEREMOTE="cnvusers"

if [[ -z $TCPDUMP ]]; then
  echo "Install TCdump program to run this script"
  exit
fi

if [[ ! -d "$ROUTE_SRC" ]]; then
  mkdir -p ${ROUTE_SRC}
fi

function _make_dir(){
	mkdir -p ${ROUTE_DST}
}

function _execute_tcpdump(){
  _make_dir
  echo "$ROUTE_DST" > /tmp/ruta_destino.txt
  $TCPDUMP -G 3600 -s 0 -i $ETH -C ${TCDUMP_STORE} -W ${TCDUMP_STORE_ROLLOVER} -w ${ROUTE_SRC}/${HOSTNAME}_${IP}_${NAME}_${DATE}_${HOUR}.pcap
}

function _move_tcdump(){
  cd ${ROUTE_SRC}
  ROUTE_DST=$(cat /tmp/ruta_destino.txt)
  if [[ -z $BAND ]]; then
      count=$(ls|wc -l)
      for i in `find . -type f -name "*.pcap*"`; do
        xultimo=$(ls -lt *.pcap*|head -n 1 | awk '{print $9}')
        if [[ ${i} != "./${xultimo}" && $count != "1" ]]; then
          mv -v $i ${ROUTE_DST}/.
        fi
      done
  else
    ls | while read line; do mv -v $line ${ROUTE_DST}/.; done
  fi
}

function _compress_dest(){
  ROUTE_DST=$(cat /tmp/ruta_destino.txt)
  cd ${ROUTE_DST}
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
sftp -v ${USEREMOTE}@${HOSTREMOTE} << EOF
lcd ${ROUTE_SRC}
cd ${ROUTE_DST}
put $1
quit
EOF
}

_upload_file {
if [[ -z $BAND ]]; then
cd ${ROUTE_SRC}
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
  kill)
        BAND=true
        _kill_process
        #_compress_dest
        #_move_tcdump
        _upload_file
        ;;
  move)
        _upload_file
        #_move_tcdump
        ;;
esac
