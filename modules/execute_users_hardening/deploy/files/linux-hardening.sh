#/bin/sh
#1.0 - 2018/03/06 - Marcos Rodrigues - <mrodrigues@foregenix.com> 

redhat=0
debian=0

outputfile=`hostname`.txt
date=`date +%Y%m%d-%H:%M`

echo "---Hostname---" >> $outputfile
hostname >> $outputfile
echo >> $outputfile

echo "---System---" >> $outputfile
uname -a >> $outputfile
echo >> $outputfile

echo "---LSB Release---" >> $outputfile
lsb_release -a >> $outputfile
echo >> $outputfile

echo "---Date---" >> $outputfile
echo $date >> $outputfile
echo >> $outputfile

echo "---Version---" >> $outputfile
if [ -f /etc/redhat-release ];then
	cat /etc/redhat-release >> $outputfile
	redhat=1
fi

if [ -f /etc/debian_version ];then
	echo Debian >> $outputfile
	cat /etc/debian_version >> $outputfile
	debian=1
fi

if [ $redhat -ne 1 ] && [ $debian -ne 1 ];then
	echo "Could not identify system version" >>$outputfile
fi
echo >> $outputfile

echo "---Network interfaces---" >> $outputfile
ifconfig -a >> $outputfile
echo >> $outputfile

echo "---Network route---" >> $outputfile
netstat -nr >> $outputfile
echo >> $outputfile

echo "---Arp Table---" >> $outputfile
arp -an >> $outputfile
echo >> $outputfile

echo "---IP Forwarding---" >> $outputfile
sysctl net.ipv4.ip_forward >> $outputfile
echo >> $outputfile

echo "---TCP Transmission---" >> $outputfile
netstat -pnt  >> $outputfile
echo >> $outputfile

echo "---UDP Transmission---" >> $outputfile
netstat -pnu >> $outputfile
echo >> $outputfile

echo "---TCP Listen ports---" >> $outputfile
netstat -lnp --tcp >> $outputfile
echo >> $outputfile

echo "---UDP Listen ports---" >> $outputfile
netstat -lnp --udp >> $outputfile
echo >> $outputfile

echo "---IPTables Ruleset---" >> $outputfile
iptables-save >> $outputfile
echo >> $outputfile

echo "---Partioning---">> $outputfile
mount >> $outputfile
echo >> $outputfile

echo "---SSHD_Config---" >> $outputfile
ssh_ver=`ssh -V 2>&1 | cut -c9`
if [ $ssh_ver -ge 5 ]; then
	sshd -T >> $outputfile
else
        echo "SSHD version < 5" >> $outputfile && cat /etc/ssh/sshd_config >> $outputfile
fi
echo >> $outputfile

echo "---Sudoers config---" >> $outputfile
cat  /etc/sudoers >> $outputfile
echo >> $outputfile

echo "---loging.defs---" >> $outputfile
grep '^[^#]' /etc/login.defs >> $outputfile
echo >> $outputfile

echo "---shadow---" >> $outputfile
more /etc/shadow >> $outputfile
echo >> $outputfile

echo "---lastlog---" >> $outputfile
lastlog >> $outputfile
echo >> $outputfile

echo "---nsswitch.conf---" >> $outputfile
cat /etc/nsswitch.conf >> $outputfile
echo >> $outputfile

#This will ignore all usernames without a valid shell. e.g /sbin/nologin /bin/false and the sys user, as it breaks the script for now. 
echo "---Last Password Changes---" >> $outputfile
for user in $(grep -v "nologin\|false\|sys" /etc/passwd | cut -d: -f1)
do
	echo -n "$user: " >> $outputfile
	chage -l  $user >> $outputfile
	echo >> $outputfile
done
echo >> $outputfile

echo "---Log server---" >> $outputfile
if [ -e /etc/rsyslog.conf ]; then
	cat /etc/rsyslog.conf >> $outputfile
	for i in `ls -r1 /etc/rsyslog.d`; do
		cat  /etc/rsyslog.d/$i >> $outputfile
     	done
else
	if [ -f /etc/syslog.conf ];then
		cat /etc/syslog.conf >> $outputfile
	fi
fi	
echo >> $outputfile

if [ -f /etc/ntp.conf ];then
	echo "---ntp.conf---" >> $outputfile
	cat  /etc/ntp.conf  >> $outputfile
	echo >> $outputfile
fi


echo "---ps auxw---" >> $outputfile
ps auxw >> $outputfile
echo >> $outputfile

echo "---Systemctl---" >> $outputfile
systemctl --no-pager >> $outputfile
echo >> $outputfile

echo "---DNS Servers---" >> $outputfile
cat /etc/resolv.conf >> $outputfile
echo >> $outputfile

redhat(){
	echo "---Yum packages---" >> $outputfile
	yum check-update >> $outputfile
	echo >> $outputfile

	echo "---RPM Packages---" >> $outputfile
	rpm -qa --last >> $outputfile
	echo >> $outputfile

	echo "---PAM Config---" >> $outputfile
	cat /etc/pam.d/system-auth >> $outputfile
	echo >> $outputfile
}


debian(){
	echo "---apt-updates---" >> $outputfile
	apt-get -s upgrade >> $outputfile
	echo >> $outputfile

	echo "---DPKG Packages---" >> $outputfile
	dpkg -l >> $outputfile
	echo >> $outputfile

	echo "---PAM Config---" >> $outputfile
	cat /etc/pam.d/common* >> $outputfile
	echo >> $outputfile

	echo "---DPKG Upates---" >> $outputfile
	echo "-dpkg.log-" >> $outputfile
	cat /var/log/dpkg.log >> $outputfile
	echo "-dpkg.log.1-" >> $outputfile
	cat /var/log/dpkg.log.1 >> $outputfile
	echo >> $outputfile
}

if [ $redhat -eq 1 ];then
	redhat
fi

if [ $debian -eq 1 ];then
	debian
fi	
