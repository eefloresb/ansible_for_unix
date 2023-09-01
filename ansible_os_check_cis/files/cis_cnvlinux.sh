#!/bin/bash
declare -a numero
declare -a comando
declare -a resultado

nombreServer=$HOSTNAME;
fechaejecucion=$(date '+%Y%m%d%H%M%S')

numero[0]="1.1.1.1 Ensure mounting of cramfs filesystems is disabled"
ejecutar0=$(modprobe -n -v cramfs;echo "<br>"; lsmod | grep cramfs)
resultado[0]=$ejecutar0

numero[1]="1.1.1.2 Ensure mounting of freevxfs filesystems is disabled"
ejecutar1=$(modprobe -n -v freevxfs;echo "<br>"; lsmod | grep freevxfs)
resultado[1]=$ejecutar1

numero[2]="1.1.1.3 Ensure mounting of jffs2 filesystems is disabled"
ejecutar2=$(modprobe -n -v jffs2;echo "<br>"; lsmod | grep jffs2)
resultado[2]=$ejecutar2

numero[3]="1.1.1.4 Ensure mounting of hfs filesystems is disabled"
ejecutar3=$(modprobe -n -v hfs;echo "<br>"; lsmod | grep hfs)
resultado[3]=$ejecutar3

numero[4]="1.1.1.5 Ensure mounting of hfsplus filesystems is disabled"
ejecutar4=$(modprobe -n -v hfsplus;echo "<br>"; lsmod | grep hfsplus)
resultado[4]=$ejecutar4

numero[5]="1.1.1.6 Ensure mounting of squashfs filesystems is disabled"
ejecutar5=$(modprobe -n -v squashfs;echo "<br>"; lsmod | grep squashfs)
resultado[5]=$ejecutar5

numero[6]="1.1.1.7 Ensure mounting of udf filesystems is disabled"
ejecutar6=$(modprobe -n -v udf;echo "<br>"; lsmod | grep udf)
resultado[6]=$ejecutar6

numero[7]="1.1.1.8 Ensure mounting of FAT filesystems is disabled"
ejecutar7=$(modprobe -n -v vfat;echo "<br>"; lsmod | grep vfat)
resultado[7]=$ejecutar7

numero[8]="1.1.2 Ensure separate partition exists for /tmp"
ejecutar8=$(mount | grep /tmp)
resultado[8]=$ejecutar8

numero[9]="1.1.3 Ensure nodev option set on /tmp partition"
ejecutar9=$(mount | grep /tmp)
resultado[9]=$ejecutar9

numero[10]="1.1.4 Ensure nosuid option set on /tmp partition"
ejecutar10=$(mount | grep /tmp)
resultado[10]=$ejecutar10

numero[11]="1.1.5 Ensure noexec option set on /tmp partition"
ejecutar11=$(mount | grep /tmp)
resultado[11]=$ejecutar11

numero[12]="1.1.6 Ensure separate partition exists for /var"
ejecutar12=$(mount | grep /var)
resultado[12]=$ejecutar12

numero[13]="1.1.7 Ensure separate partition exists for /var/tmp"
ejecutar13=$(mount | grep /var/tmp)
resultado[13]=$ejecutar13

numero[14]="1.1.8 Ensure nodev option set on /var/tmp partition"
ejecutar14=$(mount | grep /var/tmp)
resultado[14]=$ejecutar14

numero[15]="1.1.9 Ensure nosuid option set on /var/tmp partition"
ejecutar15=$(mount | grep /var/tmp)
resultado[15]=$ejecutar15

numero[16]="1.1.10 Ensure noexec option set on /var/tmp partition"
ejecutar16=$(mount | grep /var/tmp)
resultado[16]=$ejecutar16

numero[17]="1.1.11 Ensure separate partition exists for /var/log"
ejecutar17=$(mount | grep /var/log)
resultado[17]=$ejecutar17

numero[18]="1.1.12 Ensure separate partition exists for /var/log/audit"
ejecutar18=$(mount | grep /var/log/audit)
resultado[18]=$ejecutar18

numero[19]="1.1.13 Ensure separate partition exists for /home"
ejecutar19=$(mount | grep /home)
resultado[19]=$ejecutar19

numero[20]="1.1.14 Ensure nodev option set on /home partition"
ejecutar20=$(mount | grep /home)
resultado[20]=$ejecutar20

numero[21]="1.1.15 Ensure nodev option set on /dev/shm partition"
ejecutar21=$(mount | grep /dev/shm)
resultado[21]=$ejecutar21

numero[22]="1.1.16 Ensure nosuid option set on /dev/shm partition"
ejecutar22=$(mount | grep /dev/shm)
resultado[22]=$ejecutar22

numero[23]="1.1.17 Ensure noexec option set on /dev/shm partition"
ejecutar23=$(mount | grep /dev/shm)
resultado[23]=$ejecutar23

numero[24]="1.1.18 Ensure sticky bit is set on all world-writable directories"
ejecutar24=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)
resultado[24]=$ejecutar24

numero[25]="1.1.19 Disable Automounting"
ejecutar25=$(chkconfig --list autofs)
resultado[25]=$ejecutar25

numero[26]="1.2.1 Ensure package manager repositories are configured"
ejecutar26=$(yum repolist)
resultado[26]=$ejecutar26

numero[27]="1.2.2 Ensure GPG keys are configured"
ejecutar27=$(rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n')
resultado[27]=$ejecutar27

numero[28]="1.2.3 Ensure gpgcheck is globally activated"
ejecutar28=$(grep ^gpgcheck /etc/yum.conf;echo "<br>"; grep ^gpgcheck /etc/yum.repos.d/*)
resultado[28]=$ejecutar28

numero[29]="1.3.1 Ensure AIDE is installed"
ejecutar29=$(rpm -q aide)
resultado[29]=$ejecutar29

numero[30]="1.3.2 Ensure filesystem integrity is regularly checked"
ejecutar30=$(crontab -u root -l | grep aide;echo "<br>"; grep -r aide /etc/cron.* /etc/crontab)
resultado[30]=$ejecutar30

numero[31]="1.4.1 Ensure permissions on bootloader config are configured"
ejecutar31=$(stat /boot/grub/menu.lst)
resultado[31]=$ejecutar31

numero[32]="1.4.2 Ensure authentication required for single user mode"
ejecutar32=$(grep ^SINGLE /etc/sysconfig/init)
resultado[32]=$ejecutar32

numero[33]="1.4.3 Ensure interactive boot is not enabled"
ejecutar33=$(grep "^PROMPT=" /etc/sysconfig/init)
resultado[33]=$ejecutar33

numero[34]="1.5.1 Ensure core dumps are restricted"
ejecutar34=$(grep "hard core" /etc/security/limits.conf /etc/security/limits.d/*;echo "<br>"; sysctl fs.suid_dumpable;echo "<br>"; grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[34]=$ejecutar34

numero[35]="1.5.2 Ensure XD/NX support is enabled"
ejecutar35=$(dmesg | grep NX)
resultado[35]=$ejecutar35

numero[36]="1.5.3 Ensure address space layout randomization (ASLR) is enabled"
ejecutar36=$(sysctl kernel.randomize_va_space;echo "<br>"; grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[36]=$ejecutar36

numero[37]="1.5.4 Ensure prelink is disabled"
ejecutar37=$(rpm -q prelink)
resultado[37]=$ejecutar37

numero[38]="1.6.1.1 Ensure SELinux is not disabled in bootloader configuration"
ejecutar38=$(grep "^\s*kernel" /boot/grub/menu.lst)
resultado[38]=$ejecutar38

numero[39]="1.6.1.2 Ensure the SELinux state is enforcing"
ejecutar39=$(grep SELINUX=enforcing /etc/selinux/config;echo "<br>"; sestatus)
resultado[39]=$ejecutar39

numero[40]="1.6.1.3 Ensure SELinux policy is configured"
ejecutar40=$(grep SELINUXTYPE=targeted /etc/selinux/config;echo "<br>" ;sestatus)
resultado[40]=$ejecutar40

numero[41]="1.6.1.4 Ensure SETroubleshoot is not installed"
ejecutar41=$(rpm -q setroubleshoot)
resultado[41]=$ejecutar41

numero[42]="1.6.1.5 Ensure the MCS Translation Service (mcstrans) is not installed"
ejecutar42=$(rpm -q mcstrans)
resultado[42]=$ejecutar42

numero[43]="1.6.1.6 Ensure no unconfined daemons exist"
ejecutar43=$(ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' | awk '{ print $NF }')
resultado[43]=$ejecutar43

numero[44]="1.6.2 Ensure SELinux is installed"
ejecutar44=$(rpm -q libselinux)
resultado[44]=$ejecutar44

numero[45]="1.7.1.1 Ensure message of the day is configured properly"
ejecutar45=$(cat /etc/motd;echo "<br>"; egrep '(\\v|\\r|\\m|\\s)' /etc/motd)
resultado[45]=$ejecutar45

numero[46]="1.7.1.2 Ensure local login warning banner is configured properly"
ejecutar46=$(cat /etc/issue;echo "<br>"; egrep '(\\v|\\r|\\m|\\s)' /etc/issue)
resultado[46]=$ejecutar46

numero[47]="1.7.1.3 Ensure remote login warning banner is configured properly"
ejecutar47=$(cat /etc/issue.net;echo "<br>"; egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net)
resultado[47]=$ejecutar47

numero[48]="1.7.1.4 Ensure permissions on /etc/motd are configured"
ejecutar48=$(stat /etc/motd)
resultado[48]=$ejecutar48

numero[49]="1.7.1.5 Ensure permissions on /etc/issue are configured"
ejecutar49=$(stat /etc/issue)
resultado[49]=$ejecutar49

numero[50]="1.7.1.6 Ensure permissions on /etc/issue.net are configured"
ejecutar50=$(stat /etc/issue.net)
resultado[50]=$ejecutar50

numero[51]="1.8 Ensure updates, patches, and additional security software are installed"
ejecutar51=$(yum check-update)
resultado[51]=$ejecutar51

numero[52]="2.1.1 Ensure chargen services are not enabled"
ejecutar52=$(chkconfig --list)
resultado[52]=$ejecutar52

numero[53]="2.1.2 Ensure daytime services are not enabled"
ejecutar53=$(chkconfig --list)
resultado[53]=$ejecutar53

numero[54]="2.1.3 Ensure discard services are not enabled"
ejecutar54=$(chkconfig --list)
resultado[54]=$ejecutar54

numero[55]="2.1.4 Ensure echo services are not enabled"
ejecutar55=$(chkconfig --list)
resultado[55]=$ejecutar55

numero[56]="2.1.5 Ensure time services are not enabled"
ejecutar56=$(chkconfig --list)
resultado[56]=$ejecutar56

numero[57]="2.1.6 Ensure rsh server is not enabled"
ejecutar57=$(chkconfig --list)
resultado[57]=$ejecutar57

numero[58]="2.1.7 Ensure talk server is not enabled"
ejecutar58=$(chkconfig --list)
resultado[58]=$ejecutar58

numero[59]="2.1.8 Ensure telnet server is not enabled"
ejecutar59=$(chkconfig --list)
resultado[59]=$ejecutar59

numero[60]="2.1.9 Ensure tftp server is not enabled"
ejecutar60=$(chkconfig --list)
resultado[60]=$ejecutar60

numero[61]="2.1.10 Ensure rsync service is not enabled"
ejecutar61=$(chkconfig --list)
resultado[61]=$ejecutar61

numero[62]="2.1.11 Ensure xinetd is not enabled"
ejecutar62=$(chkconfig --list xinetd)
resultado[62]=$ejecutar62

numero[63]="2.2.1.1 Ensure time synchronization is in use"
ejecutar63=$(rpm -q ntp;echo "<br>"; rpm -q chrony)
resultado[63]=$ejecutar63

numero[64]="2.2.1.2 Ensure ntp is configured"
ejecutar64=$(grep "^restrict" /etc/ntp.conf;echo "<br>"; grep "^(server|pool)" /etc/ntp.conf;echo "<br>"; grep "daemon" /etc/init.d/ntpd)
resultado[64]=$ejecutar64

numero[65]="2.2.1.3 Ensure chrony is configured"
ejecutar65=$(grep "^(server|pool)" /etc/chrony.conf;echo "<br>"; grep ^OPTIONS /etc/sysconfig/chronyd)
resultado[65]=$ejecutar65

numero[66]="2.2.2 Ensure X Window System is not installed"
ejecutar66=$(rpm -qa xorg-x11*)
resultado[66]=$ejecutar66

numero[67]="2.2.3 Ensure Avahi Server is not enabled"
ejecutar67=$(chkconfig --list avahi-daemon)
resultado[67]=$ejecutar67

numero[68]="2.2.4 Ensure CUPS is not enabled"
ejecutar68=$(chkconfig --list cups)
resultado[68]=$ejecutar68

numero[69]="2.2.5 Ensure DHCP Server is not enabled"
ejecutar69=$(chkconfig --list dhcpd)
resultado[69]=$ejecutar69

numero[70]="2.2.6 Ensure LDAP server is not enabled"
ejecutar70=$(chkconfig --list slapd)
resultado[70]=$ejecutar70

numero[71]="2.2.7 Ensure NFS and RPC are not enabled"
ejecutar71=$(chkconfig --list nfs;echo "<br>"; chkconfig --list rpcbind)
resultado[71]=$ejecutar71

numero[72]="2.2.8 Ensure DNS Server is not enabled"
ejecutar72=$(chkconfig --list named)
resultado[72]=$ejecutar72

numero[73]="2.2.9 Ensure FTP Server is not enabled"
ejecutar73=$(chkconfig --list vsftpd)
resultado[73]=$ejecutar73

numero[74]="2.2.10 Ensure HTTP server is not enabled"
ejecutar74=$(chkconfig --list httpd)
resultado[74]=$ejecutar74

numero[75]="2.2.11 Ensure IMAP and POP3 server is not enabled"
ejecutar75=$(chkconfig --list dovecot)
resultado[75]=$ejecutar75

numero[76]="2.2.12 Ensure Samba is not enabled"
ejecutar76=$(chkconfig --list smb)
resultado[76]=$ejecutar76

numero[77]="2.2.13 Ensure HTTP Proxy Server is not enabled"
ejecutar77=$(chkconfig --list squid)
resultado[77]=$ejecutar77

numero[78]="2.2.14 Ensure SNMP Server is not enabled"
ejecutar78=$(chkconfig --list snmpd)
resultado[78]=$ejecutar78

numero[79]="2.2.15 Ensure mail transfer agent is configured for local-only mode"
ejecutar79=$(netstat -an | grep LIST | grep ":25[[:space:]]")
resultado[79]=$ejecutar79

numero[80]="2.2.16 Ensure NIS Server is not enabled"
ejecutar80=$(chkconfig --list ypserv)
resultado[80]=$ejecutar80

numero[81]="2.3.1 Ensure NIS Client is not installed"
ejecutar81=$(rpm -q ypbind)
resultado[81]=$ejecutar81

numero[82]="2.3.2 Ensure rsh client is not installed"
ejecutar82=$(rpm -q rsh)
resultado[82]=$ejecutar82

numero[83]="2.3.3 Ensure talk client is not installed"
ejecutar83=$(rpm -q talk)
resultado[83]=$ejecutar83

numero[84]="2.3.4 Ensure telnet client is not installed"
ejecutar84=$(rpm -q telnet)
resultado[84]=$ejecutar84

numero[85]="2.3.5 Ensure LDAP client is not installed"
ejecutar85=$(rpm -q openldap-clients)
resultado[85]=$ejecutar85

numero[86]="3.1.1 Ensure IP forwarding is disabled"
ejecutar86=$(sysctl net.ipv4.ip_forward;echo "<br>"; grep "net\.ipv4\.ip_forward" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[86]=$ejecutar86

numero[87]="3.1.2 Ensure packet redirect sending is disabled"
ejecutar87=$( sysctl net.ipv4.conf.all.send_redirects;echo "<br>"; sysctl net.ipv4.conf.default.send_redirects;echo "<br>"; grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf;echo "<br>"; grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.conf)
resultado[87]=$ejecutar87

numero[88]="3.2.1 Ensure source routed packets are not accepted"
ejecutar88=$(sysctl net.ipv4.conf.all.accept_source_route;echo "<br>"; sysctl net.ipv4.conf.default.accept_source_route;echo "<br>"; grep "net\.ipv4\.conf\.all\.accept_source_route" /etc/sysctl.conf;echo "<br>"; grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf)
resultado[88]=$ejecutar88

numero[89]="3.2.2 Ensure ICMP redirects are not accepted"
ejecutar89=$(sysctl net.ipv4.conf.all.accept_redirects;echo "<br>"; sysctl net.ipv4.conf.default.accept_redirects;echo "<br>"; grep "net\.ipv4\.conf\.all\.accept_redirects" /etc/sysctl.conf;echo "<br>"; grep "net\.ipv4\.conf\.default\.accept_redirects" /etc/sysctl.conf)
resultado[89]=$ejecutar89

numero[90]="3.2.3 Ensure secure ICMP redirects are not accepted"
ejecutar90=$(sysctl net.ipv4.conf.all.secure_redirects;echo "<br>"; sysctl net.ipv4.conf.default.secure_redirects;echo "<br>"; grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf;echo "<br>"; grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf)
resultado[90]=$ejecutar90

numero[91]="3.2.4 Ensure suspicious packets are logged"
ejecutar91=$(sysctl net.ipv4.conf.all.log_martians;echo "<br>"; sysctl net.ipv4.conf.default.log_martians;echo "<br>"; grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*;echo "<br>"; grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf)
resultado[91]=$ejecutar91

numero[92]="3.2.5 Ensure broadcast ICMP requests are ignored"
ejecutar92=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts;echo "<br>"; grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf)
resultado[92]=$ejecutar92

numero[93]="3.2.6 Ensure bogus ICMP responses are ignored"
ejecutar93=$(sysctl net.ipv4.icmp ignore bogus error responses;echo "<br>"; grep "net\.ipv4\.icmp_ignore_bogus_error_responses" /etc/sysctl.conf)
resultado[93]=$ejecutar93

numero[94]="3.2.7 Ensure Reverse Path Filtering is enabled"
ejecutar94=$(sysctl net.ipv4.conf.all.rp_filter;echo "<br>"; sysctl net.ipv4.conf.default.rp filter;echo "<br>"; grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*;echo "<br>"; grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[94]=$ejecutar94

numero[95]="3.2.8 Ensure TCP SYN Cookies is enabled"
ejecutar95=$(sysctl net.ipv4.tcp_syncookies;echo "<br>"; grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[95]=$ejecutar95

numero[96]="3.3.1 Ensure IPv6 router advertisements are not accepted"
ejecutar96=$(sysctl net.ipv6.conf.all.accept_ra;echo "<br>"; sysctl net.ipv6.conf.default.accept_ra;echo "<br>"; grep "net\.ipv6\.conf\.all\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*;echo "<br>"; grep "net\.ipv6\.conf\.default\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[96]=$ejecutar96

numero[97]="3.3.2 Ensure IPv6 redirects are not accepted"
ejecutar97=$(sysctl net.ipv6.conf.all.accept_redirects;echo "<br>"; sysctl net.ipv6.conf.default.accept_redirects;echo "<br>"; grep "net\.ipv6\.conf\.all\.accept_redirect" /etc/sysctl.conf;echo "<br>"; grep "net\.ipv6\.conf\.default\.accept_redirect" /etc/sysctl.conf /etc/sysctl.d/*)
resultado[97]=$ejecutar97

numero[98]="3.3.3 Ensure IPv6 is disabled"
ejecutar98=$(grep "^\s*kernel" /boot/grub/grub.conf)
resultado[98]=$ejecutar98

numero[99]="3.4.1 Ensure TCP Wrappers is installed"
ejecutar99=$(rpm -q tcp_wrappers;echo "<br>"; rpm -q tcp_wrappers-libs)
resultado[99]=$ejecutar99

numero[100]="3.4.2 Ensure /etc/hosts.allow is configured"
ejecutar100=$(cat /etc/hosts.allow)
resultado[100]=$ejecutar100

numero[101]="3.4.3 Ensure /etc/hosts.deny is configured "
ejecutar101=$(cat /etc/hosts.deny)
resultado[101]=$ejecutar101

numero[102]="3.4.4 Ensure permissions on /etc/hosts.allow are configured"
ejecutar102=$(stat /etc/hosts.allow)
resultado[102]=$ejecutar102

numero[103]="3.4.5 Ensure permissions on /etc/hosts.deny are configured"
ejecutar103=$(stat /etc/hosts.deny)
resultado[103]=$ejecutar103

numero[104]="3.5.1 Ensure DCCP is disabled"
ejecutar104=$(modprobe -n -v dccp;echo "<br>"; lsmod | grep dccp)
resultado[104]=$ejecutar104

numero[105]="3.5.2 Ensure SCTP is disabled"
ejecutar105=$(modprobe -n -v sctp;echo "<br>"; lsmod | grep sctp)
resultado[105]=$ejecutar105

numero[106]="3.5.3 Ensure RDS is disabled"
ejecutar106=$(modprobe -n -v rds;echo "<br>"; lsmod | grep rds)
resultado[106]=$ejecutar106

numero[107]="3.5.4 Ensure TIPC is disabled"
ejecutar107=$(modprobe -n -v tipc;echo "<br>"; lsmod | grep tipc)
resultado[107]=$ejecutar107

numero[108]="3.6.1 Ensure iptables is installed"
ejecutar108=$(rpm -q iptables)
resultado[108]=$ejecutar108

numero[109]="3.6.2 Ensure default deny firewall policy"
ejecutar109=$(iptables -L)
resultado[109]=$ejecutar109

numero[110]="3.6.3 Ensure loopback traffic is configured"
ejecutar110=$(iptables -L INPUT -v -n;echo "<br>"; iptables -L OUTPUT -v -n)
resultado[110]=$ejecutar110

numero[111]="3.6.4 Ensure outbound and established connections are configured"
ejecutar111=$(iptables -L -v -n)
resultado[111]=$ejecutar111

numero[112]="3.6.5 Ensure firewall rules exist for all open ports"
ejecutar112=$(netstat -ln;echo "<br>"; iptables -L INPUT -v -n)
resultado[112]=$ejecutar112

numero[113]="4.1.1.1 Ensure audit log storage size is configured"
ejecutar113=$(grep max_log_file /etc/audit/auditd.conf)
resultado[113]=$ejecutar113

numero[114]="4.1.1.2 Ensure system is disabled when audit logs are full"
ejecutar114=$(grep space_left_action /etc/audit/auditd.conf;echo "<br>"; grep action_mail_acct /etc/audit/auditd.conf;echo "<br>"; grep admin_space_left_action /etc/audit/auditd.conf)
resultado[114]=$ejecutar114

numero[115]="4.1.1.3 Ensure audit logs are not automatically deleted"
ejecutar115=$(grep max_log_file_action /etc/audit/auditd.conf)
resultado[115]=$ejecutar115

numero[116]="4.1.2 Ensure auditd service is enabled"
ejecutar116=$(chkconfig --list auditd)
resultado[116]=$ejecutar116

numero[117]="4.1.3 Ensure auditing for processes that start prior to auditd is enabled"
ejecutar117=$(grep "^\s*kernel" /boot/grub/menu.lst)
resultado[117]=$ejecutar117

#64 bit
numero[118]="4.1.4 Ensure events that modify date and time information are collected"
ejecutar118=$(grep time-change /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep time-change)
resultado[118]=$ejecutar118

numero[119]="4.1.5 Ensure events that modify user/group information are collected"
ejecutar119=$(grep identity /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep identity)
resultado[119]=$ejecutar119

numero[120]="4.1.6 Ensure events that modify the system's network environment are collected"
ejecutar120=$(grep system-locale /etc/audit/audit.rules)
resultado[120]=$ejecutar120

numero[121]="4.1.7 Ensure events that modify the system's Mandatory Access Controls are collected"
ejecutar121=$(grep MAC-policy /etc/audit/audit.rules)
resultado[121]=$ejecutar121

numero[122]="4.1.8 Ensure login and logout events are collected"
ejecutar122=$(grep logins /etc/audit/audit.rules)
resultado[122]=$ejecutar122

numero[123]="4.1.9 Ensure session initiation information is collected"
ejecutar123=$(grep session /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep session;echo "<br>"; grep logins /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep logins)
resultado[123]=$ejecutar123

numero[124]="4.1.10 Ensure discretionary access control permission modification events are collected"
ejecutar124=$(grep perm_mod /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep perm_mod)
resultado[124]=$ejecutar124

numero[125]="4.1.11 Ensure unsuccessful unauthorized file access attempts are collected"
ejecutar125=$(grep access /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep access)
resultado[125]=$ejecutar125

#reemplazar <partition> por la particion del sistema
numero[126]="4.1.12 Ensure use of privileged commands is collected"
ejecutar126=$(find /bin -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>";find /boot -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /cgroup -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /dev -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /etc -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /home -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -Fauid!=4294967295 -k privileged" }';echo "<br>"; find /lib -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /lib64 -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /local -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /lost+found -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path="$1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /media -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -Fpath=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /mnt -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /opt -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /proc -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /root -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /run -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk'{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /sbin -xdev \( -perm -4000 -o -perm -2000 \) -type f| awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /selinux -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /srv -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /sys -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /tmp -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /tmp_old -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /usr -xdev \(-perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }';echo "<br>"; find /var -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }')
resultado[126]=$ejecutar126

numero[127]="4.1.13 Ensure successful file system mounts are collected"
ejecutar127=$(grep mounts /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep mounts)
resultado[127]=$ejecutar127

numero[128]="4.1.14 Ensure file deletion events by users are collected "
ejecutar128=$(grep delete /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep delete)
resultado[128]=$ejecutar128

numero[129]="4.1.15 Ensure changes to system administration scope (sudoers) is collected"
ejecutar129=$( grep scope /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep scope)
resultado[129]=$ejecutar129

numero[130]="4.1.16 Ensure system administrator actions (sudolog) are collected"
ejecutar130=$(grep actions /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep actions)
resultado[130]=$ejecutar130

numero[131]="4.1.17 Ensure kernel module loading and unloading is collected"
ejecutar131=$(grep modules /etc/audit/audit.rules;echo "<br>"; auditctl -l | grep modules)
resultado[131]=$ejecutar131

numero[132]="4.1.18 Ensure the audit configuration is immutable"
ejecutar132=$(grep "^\s*[^#]" /etc/audit/audit.rules | tail -1)
resultado[132]=$ejecutar132

numero[133]="4.2.1.1 Ensure rsyslog Service is enabled"
ejecutar133=$(chkconfig --list rsyslog)
resultado[133]=$ejecutar133

numero[134]="4.2.1.2 Ensure logging is configured"
ejecutar134=$(ls -l /var/log/)
resultado[134]=$ejecutar134

numero[135]="4.2.1.3 Ensure rsyslog default file permissions configured"
ejecutar135=$(grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
resultado[135]=$ejecutar135

numero[136]="4.2.1.4 Ensure rsyslog is configured to send logs to a remote log host"
ejecutar136=$(grep "^*.*[^I][^I]*@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
resultado[136]=$ejecutar136

numero[137]="4.2.1.5 Ensure remote rsyslog messages are only accepted on designated log hosts."
ejecutar137=$(grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf;echo "<br>"; grep '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
resultado[137]=$ejecutar137

numero[138]="4.2.2.1 Ensure syslog-ng service is enabled"
ejecutar138=$(chkconfig --list syslog-ng)
resultado[138]=$ejecutar138

numero[139]="4.2.2.2 Ensure logging is configured"
ejecutar139=$(ls -l /var/log/)
resultado[139]=$ejecutar139

numero[140]="4.2.2.3 Ensure syslog-ng default file permissions configured"
ejecutar140=$(grep ^options /etc/syslog-ng/syslog-ng.conf)
resultado[140]=$ejecutar140

numero[141]="4.2.2.4 Ensure syslog-ng is configured to send logs to a remote log host"
ejecutar141=$(cat  the /etc/syslog-ng/syslog-ng.conf)
resultado[141]=$ejecutar141

numero[142]="4.2.2.5 Ensure remote syslog-ng messages are only accepted on designated log hosts"
ejecutar142=$(cat /etc/syslog-ng/syslog-ng.conf)
resultado[142]=$ejecutar142

numero[143]="4.2.3 Ensure rsyslog or syslog-ng is installed"
ejecutar143=$(rpm -q rsyslog;echo "<br>"; rpm -q syslog-ng)
resultado[143]=$ejecutar143

numero[144]="4.2.4 Ensure permissions on all logfiles are configured"
ejecutar144=$(find /var/log -type f -ls)
resultado[144]=$ejecutar144

numero[145]="4.3 Ensure logrotate is configured"
ejecutar145=$(cat /etc/logrotate.conf;echo "<br>"; cat /etc/logrotate.d/*)
resultado[145]=$ejecutar145

numero[146]="5.1.1 Ensure cron daemon is enabled"
ejecutar146=$(chkconfig --list crond)
resultado[146]=$ejecutar146

numero[147]="5.1.2 Ensure permissions on /etc/crontab are configured"
ejecutar147=$(stat /etc/crontab)
resultado[147]=$ejecutar147

numero[148]="5.1.3 Ensure permissions on /etc/cron.hourly are configured"
ejecutar148=$(stat /etc/cron.hourly)
resultado[148]=$ejecutar148

numero[149]="5.1.4 Ensure permissions on /etc/cron.daily are configured"
ejecutar149=$(stat /etc/cron.daily)
resultado[149]=$ejecutar149

numero[150]="5.1.5 Ensure permissions on /etc/cron.weekly are configured"
ejecutar150=$(stat /etc/cron.weekly)
resultado[150]=$ejecutar150

numero[151]="5.1.6 Ensure permissions on /etc/cron.monthly are configured"
ejecutar151=$(stat /etc/cron.monthly)
resultado[151]=$ejecutar151

numero[152]="5.1.7 Ensure permissions on /etc/cron.d are configured"
ejecutar152=$(stat /etc/cron.d)
resultado[152]=$ejecutar152

numero[153]="5.1.8 Ensure at/cron is restricted to authorized users"
ejecutar153=$(stat /etc/cron.deny;echo "<br>"; stat /etc/at.deny;echo "<br>"; stat /etc/cron.allow;echo "<br>"; stat /etc/at.allow)
resultado[153]=$ejecutar153

numero[154]="5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured"
ejecutar154=$(stat /etc/ssh/sshd_config)
resultado[154]=$ejecutar154

numero[155]="5.2.2 Ensure SSH Protocol is set to 2"
ejecutar155=$(grep "^Protocol" /etc/ssh/sshd_config)
resultado[155]=$ejecutar155

numero[156]="5.2.3 Ensure SSH LogLevel is set to INFO"
ejecutar156=$(grep "^LogLevel" /etc/ssh/sshd_config)
resultado[156]=$ejecutar156

numero[157]="5.2.4 Ensure SSH X11 forwarding is disabled"
ejecutar157=$(grep "^X11Forwarding" /etc/ssh/sshd_config)
resultado[157]=$ejecutar157

numero[158]="5.2.5 Ensure SSH MaxAuthTries is set to 4 or less"
ejecutar158=$(grep "^MaxAuthTries" /etc/ssh/sshd_config)
resultado[158]=$ejecutar158

numero[159]="5.2.6 Ensure SSH IgnoreRhosts is enabled"
ejecutar159=$(grep "^IgnoreRhosts" /etc/ssh/sshd_config)
resultado[159]=$ejecutar159

numero[160]="5.2.7 Ensure SSH HostbasedAuthentication is disabled"
ejecutar160=$(grep "^HostbasedAuthentication" /etc/ssh/sshd_config)
resultado[160]=$ejecutar160

numero[161]="5.2.8 Ensure SSH root login is disabled "
ejecutar161=$(grep "^PermitRootLogin" /etc/ssh/sshd_config)
resultado[161]=$ejecutar161

numero[162]="5.2.9 Ensure SSH PermitEmptyPasswords is disabled"
ejecutar162=$(grep "^PermitEmptyPasswords" /etc/ssh/sshd_config)
resultado[162]=$ejecutar162

numero[163]="5.2.10 Ensure SSH PermitUserEnvironment is disabled"
ejecutar163=$(grep PermitUserEnvironment /etc/ssh/sshd_config)
resultado[163]=$ejecutar163

numero[164]="5.2.11 Ensure only approved MAC algorithms are used"
ejecutar164=$(grep "MACs" /etc/ssh/sshd_config)
resultado[164]=$ejecutar164

numero[165]="5.2.12 Ensure SSH Idle Timeout Interval is configured "
ejecutar165=$(grep "^ClientAliveInterval" /etc/ssh/sshd_config;echo "<br>"; grep "^ClientAliveCountMax" /etc/ssh/sshd_config)
resultado[165]=$ejecutar165

numero[166]="5.2.13 Ensure SSH LoginGraceTime is set to one minute or less"
ejecutar166=$(grep "^LoginGraceTime" /etc/ssh/sshd_config)
resultado[166]=$ejecutar166

numero[167]="5.2.14 Ensure SSH access is limited"
ejecutar167=$(grep "^AllowUsers" /etc/ssh/sshd_config;echo "<br>"; grep "^AllowGroups" /etc/ssh/sshd_config;echo "<br>"; grep "^DenyUsers" /etc/ssh/sshd_config;echo "<br>"; grep "^DenyGroups" /etc/ssh/sshd_config)
resultado[167]=$ejecutar167

numero[168]="5.2.15 Ensure SSH warning banner is configured"
ejecutar168=$(grep "^Banner" /etc/ssh/sshd_config)
resultado[168]=$ejecutar168

numero[169]="5.3.1 Ensure password creation requirements are configured"
ejecutar169=$(grep pam_pwquality.so /etc/pam.d/password-auth;echo "<br>"; grep pam_pwquality.so /etc/pam.d/system-auth;echo "<br>"; grep ^minlen /etc/security/pwquality.conf;echo "<br>"; grep ^dcredit /etc/security/pwquality.conf;echo "<br>"; grep ^lcredit /etc/security/pwquality.conf;echo "<br>"; grep ^ocredit /etc/security/pwquality.conf;echo "<br>"; grep ^ucredit /etc/security/pwquality.conf)
resultado[169]=$ejecutar169

numero[170]="5.3.2 Ensure lockout for failed password attempts is configured"
ejecutar170=$(cat  the /etc/pam.d/password-auth;echo "<br>"; cat  /etc/pam.d/system-auth)
resultado[170]=$ejecutar170

numero[171]="5.3.3 Ensure password reuse is limited"
ejecutar171=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth;echo "<br>"; egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth;echo "<br>"; egrep '^password\s+required\s+pam_pwhistory.so' /etc/pam.d/password-auth;echo "<br>"; egrep '^password\s+required\s+pam_pwhistory.so' /etc/pam.d/system-auth)
resultado[171]=$ejecutar171

numero[172]="5.3.4 Ensure password hashing algorithm is SHA-512"
ejecutar172=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth;echo "<br>"; egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth)
resultado[172]=$ejecutar172

numero[173]="5.4.1.1 Ensure password expiration is 365 days or less"
ejecutar173=$(grep PASS_MAX_DAYS /etc/login.defs)
resultado[173]=$ejecutar173

numero[174]="5.4.1.2 Ensure minimum days between password changes is 7 or more"
ejecutar174=$(grep PASS_MIN_DAYS /etc/login.defs)
resultado[174]=$ejecutar174

numero[175]="5.4.1.3 Ensure password expiration warning days is 7 or more"
ejecutar175=$(grep PASS_WARN_AGE /etc/login.defs)
resultado[175]=$ejecutar175

numero[176]="5.4.1.4 Ensure inactive password lock is 30 days or less"
ejecutar176=$(useradd -D | grep INACTIVE)
resultado[176]=$ejecutar176

numero[177]="5.4.1.5 Ensure inactive password lock is 30 days or less"
ejecutar177="" #el resultado se muestra como cuadro al final
resultado[177]=$ejecutar177

numero[178]="5.4.2 Ensure system accounts are non-login"
ejecutar178=$(egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<500 && $7!="/sbin/nologin" && $7!="/bin/false") {print}' )
resultado[178]=$ejecutar178

numero[179]="5.4.3 Ensure default group for the root account is GID 0"
ejecutar179=$(grep "^root:" /etc/passwd | cut -f4 -d:)
resultado[179]=$ejecutar179

numero[180]="5.4.4 Ensure default user umask is 027 or more restrictive"
ejecutar180=$(grep "umask" /etc/bashrc;echo "<br>";  grep "umask" /etc/profile /etc/profile.d/*.sh)
resultado[180]=$ejecutar180

numero[181]="5.4.5 Ensure default user shell timeout is 900 seconds or less"
ejecutar181=$(grep "^TMOUT" /etc/bashrc;echo "<br>";  grep "^TMOUT" /etc/profile)
resultado[181]=$ejecutar181

numero[182]="5.5 Ensure access to the su command is restricted"
ejecutar182=$(grep pam_wheel.so /etc/pam.d/su;echo "<br>"; grep wheel /etc/group)
resultado[182]=$ejecutar182

numero[183]="6.1.1 Audit system file permissions"
ejecutar183=$(rpm -Va --nomtime --nosize --nomd5 --nolinkto)
resultado[183]=$ejecutar183

numero[184]="6.1.2 Ensure permissions on /etc/passwd are configured"
ejecutar184=$(stat /etc/passwd)
resultado[184]=$ejecutar184

numero[185]="6.1.3 Ensure permissions on /etc/shadow are configured"
ejecutar185=$(stat /etc/shadow)
resultado[185]=$ejecutar185

numero[186]="6.1.4 Ensure permissions on /etc/group are configured"
ejecutar186=$(stat /etc/group)
resultado[186]=$ejecutar186

numero[187]="6.1.5 Ensure permissions on /etc/gshadow are configured"
ejecutar187=$(stat /etc/gshadow)
resultado[187]=$ejecutar187

numero[188]="6.1.6 Ensure permissions on /etc/passwd- are configured"
ejecutar188=$(stat /etc/passwd-)
resultado[188]=$ejecutar188

numero[189]="6.1.7 Ensure permissions on /etc/shadow- are configured"
ejecutar189=$(stat /etc/shadow-)
resultado[189]=$ejecutar189

numero[190]="6.1.8 Ensure permissions on /etc/group- are configured"
ejecutar190=$(stat /etc/group-)
resultado[190]=$ejecutar190

numero[191]="6.1.9 Ensure permissions on /etc/gshadow- are configured"
ejecutar191=$(stat /etc/gshadow-)
resultado[191]=$ejecutar191

#se comento los otros script porque que pasa si se aumenta las particiones
numero[192]="6.1.10 Ensure no world writable files exist"
#ejecutar191=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002;echo "<br>";find /bin -xdev -type f -perm -0002;echo "<br>"; find #/boot -xdev -type f -perm -0002;echo "<br>"; find /cgroup -xdev -type f -perm -0002;echo "<br>"; find /dev -xdev -type f -perm -0002;echo "<br>"; find /etc -xdev -type f -perm #-0002;echo "<br>"; find /home -xdev -type f -perm -0002;echo "<br>";  find /lib -xdev -type f -perm -0002;echo "<br>";find /lib64 -xdev -type f -perm -0002;echo "<br>"; find #/local -xdev -type f -perm -0002;echo "<br>";find /lost+found -xdev -type f -perm -0002;echo "<br>"; find /media -xdev -type f -perm -0002;echo "<br>"; find /mnt -xdev -type f #-perm -0002;echo "<br>"; find /opt -xdev -type f -perm -0002;echo "<br>"; find /proc -xdev -type f -perm -0002;echo "<br>"; find /root -xdev -type f -perm -0002;echo "<br>"; find #/run -xdev -type f -perm -0002;echo "<br>"; find /sbin -xdev -type f -perm -0002;echo "<br>"; find /selinux -xdev -type f -perm -0002;echo"<br>"; find /srv -xdev -type f -perm #-0002;echo "<br>"; find /sys -xdev -type f -perm -0002;echo "<br>"; find /tmp -xdev -type f -perm -0002;echo "<br>"; find /tmp_old -xdev -type f -perm -0002;echo "<br>"; find /usr #-xdev -type f -perm -0002;echo "<br>" find /var -xdev -type f -perm -0002)
ejecutar192=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002)
resultado[192]=$ejecutar192

numero[193]="6.1.11 Ensure no unowned files or directories exist"
ejecutar193=$( df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)
resultado[193]=$ejecutar193

numero[194]="6.1.12 Ensure no ungrouped files or directories exist"
ejecutar194=$( df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup)
resultado[194]=$ejecutar194

numero[195]="6.1.13 Audit SUID executables"
ejecutar195=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -4000)
resultado[195]=$ejecutar195

numero[196]="6.1.14 Audit SGID executables"
ejecutar196=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000)
resultado[196]=$ejecutar196

numero[197]="6.2.1 Ensure password fields are not empty"
ejecutar197=$(cat /etc/shadow | awk -F: '($2 == "" ) { print $1 " does not have a password "}')
resultado[197]=$ejecutar197

numero[198]="6.2.2 Ensure no legacy "+" entries exist in /etc/passwd"
ejecutar198=$(grep '^\+:' /etc/passwd)
resultado[198]=$ejecutar198

numero[199]="6.2.3 Ensure no legacy "+" entries exist in /etc/shadow"
ejecutar199=$(grep '^\+:' /etc/shadow)
resultado[199]=$ejecutar199

numero[200]="6.2.4 Ensure no legacy "+" entries exist in /etc/group"
ejecutar200=$(grep '^\+:' /etc/group)
resultado[200]=$ejecutar200

numero[201]="6.2.5 Ensure root is the only UID 0 account"
ejecutar201=$(cat /etc/passwd | awk -F: '($3 == 0) { print $1 }')
resultado[201]=$ejecutar201


#6.2.6 Ensure root PATH Integrity
function EnsurerootPATHIntegrity()
{
        if [ "`echo $PATH | grep :: `" != "" ]; then
          echo "Empty Directory in PATH (::)"
        fi
        if [ "`echo $PATH | grep :$`" != "" ]; then
          echo "Trailing : in PATH"
        fi
        p=`echo $PATH | sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'`
        set -- $p
        while [ "$1" != "" ]; do
          if [ "$1" = "." ]; then
                echo "PATH contains ."
                shift
                continue
          fi
          if [ -d $1 ]; then
                dirperm=`ls -ldH $1 | cut -f1 -d" "`
                if [ `echo $dirperm | cut -c6 ` != "-" ]; then
                  echo "Group Write permission set on directory $1"
                fi
          if [ `echo $dirperm | cut -c9 ` != "-" ]; then
                echo "Other Write permission set on directory $1"
          fi
          dirown=`ls -ldH $1 | awk '{print $3}'`
          if [ "$dirown" != "root" ] ; then
                echo $1 is not owned by root
          fi
          else
                echo $1 is not a directory
          fi
          shift
        done
}
numero[202]="6.2.6 Ensure root PATH Integrity"
ejecutar202=$(EnsurerootPATHIntegrity)
resultado[202]=$ejecutar202
#6.2.6 Ensure root PATH Integrity

#6.2.7 Ensure all users' home directories exist
function Ensureallusers
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          fi
        done
}
numero[203]="6.2.7 Ensure all users' home directories exist"
ejecutar203=$(Ensureallusers)
resultado[203]=$ejecutar203
#6.2.7 Ensure all users' home directories exist

#6.2.8 Ensure users' home directories permissions are 750 or more restrictive
function Ensureusers
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                dirperm=`ls -ld $dir | cut -f1 -d" "`
                if [ `echo $dirperm | cut -c6` != "-" ]; then
                  echo "Group Write permission set on the home directory ($dir) of user $user"
                fi
                if [ `echo $dirperm | cut -c8` != "-" ]; then
                  echo "Other Read permission set on the home directory ($dir) of user $user"
                fi
                if [ `echo $dirperm | cut -c9` != "-" ]; then
                  echo "Other Write permission set on the home directory ($dir) of user $user"
                fi
                if [ `echo $dirperm | cut -c10` != "-" ]; then
                  echo "Other Execute permission set on the home directory ($dir) of user $user"
                fi
          fi
        done
}
numero[204]="6.2.8 Ensure users' home directories permissions are 750 or more restrictive"
ejecutar204=$(Ensureusers)
resultado[204]=$ejecutar204
#6.2.8 Ensure users' home directories permissions are 750 or more restrictive

#6.2.9 Ensure users own their home directories (Scored)
function Ensureusersowntheirhomedirectories
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
           owner=$(stat -L -c "%U" "$dir")
           if [ "$owner" != "$user" ]; then
                 echo "The home directory ($dir) of user $user is owned by $owner."
           fi
         fi
        done
}
numero[205]="6.2.9 Ensure users own their home directories"
ejecutar205=$(Ensureusersowntheirhomedirectories)
resultado[205]=$ejecutar205
#6.2.9 Ensure users own their home directories (Scored)

#6.2.10 Ensure users' dot files are not group or world writable (Scored)
function Ensureusersdotfilesarenotgrouporworldwritable
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                for file in $dir/.[A-Za-z0-9]*; do
                  if [ ! -h "$file" -a -f "$file" ]; then
                        fileperm=`ls -ld $file | cut -f1 -d" "`

                        if [ `echo $fileperm | cut -c6`  != "-" ]; then
                          echo "Group Write permission set on file $file"
                        fi
                        if [ `echo $fileperm | cut -c9`  != "-" ]; then
                          echo "Other Write permission set on file $file"
                        fi
                  fi
                done
          fi
        done
}
numero[206]="6.2.10 Ensure users' dot files are not group or world writable"
ejecutar206=$(Ensureusersdotfilesarenotgrouporworldwritable)
resultado[206]=$ejecutar206
#6.2.10 Ensure users' dot files are not group or world writable (Scored)

#6.2.11 Ensure no users have .forward files (Scored)
function Ensurenousershaveforward
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
                  echo ".forward file $dir/.forward exists"
                fi
          fi
        done
}
numero[207]="6.2.11 Ensure no users have .forward files"
ejecutar207=$(Ensurenousershaveforward)
resultado[207]=$ejecutar207
#6.2.11 Ensure no users have .forward files (Scored)

#6.2.12 Ensure no users have .netrc files (Scored)
function Ensurenousershavenetrc
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
                  echo ".netrc file $dir/.netrc exists"
                fi
          fi
        done
}
numero[208]="6.2.12 Ensure no users have .netrc files"
ejecutar208=$(Ensurenousershavenetrc)
resultado[208]=$ejecutar208
#6.2.12 Ensure no users have .netrc files (Scored)

#6.2.13 Ensure users' .netrc Files are not group or world accessible
function EnsureusersnetrcFilesarenotgroup
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                for file in $dir/.netrc; do
                  if [ ! -h "$file" -a -f "$file" ]; then
                        fileperm=`ls -ld $file | cut -f1 -d" "`
                        if [ `echo $fileperm | cut -c5`  != "-" ]; then
                          echo "Group Read set on $file"
                        fi
                        if [ `echo $fileperm | cut -c6`  != "-" ]; then
                          echo "Group Write set on $file"
                        fi
                        if [ `echo $fileperm | cut -c7`  != "-" ]; then
                          echo "Group Execute set on $file"
                        fi
                        if [ `echo $fileperm | cut -c8`  != "-" ]; then
                          echo "Other Read set on $file"
                        fi
                        if [ `echo $fileperm | cut -c9`  != "-" ]; then
                          echo "Other Write set on $file"
                        fi
                        if [ `echo $fileperm | cut -c10`  != "-" ]; then
                          echo "Other Execute set on $file"
                        fi
                  fi
                done
                fi
        done
}
numero[209]="6.2.13 Ensure users' .netrc Files are not group or world accessible"
ejecutar209=$(EnsureusersnetrcFilesarenotgroup)
resultado[209]=$ejecutar209
#6.2.13 Ensure users' .netrc Files are not group or world accessible

#6.2.14 Ensure no users have .rhosts files (Scored)
function Ensurenousershaverhostsfiles
{
        cat /etc/passwd | egrep -v '^(root|halt|sync|shutdown)' | awk -F: '($7 !="/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do
          if [ ! -d "$dir" ]; then
                echo "The home directory ($dir) of user $user does not exist."
          else
                for file in $dir/.rhosts; do
                  if [ ! -h "$file" -a -f "$file" ]; then
                        echo ".rhosts file in $dir"
                  fi
                done
          fi
        done
}
numero[210]="6.2.14 Ensure no users have .rhosts files"
ejecucion210=$(Ensurenousershaverhostsfiles)
resultado[210]=$ejecucion210
#6.2.14 Ensure no users have .rhosts files (Scored)

#6.2.15 Ensure all groups in /etc/passwd exist in /etc/group (Scored)
function Ensureallgroupsinetcpasswd
{
        for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
          grep -q -P "^.*?:[^:]*:$i:" /etc/group
          if [ $? -ne 0 ]; then
                echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
          fi
        done
}
numero[211]="6.2.15 Ensure all groups in /etc/passwd exist in /etc/group"
ejecucion211=$(Ensureallgroupsinetcpasswd)
resultado[211]=$ejecucion211
#6.2.15 Ensure all groups in /etc/passwd exist in /etc/group (Scored)

#6.2.16 Ensure no duplicate UIDs exist (Scored)
function EnsurenoduplicateUIDsexist
{
        cat /etc/passwd | cut -f3 -d":" | sort -n | uniq -c | while read x ; do
          [ -z "${x}" ] && break
          set - $x
          if [ $1 -gt 1 ]; then
                users= `awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs`
                echo "Duplicate UID ($2): ${users}"
          fi
        done
}
numero[212]="6.2.16 Ensure no duplicate UIDs exist"
ejecucion212=$(EnsurenoduplicateUIDsexist)
resultado[212]=$ejecucion212
#6.2.16 Ensure no duplicate UIDs exist (Scored)

#6.2.17 Ensure no duplicate GIDs exist (Scored)
function EnsurenoduplicateGIDsexist
{
        cat /etc/group | cut -f3 -d":" | sort -n | uniq -c | while read x ; do
          [ -z "${x}" ] && break
          set - $x
          if [ $1 -gt 1 ]; then
                groups= `awk -F: '($3 == n) { print $1 }' n=$2 /etc/group | xargs`
                echo "Duplicate GID ($2): ${groups}"
          fi
        done
}
numero[213]="6.2.17 Ensure no duplicate GIDs exist"
ejecucion213=$(EnsurenoduplicateGIDsexist)
resultado[213]=$ejecucion213
#6.2.17 Ensure no duplicate GIDs exist (Scored)

#6.2.18 Ensure no duplicate user names exist (Scored)
function Ensurenoduplicateusernamesexist
{
        cat /etc/passwd | cut -f1 -d":" | sort -n | uniq -c | while read x ; do
          [ -z "${x}" ] && break
          set - $x
          if [ $1 -gt 1 ]; then
                uids= `awk -F: '($1 == n) { print $3 }' n=$2 /etc/passwd | xargs`
                echo "Duplicate User Name ($2): ${uids}"
          fi
        done
}
numero[214]="6.2.18 Ensure no duplicate user names exist"
ejecucion214=$(Ensurenoduplicateusernamesexist)
resultado[214]=$ejecucion214
#6.2.18 Ensure no duplicate user names exist (Scored)

#6.2.19 Ensure no duplicate group names exist (Scored)
function Ensurenoduplicategroupnamesexist
{
        cat /etc/group | cut -f1 -d":" | sort -n | uniq -c | while read x ; do
          [ -z "${x}" ] && break
          set - $x
          if [ $1 -gt 1 ]; then
                gids= `gawk -F: '($1 == n) { print $3 }' n=$2 /etc/group | xargs`
                echo "Duplicate Group Name ($2): ${gids}"
          fi
        done
}
numero[215]="6.2.19 Ensure no duplicate group names exist"
ejecucion215=$(Ensurenoduplicategroupnamesexist)
resultado[215]=$ejecucion215
#6.2.19 Ensure no duplicate group names exist (Scored)

textoNoValidado="NO VALIDADO"
#validaciones de cumplimiento
#cumplimiento 1.1.1.1
cumplimiento[0]=$textoNoValidado
#cumplimiento 1.1.1.2
cumplimiento[1]=$textoNoValidado

#cumplimiento 1.1.1.3
cumplimiento[2]=$textoNoValidado

#cumplimiento 1.1.1.4
cumplimiento[3]=$textoNoValidado

#cumplimiento 1.1.1.5
cumplimiento[4]=$textoNoValidado

#cumplimiento 1.1.1.6
cumplimiento[5]=$textoNoValidado

#cumplimiento 1.1.1.7
cumplimiento[6]=$textoNoValidado

#cumplimiento 1.1.1.8
cumplimiento[7]=$textoNoValidado

#cumplimiento 1.1.2
if [[ $ejecutar8 == *' on /tmp '* ]]; then
        cumplimiento[8]="SI"
else
        cumplimiento[8]="NO"
fi
#cumplimiento 1.1.2

#cumplimiento 1.1.3
if [[ $ejecutar9 == *nodev* ]]
then
   cumplimiento[9]="SI";
else
   cumplimiento[9]="NO";
fi
#cumplimiento 1.1.3

#cumplimiento 1.1.4
if [[ $ejecutar10 == *'nosuid'* ]]; then
        cumplimiento[10]="SI";
else
        cumplimiento[10]="NO";
fi
#cumplimiento 1.1.4

#cumplimiento 1.1.5
if [[ $ejecutar11 == *'noexec'* ]] ;then
        cumplimiento[11]="SI";
else
        cumplimiento[11]="NO";
fi
#cumplimiento 1.1.5

#cumplimiento 1.1.6
if [[ `echo $ejecutar12 | grep '^/dev/[A-Za-z0-9]'` ]] && [[ $ejecutar12 == *' on /var '* ]]
then
   cumplimiento[12]="SI";
else
   cumplimiento[12]="NO";
fi
#cumplimiento 1.1.6

#cumplimiento 1.1.7
if [[ $ejecutar13 == *' on /var/tmp '* ]];then
        cumplimiento[13]="SI";
else
        cumplimiento[13]="NO";
fi
#cumplimiento 1.1.7

#cumplimiento 1.1.8
if [[ -n $ejecutar14 ]] && [[ $ejecutar14 == *'nodev'* ]];then #comprobamos que exista la conf y luego la condici
        cumplimiento[14]="SI";
elif [[ -z $ejecutar14 ]];then  # si no existe no habria nada que evaluar por tanto no cumple
        cumplimiento[14]="NO";
else
        cumplimiento[14]="NO";
fi
#cumplimiento 1.1.8

#cumplimiento 1.1.9
if [[ -n $ejecutar15 ]] && [[ $ejecutar15 == *'nosuid'* ]]; then
        cumplimiento[15]="SI"
elif [[ -z $ejecutar15 ]]; then
        cumplimiento[15]="NO";
else
        cumplimiento[15]="NO";
fi
#cumplimiento 1.1.9

#cumplimiento 1.1.10
if [[ $ejecutar16 == *'noexec'* ]]; then
        cumplimiento[16]="SI";
else
        cumplimiento[16]="NO";
fi
#cumplimiento 1.1.10

#cumplimiento 1.1.11
if [[ `echo $ejecutar17 | grep '^/dev/[A-Za-z0-9]'` ]] && [[ $ejecutar17 == *' on /var/log '* ]]; then
        cumplimiento[17]="SI";
else
        cumplimiento[17]="NO";
fi
#cumplimiento 1.1.11

#cumplimiento 1.1.12
if [[ `echo $ejecutar18 | grep '^/dev/[A-Za-z0-9]'` ]] && [[ $ejecutar18 == *' on /var/log/audit '* ]]; then
        cumplimiento[18]="SI";
else
        cumplimiento[18]="NO";
fi
#cumplimiento 1.1.12

#cumplimiento 1.1.13
if [[ `echo $ejecutar19 | grep '^/dev/[A-Za-z0-9]'` ]] && [[ $ejecutar19 == *' on /home '* ]]; then
        cumplimiento[19]="SI";
else
        cumplimiento[19]="NO";
fi
#cumplimiento 1.1.13

#cumplimiento 1.1.14
if [[ -n $ejecutar20 ]] && [[ $ejecutar20 == *'nodev'* ]]; then
        cumplimiento[20]="SI";
elif [[ -z $ejecutar20 ]]; then
        cumplimiento[20]="NO";
else
        cumplimiento[20]="NO";
fi
#cumplimiento 1.1.14

#cumplimiento 1.1.15
if [[ $ejecutar21 == *'nodev'* ]]; then
        cumplimiento[21]="SI";
else
        cumplimiento[21]="NO";
fi
#cumplimiento 1.1.15

#cumplimiento 1.1.16
if [[ $ejecutar22 == *'nosuid'* ]]; then
        cumplimiento[22]="SI";
else
        cumplimiento[22]="NO";
fi
#cumplimiento 1.1.16

#cumplimiento 1.1.17
if [[ $ejecutar23 == *'noexec'* ]]; then
        cumplimiento[23]="SI";
else
        cumplimiento[23]="NO";
fi
#cumplimiento 1.1.17

#cumplimiento 1.1.18
if [[ -z $ejecutar24 ]]
then
   cumplimiento[24]="SI";
else
   cumplimiento[24]="NO";
fi
#cumplimiento 1.1.18

#cumplimiento 1.1.19
if [[ $ejecutar25 == *0:off* ]] && [[ $ejecutar25 == *1:off* ]] && [[ $ejecutar25 == *2:off* ]] && [[ $ejecutar25 == *3:off* ]] && [[ $ejecutar25 == *4:off* ]] && [[ $ejecutar25 == *5:off* ]]
then
        cumplimiento[25]="SI";
elif [[ -z $ejecutar25 ]];then
        cumplimiento[25]="SI";
else
        cumplimiento[25]="NO";
fi
#cumplimiento 1.1.19

#cumplimiento 1.2.1
cumplimiento[26]=$textoNoValidado;

#cumplimiento 1.2.2
cumplimiento[27]=$textoNoValidado;

#cumplimiento 1.2.3
if [[ $(grep ^gpgcheck /etc/yum.conf) == *gpgcheck=1* ]]
then
        gpgcheck="SI";
else
        gpgcheck="NO";
fi
gpgcheckcontar=0
for a in $(grep ^gpgcheck /etc/yum.repos.d/*);do
        if [[ $a == *'gpgcheck=1'* ]];then
                gpgcheckcontar=gpgcheckcontar+1
        fi
done
if [[ $gpgcheck == "SI" ]] && [[ $gpgcheckcontar == 0 ]];then
        cumplimiento[28]="SI"
else
        cumplimiento[28]="NO"
fi
#cumplimiento 1.2.3

#cumplimiento 1.3.1
if [[ `echo $ejecutar29 | grep '^aide'` ]]; then
        cumplimiento[29]="SI"
else
        cumplimiento[29]="NO"
fi
#cumplimiento 1.3.1

#cumplimiento 1.3.2
cumplimiento[30]=$textoNoValidado;

#cumplimiento 1.4.1
trimejecutar31=$(echo $ejecutar31 | tr -d '[[:space:]]')
if [[ $trimejecutar31 == *'600'* ]] && [[ $trimejecutar31 == *'Uid:(0/root)'* ]] && [[ $trimejecutar31 == *'Gid:(0/root)'* ]];then
        cumplimiento[31]="SI";
else
        cumplimiento[31]="NO";
fi
#cumplimiento 1.4.1

#cumplimiento 1.4.2
if [[ $ejecutar32 == '*SINGLE=/sbin/sulogin*' ]];then
        cumplimiento[32]="SI";
else
        cumplimiento[32]="NO";
fi
#cumplimiento 1.4.2

#cumplimiento 1.4.3
if [[ $ejecutar33 == *'PROMPT=no'* ]];then
        cumplimiento[33]="SI";
else
        cumplimiento[33]="NO";
fi
#cumplimiento 1.4.3

#cumplimiento 1.5.1
Hard1=$(grep "hard core" /etc/security/limits.conf /etc/security/limits.d/*)
Hard2=$(sysctl fs.suid_dumpable)
Hard3=$(grep "fs\.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)

if [[ $Hard1 == *'* hard core 0'* ]] && [[ $Hard2 == *'fs.suid_dumpable = 0'* ]] && [[ $Hard3 == *'fs.suid_dumpable = 0'* ]] ;then
        cumplimiento[34]="SI";
else
        cumplimiento[34]="NO";
fi
#cumplimiento 1.5.1

#cumplimiento 1.5.2
if [[ $ejecutar35 == *'NX (Execute Disable) protection: active'* ]]; then
        cumplimiento[35]="SI";
else
        cumplimiento[35]="NO";
fi
#cumplimiento 1.5.2

#cumplimiento 1.5.3
rand1=$(sysctl kernel.randomize_va_space)
rand2=$(grep "kernel\.randomize_va_space" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $rand1 == *'kernel.randomize_va_space = 2'* ]] && [[ $rand2 == *'kernel.randomize_va_space = 2'* ]]; then
        cumplimiento[36]="SI";
else
        cumplimiento[36]="NO";
fi
#cumplimiento 1.5.3

#cumplimiento 1.5.4
if [[ $ejecutar37 == *'package prelink is not installed'* ]];then
        cumplimiento[37]="SI";
else
        cumplimiento[37]="NO";
fi
#cumplimiento 1.5.4

#cumplimiento 1.6.1.1
if [[ $ejecutar38 == *'selinux=0'* ]] || [[ $ejecutar38 == *'enforcing=0'* ]];then
        cumplimiento[38]="NO";
else
        cumplimiento[38]="SI";
fi

#cumplimiento 1.6.1.2
SELinux1=$(grep SELINUX=enforcing /etc/selinux/config)
SELinux2=$(sestatus | grep "SELinux status" | tr -d '[[:space:]]')
SELinux3=$(sestatus | grep "Current mode" | tr -d '[[:space:]]')
SELinux4=$(sestatus | grep "Mode from config file" | tr -d '[[:space:]]')

if [[ $SELinux1 == *'SELINUX=enforcing'* ]] && [[ $SELinux2 == *'SELinuxstatus:enabled'* ]] && [[ $SELinux3 == *'Currentmode:enforcing'* ]] && [[ $SELinux4 == *'Modefromconfigfile:enforcing'* ]];then
        cumplimiento[39]="SI";
else
        cumplimiento[39]="NO";
fi
#cumplimiento 1.6.1.2

#cumplimiento 1.6.1.3
policy1=$(grep SELINUXTYPE=targeted /etc/selinux/config)
policy2=$(sestatus | grep "Policy from config file" | tr -d '[[:space:]]')

if [[ $policy1 == *'SELINUXTYPE=targeted'* ]] && [[ $policy2 == *'Policyfromconfigfile:targeted'* ]] ; then
        cumplimiento[40]="SI";
else
        cumplimiento[40]="NO";
fi
#cumplimiento 1.6.1.3

#cumplimiento 1.6.1.4
if [[ $ejecutar41 == *'package setroubleshoot is not installed'* ]]; then
        cumplimiento[41]="SI";
else
        cumplimiento[41]="NO";
fi
#cumplimiento 1.6.1.4

#cumplimiento 1.6.1.5
if [[ $ejecutar42 == *'package mcstrans is not installed'* ]]; then
        cumplimiento[42]="SI";
else
        cumplimiento[42]="NO";
fi
#cumplimiento 1.6.1.5

#cumplimiento 1.6.1.6
if [[ -z $ejecutar43 ]]; then #no tiene resultados
        cumplimiento[43]="SI";
else
        cumplimiento[43]="NO";
fi
#cumplimiento 1.6.1.6

#cumplimiento 1.6.2
if [[ `echo $ejecutar44 | grep '^libselinux-'` ]];then
        cumplimiento[44]="SI";
else
        cumplimiento[44]="NO";
fi
#cumplimiento 1.6.2

#cumplimiento 1.7.1.1
Warning1=$(egrep '(\\v|\\r|\\m|\\s)' /etc/motd)
if [[ -z $Warning1 ]];then
        cumplimiento[45]="SI";
else
        cumplimiento[45]="NO";
fi
#cumplimiento 1.7.1.1

#cumplimiento 1.7.1.2
banner=$(egrep '(\\v|\\r|\\m|\\s)' /etc/issue)
if [[ -z $banner  ]];then
        cumplimiento[46]="SI";
else
        cumplimiento[46]="NO";
fi
#cumplimiento 1.7.1.2

#cumplimiento 1.7.1.3
remoteLogin=$(egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net)
if [[ -z $remoteLogin ]]; then
        cumplimiento[47]="SI";
else
        cumplimiento[47]="NO";
fi
#cumplimiento 1.7.1.3

#cumplimiento 1.7.1.4
motd=$(stat /etc/motd | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $motd == *'644'* ]] && [[ $motd == *'Uid:(0/root)'* ]] && [[ $motd == *'Gid:(0/root)'* ]]; then
        cumplimiento[48]="SI";
else
        cumplimiento[48]="NO";
fi
#cumplimiento 1.7.1.4

#cumplimiento 1.7.1.5
issue=$(stat /etc/issue | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $issue == *'644'* ]] && [[ $issue == *'Uid:(0/root)'* ]] && [[ $issue == *'Gid:(0/root)'* ]]; then
        cumplimiento[49]="SI";
else
        cumplimiento[49]="NO";
fi
#cumplimiento 1.7.1.5

#cumplimiento 1.7.1.6
issuenet=$(stat /etc/issue.net | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $issuenet == *'644'* ]] && [[ $issuenet == *'Uid:(0/root)'* ]] && [[ $issuenet == *'Gid:(0/root)'* ]];then
        cumplimiento[50]="SI";
else
        cumplimiento[50]="NO";
fi
#cumplimiento 1.7.1.6

#cumplimiento 1.8
if [[ `echo $ejecutar51 | grep '[0-9][.:][0-9]'` ]];then #si tiene numeros de versiones 5.25.55, es porque tiene un software por actualizar
    cumplimiento[51]="NO";
else
    cumplimiento[51]="SI";
fi
#cumplimiento 1.8

#cumplimiento 2.1.1
trimejecutar52=$(echo $ejecutar52 | tr -d '[[:space:]]')
if [[ $trimejecutar52 == *'chargen-dgram:off'* ]] && [[ $trimejecutar52 == *'chargen-stream:off'* ]];then
        cumplimiento[52]="SI";
else
        cumplimiento[52]="NO";
fi
#cumplimiento 2.1.1

#cumplimiento 2.1.2
trimejecutar53=$(echo $ejecutar53 | tr -d '[[:space:]]')
if [[ $trimejecutar53 == *'daytime-dgram:off'* ]] && [[ $trimejecutar53 == *'daytime-stream:off'* ]]; then
        cumplimiento[53]="SI";
else
        cumplimiento[53]="NO";
fi
#cumplimiento 2.1.2

#cumplimiento 2.1.3
trimejecutar54=$(echo $ejecutar54 | tr -d '[[:space:]]')
if [[ $trimejecutar54 == *'discard-dgram:off'* ]] && [[ $trimejecutar54 == *'discard-stream:off'* ]]; then
        cumplimiento[54]="SI";
else
        cumplimiento[54]="NO";
fi

#cumplimiento 2.1.4
trimejecutar55=$(echo $ejecutar55 | tr -d '[[:space:]]')
if [[ $trimejecutar55 == *'echo-dgram:off'* ]] && [[ $trimejecutar55 == *'echo-stream:off'* ]]; then
        cumplimiento[55]="SI";
else
        cumplimiento[55]="NO";
fi
#cumplimiento 2.1.4

#cumplimiento 2.1.5
trimejecutar56=$(echo $ejecutar56 | tr -d '[[:space:]]')
if [[ $trimejecutar56 == *'time-dgram:off'* ]] && [[ $trimejecutar56 == *'time-stream:off'* ]]; then
        cumplimiento[56]="SI";
else
        cumplimiento[56]="NO";
fi
#cumplimiento 2.1.5

#cumplimiento 2.1.6
trimejecutar57=$(echo $ejecutar57 | tr -d '[[:space:]]')
if [[ $trimejecutar57 == *'rexec:off'* ]] && [[ $trimejecutar57 == *'rlogin:off'* ]] && [[ $trimejecutar57 == *'rsh:off'* ]]; then
        cumplimiento[57]="SI";
else
        cumplimiento[57]="NO";
fi
#cumplimiento 2.1.6

#cumplimiento 2.1.7
trimejecutar58=$(echo $ejecutar58 | tr -d '[[:space:]]')
if [[ $trimejecutar58 == *'talk:off'* ]]; then
        cumplimiento[58]="SI";
else
        cumplimiento[58]="NO";
fi
#cumplimiento 2.1.7

#cumplimiento 2.1.8
trimejecutar59=$(echo $ejecutar59 | tr -d '[[:space:]]')
if [[ $trimejecutar59 == *'telnet:off'* ]]; then
        cumplimiento[59]="SI";
else
        cumplimiento[59]="NO";
fi
#cumplimiento 2.1.8

#cumplimiento 2.1.9
trimejecutar60=$(echo $ejecutar60 | tr -d '[[:space:]]')
if [[ $trimejecutar60 == *'tftp:off'* ]]; then
        cumplimiento[60]="SI";
else
        cumplimiento[60]="NO";
fi
#cumplimiento 2.1.9

#cumplimiento 2.1.10
trimejecutar61=$(echo $ejecutar61 | tr -d '[[:space:]]')
if [[ $trimejecutar61 == *'rsync:off'* ]]; then
        cumplimiento[61]="SI";
else
        cumplimiento[61]="NO";
fi
#cumplimiento 2.1.10

#cumplimiento 2.1.11
if [[ $ejecutar62 == *0:off* ]] && [[ $ejecutar62 == *1:off* ]] && [[ $ejecutar62 == *2:off* ]] && [[ $ejecutar62 == *3:off* ]] && [[ $ejecutar62 == *4:off* ]] && [[ $ejecutar62 == *5:off* ]] && [[ $ejecutar62 == *6:off* ]]
then
        cumplimiento[62]="SI";
elif [[ -z $ejecutar62 ]];then
        cumplimiento[62]="SI";
else
        cumplimiento[62]="NO";
fi
#cumplimiento 2.1.11

#cumplimiento 2.2.1.1
ntp=$(rpm -q ntp)
chrony=$(rpm -q chrony)
if [[ `echo $ntp | grep '^ntp'` ]] && [[ `echo $chrony | grep '^chrony'` ]]; then
        cumplimiento[63]="SI";
else
        cumplimiento[63]="NO";
fi
#cumplimiento 2.2.1.1

#cumplimiento 2.2.1.2
cumplimiento[64]=$textoNoValidado;

#cumplimiento 2.2.1.3
cumplimiento[65]=$textoNoValidado;

#cumplimiento 2.2.2
if [[ -z $ejecutar66 ]];then
        cumplimiento[66]="SI";
else
        cumplimiento[66]="NO";
fi
#cumplimiento 2.2.2

#cumplimiento 2.2.3
if [[ $ejecutar67 == *0:off* ]] && [[ $ejecutar67 == *1:off* ]] && [[ $ejecutar67 == *2:off* ]] && [[ $ejecutar67 == *3:off* ]] && [[ $ejecutar67 == *4:off* ]] && [[ $ejecutar67 == *5:off* ]] && [[ $ejecutar67 == *6:off* ]]
then
        cumplimiento[67]="SI";
elif [[ -z $ejecutar67 ]];then
        cumplimiento[67]="SI";
else
        cumplimiento[67]="NO";
fi
#cumplimiento 2.2.3

#cumplimiento 2.2.4
if [[ $ejecutar68 == *0:off* ]] && [[ $ejecutar68 == *1:off* ]] && [[ $ejecutar68 == *2:off* ]] && [[ $ejecutar68 == *3:off* ]] && [[ $ejecutar68 == *4:off* ]] && [[ $ejecutar68 == *5:off* ]] && [[ $ejecutar68 == *6:off* ]]
then
        cumplimiento[68]="SI";
elif [[ -z $ejecutar68 ]];then
        cumplimiento[68]="SI";
else
        cumplimiento[68]="NO";
fi
#cumplimiento 2.2.4

#cumplimiento 2.2.5
if [[ $ejecutar69 == *0:off* ]] && [[ $ejecutar69 == *1:off* ]] && [[ $ejecutar69 == *2:off* ]] && [[ $ejecutar69 == *3:off* ]] && [[ $ejecutar69 == *4:off* ]] && [[ $ejecutar69 == *5:off* ]] && [[ $ejecutar69 == *6:off* ]]
then
        cumplimiento[69]="SI";
elif [[ -z $ejecutar69 ]];then
        cumplimiento[69]="SI";
else
        cumplimiento[69]="NO";
fi
#cumplimiento 2.2.5

#cumplimiento 2.2.6
if [[ $ejecutar70 == *0:off* ]] && [[ $ejecutar70 == *1:off* ]] && [[ $ejecutar70 == *2:off* ]] && [[ $ejecutar70 == *3:off* ]] && [[ $ejecutar70 == *4:off* ]] && [[ $ejecutar70 == *5:off* ]] && [[ $ejecutar70 == *6:off* ]]
then
        cumplimiento[70]="SI";
elif [[ -z $ejecutar70 ]];then
        cumplimiento[70]="SI";
else
        cumplimiento[70]="NO";
fi
#cumplimiento 2.2.6

#cumplimiento 2.2.7
nfs=$(chkconfig --list nfs)
rpcbind=$(chkconfig --list rpcbind)
if [[ $nfs == *0:off* ]] && [[ $nfs == *1:off* ]] && [[ $nfs == *2:off* ]] && [[ $nfs == *3:off* ]] && [[ $nfs == *4:off* ]] && [[ $nfs == *5:off* ]] && [[ $nfs == *6:off* ]]
then
        Contardornfs=1;
elif [[ -z $nfs ]];then
        Contardornfs=1;
else
        Contardornfs=0;
fi

#if [[ $rpcbind == *0:off* ]] && [[ $rpcbind == *1:off* ]] && [[ $rpcbind == *2:off* ]] && [[ $rpcbind == *3:off* ]] && [[ $rpcbind == *4:off* ]] && [[ $rpcbind == *5:off*]] && [[ $rpcbind == *6:off* ]]
#then
#        Contardorrpcbind=1;
#elif [[ -z $rpcbind ]];then
#        Contardorrpcbind=1;
#else
#        Contardorrpcbind=0;
#fi

let sumanfsrpcbind=$Contardornfs+$Contardorrpcbind
if [[ $sumanfsrpcbind -eq 2 ]];then
        cumplimiento[71]="SI";
else
        cumplimiento[71]="NO";
fi
#cumplimiento 2.2.7

#cumplimiento 2.2.8
if [[ $ejecutar72 == *0:off* ]] && [[ $ejecutar72 == *1:off* ]] && [[ $ejecutar72 == *2:off* ]] && [[ $ejecutar72 == *3:off* ]] && [[ $ejecutar72 == *4:off* ]] && [[ $ejecutar72 == *5:off* ]] && [[ $ejecutar72 == *6:off* ]]
then
        cumplimiento[72]="SI";
elif [[ -z $ejecutar72 ]];then
        cumplimiento[72]="SI";
else
        cumplimiento[72]="NO";
fi
#cumplimiento 2.2.8

#cumplimiento 2.2.9
if [[ $ejecutar73 == *0:off* ]] && [[ $ejecutar73 == *1:off* ]] && [[ $ejecutar73 == *2:off* ]] && [[ $ejecutar73 == *3:off* ]] && [[ $ejecutar73 == *4:off* ]] && [[ $ejecutar73 == *5:off* ]] && [[ $ejecutar73 == *6:off* ]]
then
        cumplimiento[73]="SI";
elif [[ -z $ejecutar73 ]];then
        cumplimiento[73]="SI";
else
        cumplimiento[73]="NO";
fi
#cumplimiento 2.2.9

#cumplimiento 2.2.10
if [[ $ejecutar74 == *0:off* ]] && [[ $ejecutar74 == *1:off* ]] && [[ $ejecutar74 == *2:off* ]] && [[ $ejecutar74 == *3:off* ]] && [[ $ejecutar74 == *4:off* ]] && [[ $ejecutar74 == *5:off* ]] && [[ $ejecutar74 == *6:off* ]]
then
        cumplimiento[74]="SI";
elif [[ -z $ejecutar74 ]];then
        cumplimiento[74]="SI";
else
        cumplimiento[74]="NO";
fi
#cumplimiento 2.2.10

#cumplimiento 2.2.11
if [[ $ejecutar75 == *0:off* ]] && [[ $ejecutar75 == *1:off* ]] && [[ $ejecutar75 == *2:off* ]] && [[ $ejecutar75 == *3:off* ]] && [[ $ejecutar75 == *4:off* ]] && [[ $ejecutar75 == *5:off* ]] && [[ $ejecutar75 == *6:off* ]]
then
        cumplimiento[75]="SI";
elif [[ -z $ejecutar75 ]];then
        cumplimiento[75]="SI";
else
        cumplimiento[75]="NO";
fi
#cumplimiento 2.2.11

#cumplimiento 2.2.12
if [[ $ejecutar76 == *0:off* ]] && [[ $ejecutar76 == *1:off* ]] && [[ $ejecutar76 == *2:off* ]] && [[ $ejecutar76 == *3:off* ]] && [[ $ejecutar76 == *4:off* ]] && [[ $ejecutar76 == *5:off* ]] && [[ $ejecutar76 == *6:off* ]]
then
        cumplimiento[76]="SI";
elif [[ -z $ejecutar76 ]];then
        cumplimiento[76]="SI";
else
        cumplimiento[76]="NO";
fi
#cumplimiento 2.2.12

#cumplimiento 2.2.13
if [[ $ejecutar77 == *0:off* ]] && [[ $ejecutar77 == *1:off* ]] && [[ $ejecutar77 == *2:off* ]] && [[ $ejecutar77 == *3:off* ]] && [[ $ejecutar77 == *4:off* ]] && [[ $ejecutar77 == *5:off* ]] && [[ $ejecutar77 == *6:off* ]]
then
        cumplimiento[77]="SI";
elif [[ -z $ejecutar77 ]];then
        cumplimiento[77]="SI";
else
        cumplimiento[77]="NO";
fi
#cumplimiento 2.2.13

#cumplimiento 2.2.14
if [[ $ejecutar78 == *0:off* ]] && [[ $ejecutar78 == *1:off* ]] && [[ $ejecutar78 == *2:off* ]] && [[ $ejecutar78 == *3:off* ]] && [[ $ejecutar78 == *4:off* ]] && [[ $ejecutar78 == *5:off* ]] && [[ $ejecutar78 == *6:off* ]]
then
        cumplimiento[78]="SI";
elif [[ -z $ejecutar78 ]];then
        cumplimiento[78]="SI";
else
        cumplimiento[78]="NO";
fi
#cumplimiento 2.2.14

#cumplimiento 2.2.15
if [[ $ejecutar79 == *'127.0.0.1:'* ]];then #se entiende que debe de tener el ip local.
        cumplimiento[79]="SI";
else
        cumplimiento[79]="NO";
fi
#cumplimiento 2.2.15

#cumplimiento 2.2.16
if [[ $ejecutar80 == *0:off* ]] && [[ $ejecutar80 == *1:off* ]] && [[ $ejecutar80 == *2:off* ]] && [[ $ejecutar80 == *3:off* ]] && [[ $ejecutar80 == *4:off* ]] && [[ $ejecutar80 == *5:off* ]] && [[ $ejecutar80 == *6:off* ]]
then
        cumplimiento[80]="SI";
elif [[ -z $ejecutar80 ]];then
        cumplimiento[80]="SI";
else
        cumplimiento[80]="NO";
fi
#cumplimiento 2.2.16

#cumplimiento 2.3.1
if [[ $ejecutar81 == *'package ypbind is not installed'* ]]; then
        cumplimiento[81]="SI";
else
        cumplimiento[81]="NO";
fi
#cumplimiento 2.3.1

#cumplimiento 2.3.2
if [[ $ejecutar82 == *'package rsh is not installed'* ]];then
        cumplimiento[82]="SI";
else
        cumplimiento[82]="NO";
fi
#cumplimiento 2.3.2

#cumplimiento 2.3.3
if [[ $ejecutar83 == *'package talk is not installed'* ]];then
        cumplimiento[83]="SI";
else
        cumplimiento[83]="NO";
fi
#cumplimiento 2.3.3

#cumplimiento 2.3.4
if [[ $ejecutar84 == *'package telnet is not installed'* ]];then
        cumplimiento[84]="SI";
else
        cumplimiento[84]="NO";
fi
#cumplimiento 2.3.4

#cumplimiento 2.3.5
if [[ $ejecutar85 == *'package openldap-clients is not installed'* ]];then
        cumplimiento[85]="SI";
else
        cumplimiento[85]="NO";
fi
#cumplimiento 2.3.5

#cumplimiento 3.1.1
forwarding1=$(sysctl net.ipv4.ip_forward)
forwarding2=$(grep "net\.ipv4\.ip_forward" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $forwarding1 == *'net.ipv4.ip_forward = 0'* ]] && [[ $forwarding2 == *'net.ipv4.ip_forward = 0'* ]];then
        cumplimiento[86]="SI";
else
        cumplimiento[86]="NO";
fi
#cumplimiento 3.1.1

#cumplimiento 3.1.2
redirect1=$(sysctl net.ipv4.conf.all.send_redirects)
redirect2=$(sysctl net.ipv4.conf.default.send_redirects)
redirect3=$(grep "net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
redirect4=$(grep "net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $redirect1 == *'net.ipv4.conf.all.send_redirects = 0'* ]] && [[ $redirect2 == *'net.ipv4.conf.default.send_redirects = 0'* ]] && [[ $redirect3 == *'net.ipv4.conf.all.send_redirects = 0'* ]] && [[ $redirect4 == *'net.ipv4.conf.default.send_redirects= 0'* ]]; then
        cumplimiento[87]="SI";
else
        cumplimiento[87]="NO";
fi
#cumplimiento 3.1.2

#cumplimiento 3.2.1
routed1=$(sysctl net.ipv4.conf.all.accept_source_route)
routed2=$(sysctl net.ipv4.conf.default.accept_source_route)
routed3=$(grep "net\.ipv4\.conf\.all\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
routed4=$(grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $routed1 == *'net.ipv4.conf.all.accept_source_route = 0'* ]] && [[ $routed2 == *'net.ipv4.conf.default.accept_source_route = 0'* ]] && [[ $routed3 == *'net.ipv4.conf.all.accept_source_route= 0'* ]] && [[ $routed4 == *'net.ipv4.conf.default.accept_source_route= 0'* ]];then
        cumplimiento[88]="SI";
else
        cumplimiento[88]="NO";
fi
#cumplimiento 3.2.1

#cumplimiento 3.2.2
ICMP1=$(sysctl net.ipv4.conf.all.accept_redirects)
ICMP2=$(sysctl net.ipv4.conf.default.accept_redirect)
ICMP3=$(grep "net\.ipv4\.conf\.all\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
ICMP4=$(grep "net\.ipv4\.conf\.default\.accept_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $ICMP1 == *'net.ipv4.conf.all.accept_redirects = 0'* ]] && [[ $ICMP2 == *'net.ipv4.conf.default.accept_redirects = 0'* ]] && [[ $ICMP3 == *'net.ipv4.conf.all.accept_redirects= 0'* ]] && [[ $ICMP4 == *'net.ipv4.conf.default.accept_redirects= 0'* ]]; then
        cumplimiento[89]="SI";
else
        cumplimiento[89]="NO";
fi
#cumplimiento 3.2.2

#cumplimiento 3.2.3
redirects1=$(sysctl net.ipv4.conf.all.secure_redirects)
redirects2=$(sysctl net.ipv4.conf.default.secure_redirects)
redirects3=$(grep "net\.ipv4\.conf\.all\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
redirects4=$(grep "net\.ipv4\.conf\.default\.secure_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $redirects1 == *'net.ipv4.conf.all.secure_redirects = 0'* ]] && [[ $redirects2 == *'net.ipv4.conf.default.secure_redirects = 0'* ]] && [[ $redirects3 == *'net.ipv4.conf.all.secure_redirects= 0'* ]] && [[ $redirects4 == *'net.ipv4.conf.default.secure_redirects= 0'* ]];then
        cumplimiento[90]="SI";
else
        cumplimiento[90]="NO";
fi
#cumplimiento 3.2.3

#cumplimiento 3.2.4
packets1=$(sysctl net.ipv4.conf.all.log_martians)
packets2=$(sysctl net.ipv4.conf.default.log_martians)
packets3=$(grep "net\.ipv4\.conf\.all\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*)
packets4=$(grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $packets1 == *'net.ipv4.conf.all.log_martians = 1'* ]] &&  [[ $packets2 == *'net.ipv4.conf.default.log_martians = 1'* ]] && [[ $packets3 == *'net.ipv4.conf.all.log_martians = 1'* ]] && [[ $packets4 == *'net.ipv4.conf.default.log_martians = 1'* ]]; then
        cumplimiento[91]="SI";
else
        cumplimiento[91]="NO";
fi
#cumplimiento 3.2.4

#cumplimiento 3.2.5
broadcast1=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts)
broadcast2=$(grep "net\.ipv4\.icmp_echo_ignore_broadcasts" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $broadcast1 == *'net.ipv4.icmp_echo_ignore_broadcasts = 1'* ]] && [[ $broadcast2 == *'net.ipv4.icmp_echo_ignore_broadcasts = 1'* ]];then
        cumplimiento[92]="SI";
else
        cumplimiento[92]="NO";
fi
#cumplimiento 3.2.5

#cumplimiento 3.2.6
bogus1=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses)
bogus2=$(grep "net\.ipv4\.icmp_ignore_bogus_error_responses" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $bogus1 == *'net.ipv4.icmp_ignore_bogus_error_responses = 1'* ]] && [[ $bogus2 == *'net.ipv4.icmp_ignore_bogus_error_responses = 1'* ]];then
        cumplimiento[93]="SI";
else
        cumplimiento[93]="NO";
fi
#cumplimiento 3.2.6

#cumplimiento 3.2.7
Path1=$(sysctl net.ipv4.conf.all.rp_filter)
Path2=$(sysctl net.ipv4.conf.default.rp_filter)
Path3=$(grep "net\.ipv4\.conf\.all\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*)
Path4=$(grep "net\.ipv4\.conf\.default\.rp_filter" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $Path1 == *'net.ipv4.conf.all.rp_filter = 1'* ]] && [[ $Path2 == *'net.ipv4.conf.default.rp_filter = 1'* ]] && [[ $Path3 == *'net.ipv4.conf.all.rp_filter = 1'* ]] && [[ $Path4 == *'net.ipv4.conf.default.rp_filter = 1'* ]]; then
        cumplimiento[94]="SI";
else
        cumplimiento[94]="NO";
fi
#cumplimiento 3.2.7

#cumplimiento 3.2.8
Cookies1=$(sysctl net.ipv4.tcp_syncookies)
Cookies2=$(grep "net\.ipv4\.tcp_syncookies" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $Cookies1 == *'net.ipv4.tcp_syncookies = 1'* ]] && [[ $Cookies2 == *'net.ipv4.tcp_syncookies = 1'* ]];then
        cumplimiento[95]="SI";
else
        cumplimiento[95]="NO";
fi
#cumplimiento 3.2.8

#cumplimiento 3.3.1
router1=$(sysctl net.ipv6.conf.all.accept_ra)
router2=$(sysctl net.ipv6.conf.default.accept_ra)
router3=$(grep "net\.ipv6\.conf\.all\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*)
router4=$(grep "net\.ipv6\.conf\.default\.accept_ra" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $router1 == *'net.ipv6.conf.all.accept_ra = 0'* ]] && [[ $router2 == *'net.ipv6.conf.default.accept_ra = 0'* ]] && [[ $router3 == *'net.ipv6.conf.all.accept_ra = 0'* ]] && [[ $router4 == *'net.ipv6.conf.default.accept_ra = 0'* ]];then
        cumplimiento[96]="SI";
else
        cumplimiento[96]="NO";
fi
#cumplimiento 3.3.1

#cumplimiento 3.3.2
IPv6redirects1=$(sysctl net.ipv6.conf.all.accept_redirects)
IPv6redirects2=$(sysctl net.ipv6.conf.default.accept_redirects)
IPv6redirects3=$(grep "net\.ipv6\.conf\.all\.accept_redirect" /etc/sysctl.conf /etc/sysctl.d/*)
IPv6redirects4=$(grep "net\.ipv6\.conf\.default\.accept_redirect" /etc/sysctl.conf /etc/sysctl.d/*)
if [[ $IPv6redirects1 == *'net.ipv6.conf.all.accept_redirect = 0'* ]] && [[ $IPv6redirects2 == *'net.ipv6.conf.default.accept_redirect = 0'* ]] && [[ $IPv6redirects3 == *'net.ipv6.conf.all.accept_redirect = 0'* ]] && [[ $IPv6redirects4 == *'net.ipv6.conf.default.accept_redirect = 0'* ]];then
        cumplimiento[97]="SI";
else
        cumplimiento[97]="NO";
fi
#cumplimiento 3.3.2

#cumplimiento 3.3.3
if [[ $ejecutar98 == *'ipv6.disable=1'* ]]; then
        cumplimiento[98]="SI";
else
        cumplimiento[98]="NO";
fi
#cumplimiento 3.3.3

#cumplimiento 3.4.1
Wrappers1=$(rpm -q tcp_wrappers)
Wrappers2=$(rpm -q tcp_wrappers-libs)
if [[ `echo $Wrappers1 | grep '^tcp_wrappers-'` ]] && [[ `echo $Wrappers2 | grep '^tcp_wrappers-libs-'` ]] ; then
        cumplimiento[99]="SI";
else
        cumplimiento[99]="NO";
fi
#cumplimiento 3.4.1

#cumplimiento 3.4.2
cumplimiento[100]=$textoNoValidado;

#cumplimiento 3.4.3
if [[ $ejecutar101 == *'ALL: ALL'* ]];then
        cumplimiento[101]="SI";
else
        cumplimiento[101]="NO";
fi
#cumplimiento 3.4.3

#cumplimiento 3.4.4
trimejecutar102=$(echo $ejecutar102 | tr -d '[[:space:]]')
if [[ $trimejecutar102 == *'644'* ]] && [[ $trimejecutar102 == *'Uid:(0/root)'* ]] && [[ $trimejecutar102 == *'Gid:(0/root)'* ]];then
        cumplimiento[102]="SI";
else
        cumplimiento[102]="NO";
fi
#cumplimiento 3.4.4

#cumplimiento 3.4.5
trimejecutar103=$(echo $ejecutar103 | tr -d '[[:space:]]')
if [[ $trimejecutar103 == *'644'* ]] && [[ $trimejecutar103 == *'Uid:(0/root)'* ]] && [[ $trimejecutar103 == *'Gid:(0/root)'* ]];then
        cumplimiento[103]="SI";
else
        cumplimiento[103]="NO";
fi
#cumplimiento 3.4.5

#cumplimiento 3.5.1
cumplimiento[104]=$textoNoValidado;

#cumplimiento 3.5.2
cumplimiento[105]=$textoNoValidado;

#cumplimiento 3.5.3
cumplimiento[106]=$textoNoValidado;

#cumplimiento 3.5.4
cumplimiento[107]=$textoNoValidado;

#cumplimiento 3.6.1
if [[ `echo $ejecutar108 | grep '^iptables-'` ]];then
        cumplimiento[108]="SI";
else
        cumplimiento[108]="NO";
fi
#cumplimiento 3.6.1

#cumplimiento 3.6.2
if [[ $ejecutar109 == *'Chain INPUT (policy DROP)'* ]] || [[ $ejecutar109 == *'Chain INPUT (policy REJECT)'* ]];then
        INPUT=1;
else
        INPUT=0;
fi

if [[ $ejecutar109 == *'Chain FORWARD (policy DROP)'* ]] || [[ $ejecutar109 == *'Chain FORWARD (policy REJECT)'* ]];then
        DROP=1;
else
        DROP=0;
fi

if [[ $ejecutar109 == *'Chain OUTPUT (policy DROP)'* ]] || [[ $ejecutar109 == *'Chain OUTPUT (policy REJECT)'* ]];then
        OUTPUT=1;
else
        OUTPUT=0;
fi

let sumadenyfirewall=$INPUT+$DROP+$OUTPUT
if [[ $sumadenyfirewall -eq 3 ]] ;then
        cumplimiento[109]="SI";
else
        cumplimiento[109]="NO";
fi
#cumplimiento 3.6.2

#cumplimiento 3.6.3
trimloopbacktraffic1=$(iptables -L INPUT -v -n | tr -d '[[:space:]]')
trimloopbacktraffic2=$(iptables -L OUTPUT -v -n | tr -d '[[:space:]]')
if [[ $trimloopbacktraffic1 == *'ACCEPTall--lo*0.0.0.0/00.0.0.0/0'* ]] && [[ $trimloopbacktraffic1 == *'DROPall--**127.0.0.0/80.0.0.0/0'* ]];then
        contadortraffic1=1;
else
        contadortraffic1=0
fi

if [[ $trimloopbacktraffic2 == *'ACCEPTall--*lo0.0.0.0/00.0.0.0/'* ]];then
        contadortraffic2=1;
else
        contadortraffic2=0;
fi
let sumaloopbacktraffic=$contadortraffic1+$contadortraffic2
if [[ $sumaloopbacktraffic -eq 2 ]];then
        cumplimiento[110]="SI";
else
        cumplimiento[110]="NO";
fi
#cumplimiento 3.6.3

#cumplimiento 3.6.4
cumplimiento[111]=$textoNoValidado;

#cumplimiento 3.6.5
cumplimiento[112]=$textoNoValidado;

#cumplimiento 4.1.1.1
cumplimiento[113]=$textoNoValidado;

#cumplimiento 4.1.1.2
disabledaudit1=$(grep space_left_action /etc/audit/auditd.conf)
disabledaudit2=$(grep action_mail_acct /etc/audit/auditd.conf)
disabledaudit3=$(grep admin_space_left_action /etc/audit/auditd.conf)
if [[ $disabledaudit1 == *'space_left_action = email'* ]] && [[ $disabledaudit2 == *'action_mail_acct = root'* && $disabledaudit3 == *'admin_space_left_action = halt'* ]];then
        cumplimiento[114]="SI";
else
        cumplimiento[114]="NO";
fi
#cumplimiento 4.1.1.2

#cumplimiento 4.1.1.3
if [[ $ejecutar115 == *'max_log_file_action = keep_logs'* ]];then
        cumplimiento[115]="SI";
else
        cumplimiento[115]="NO";
fi
#cumplimiento 4.1.1.3

#cumplimiento 4.1.2
if [[ $ejecutar116 == *'2:on'* ]] && [[ $ejecutar116 == *'3:on'* ]] && [[ $ejecutar116 == *'4:on'* ]] && [[ $ejecutar116 == *'5:on'* ]];then
        cumplimiento[116]="SI";
else
        cumplimiento[116]="NO";
fi
#cumplimiento 4.1.2

#cumplimiento 4.1.3
if [[ $ejecutar117 == *'audit=1'* ]];then
        cumplimiento[117]="SI";
else
        cumplimiento[117]="NO";
fi
#cumplimiento 4.1.3

#cumplimiento 4.1.4
modifydate1=$(grep time-change /etc/audit/audit.rules)
modifydate2=$(auditctl -l | grep time-change)
if [[ $modifydate1 == *'-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change'* ]] && [[ $modifydate1 == *'-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change'* ]] && [[ $modifydate1 == *'-a always,exit -F arch=b64 -S clock_settime -k time-change'* ]] && [[ $modifydate1 == *'-a always,exit -F arch=b32 -S clock_settime -k time-change'* ]] && [[ $modifydate1 == *'-w /etc/localtime -p wa -k time-change'* ]];then
        contadormodifydate1=1;
else
        contadormodifydate1=0;
fi

if [[ $modifydate2 == *'-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change'* ]] && [[ $modifydate2 == *'-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change'* ]] && [[ $modifydate2 == *'-a always,exit -F arch=b64 -S clock_settime -k time-change'* ]] && [[ $modifydate2 == *'-a always,exit -F arch=b32 -S clock_settime -k time-change'* ]] && [[ $modifydate2 == *'-w /etc/localtime -p wa -k time-change'* ]] ;then
        contadormodifydate2=1;
else
        contadormodifydate2=0;
fi

let sumamodifydate=$contadormodifydate1+$contadormodifydate2
if [[ $sumamodifydate -eq 2 ]];then
        cumplimiento[118]="SI";
else
        cumplimiento[118]="NO";
fi
#cumplimiento 4.1.4

#cumplimiento 4.1.5
modifyuser1=$(grep identity /etc/audit/audit.rules)
modifyuser2=$(auditctl -l | grep identity)
if [[ $modifyuser1 == *'-w /etc/group -p wa -k identity'* ]] && [[ $modifyuser1 == *'-w /etc/passwd -p wa -k identity'* ]] && [[ $modifyuser1 == *'-w /etc/gshadow -p wa -k identity'* ]] && [[ $modifyuser1 == *'-w /etc/shadow -p wa -k identity'* ]] && [[ $modifyuser1 == *'-w /etc/security/opasswd -p wa -k identity'* ]] ;then
        contadormodifyuser1=1;
else
        contadormodifyuser1=0;
fi

if [[ $modifyuser2 == *'-w /etc/group -p wa -k identity'* ]] && [[ $modifyuser2 == *'-w /etc/passwd -p wa -k identity'* ]] && [[ $modifyuser2 == *'-w /etc/gshadow -p wa -k identity'* ]] && [[ $modifyuser2 == *'-w /etc/shadow -p wa -k identity'* ]] && [[ $modifyuser2 == *'-w /etc/security/opasswd -p wa -k identity'* ]];then
        contadormodifyuser2=1;
else
        contadormodifyuser2=0;
fi
let sumamodifyuser=$contadormodifyuser1+$contadormodifyuser2
if [[ $sumamodifyuser -eq 2 ]];then
        cumplimiento[119]="SI";
else
        cumplimiento[119]="NO";
fi
#cumplimiento 4.1.5

#cumplimiento 4.1.6
network1=$(grep system-locale /etc/audit/audit.rules)
network2=$(auditctl -l | grep system-locale)
if [[ $network1 == *'-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale'* ]] && [[ $network1 == *'-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale'* ]] && [[ $network1 == *'-w /etc/issue -p wa -k system-locale'* ]] && [[ $network1 == *'-w /etc/issue.net -p wa -k system-locale'* ]] && [[ $network1 == *'-w /etc/hosts -p wa -k system-locale'* ]] && [[ $network1 == *'-w /etc/sysconfig/network -p wa -k system-locale'* ]] && [[ $network1 == *'-w /etc/sysconfig/network-scripts/ -p wa -k system-locale'* ]];then
        contadornetwork1=1;
else
        contadornetwork1=0;
fi

if [[ $network2 == *'-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale'* ]] && [[ $network2 == *'-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale'* ]] && [[ $network2 == *'-w /etc/issue -p wa -k system-locale'* ]] && [[ $network2 == *'-w /etc/issue.net -p wa -k system-locale'* ]] && [[ $network2 == *'-w /etc/hosts -p wa -k system-locale'* ]] && [[ $network2 == *'-w /etc/sysconfig/network -p wa -k system-locale'* ]] && [[ $network2 == *'-w /etc/sysconfig/network-scripts/ -p wa -k system-locale'* ]];then
        contadornetwork2=1;
else
        contadornetwork2=0;
fi
let sumanetwork=$contadornetwork1+$contadornetwork2
if      [[ $sumanetwork -eq 2 ]];then
        cumplimiento[120]="SI";
else
        cumplimiento[120]="NO";
fi
#cumplimiento 4.1.6

#cumplimiento 4.1.7
if [[ $ejecutar121 == *'-w /etc/selinux/ -p wa -k MAC-policy'* ]] && [[ $ejecutar121 == *'-w /usr/share/selinux/ -p wa -k MAC-policy'* ]];then
        cumplimiento[121]="SI";
else
        cumplimiento[121]="NO";
fi
#cumplimiento 4.1.7

#cumplimiento 4.1.8
if [[ $ejecutar122 == *'-w /var/log/lastlog -p wa -k logins'* ]] && [[ $ejecutar122 == *'-w /var/run/faillock/ -p wa -k logins'* ]];then
        cumplimiento[122]="SI";
else
        cumplimiento[122]="NO";
fi
#cumplimiento 4.1.8

#cumplimiento 4.1.9
session1=$(grep session /etc/audit/audit.rules)
session2=$(auditctl -l | grep session)
if [[ $session1 == *'-w /var/run/utmp -p wa -k session'* ]] && [[ $session2 == *'-w /var/run/utmp -p wa -k session'* ]] ;then
        contadorgrupo1=1;
else
        contadorgrupo1=0;
fi

session3=$(grep logins /etc/audit/audit.rules)
session4=$(auditctl -l | grep logins)
if [[ $session3 == *'-w /var/log/wtmp -p wa -k logins'* ]] && [[ $session3 == *'-w /var/log/btmp -p wa -k logins'* ]] && [[ $session4 == *'-w /var/log/wtmp -p wa -k logins'* ]] && $session4 == *'-w /var/log/btmp -p wa -k logins'*;then
        contadorgrupo2=1;
else
        contadorgrupo2=0;
fi

let sumagrupos=$contadorgrupo1+$contadorgrupo2
if [[ $sumagrupos -eq 2 ]];then
        cumplimiento[123]="SI";
else
        cumplimiento[123]="NO";
fi
#cumplimiento 4.1.9

#cumplimiento 4.1.10
control1=$(grep perm_mod /etc/audit/audit.rules)
control2=$(auditctl -l | grep perm_mod)
if [[ $control1 == *'-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control1 == *'-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control1 == *'-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control1 == *'-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control1 == *'-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control1 == *'-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -Fauid>=500 -F auid!=4294967295 -k perm_mod'* ]];then
        contarcontrol1=1;
else
        contarcontrol1=0;
fi

if [[ $control2 == *'-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control2 == *'-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control2 == *'-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control2 == *'-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control2 == *'-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod'* ]] && [[ $control2 == *'-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -Fauid>=500 -F auid!=4294967295 -k perm_mod '* ]];then
        contarcontrol2=1;
else
        contarcontrol2=0;
fi

let sumarcontrol=$contarcontrol1+$contarcontrol2
if [[ $sumarcontrol -eq 2 ]];then
        cumplimiento[124]="SI";
else
        cumplimiento[124]="NO";
fi
#cumplimiento 4.1.10

#cumplimiento 4.1.11
unsuccessful1=$(grep access /etc/audit/audit.rules)
unsuccessful2=$(auditctl -l | grep access)
if [[ $unsuccessful1 == *'-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access'* ]] && [[ $unsuccessful1 == *'-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access'* ]] && [[ $unsuccessful1 == *'-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access'* ]] && [[ $unsuccessful1 == *'-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access'* ]];then
        contarunsuccessful1=1;
else
        contarunsuccessful1=0;
fi

if [[ $unsuccessful2 == *'-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access '* ]] && [[ $unsuccessful2 == *'-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access'* ]] &&[[ $unsuccessful2 == *'-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access'* ]] && [[$unsuccessful2 == *'-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access'* ]];then
        contarunsuccessful2=1;
else
        contarunsuccessful2=0;
fi

let sumaunsuccessful=$contarunsuccessful1+$contarunsuccessful2
if [[ $sumaunsuccessful -eq 2 ]];then
        cumplimiento[125]="SI";
else
        cumplimiento[125]="NO";
fi
#cumplimiento 4.1.11

#cumplimiento 4.1.12
cumplimiento[126]=$textoNoValidado;

#cumplimiento 4.1.13
mounts1=$(grep mounts /etc/audit/audit.rules)
mounts2=$(auditctl -l | grep mounts)
if [[ $mounts1 == *'-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts'* ]] && [[ $mounts1 == *'-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts'* ]];then
        contarmounts1=1;
else
        contarmounts1=0;
fi

if [[ $mounts2 == *'-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts'* ]] && [[ $mounts2 == *'-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts'* ]];then
        contarmounts2=1;
else
        contarmounts2=0;
fi
let sumamounts=$contarmounts1+$contarmounts2
if [[ $sumamounts -eq 2 ]];then
        cumplimiento[127]="SI";
else
        cumplimiento[127]="NO";
fi
#cumplimiento 4.1.13

#cumplimiento 4.1.14
deletionevents1=$(grep delete /etc/audit/audit.rules)
deletionevents2=$(auditctl -l | grep delete)
if [[ $deletionevents1 == *'-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete'* ]] && [[ $deletionevents1 == *'-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete'* ]];then
        contardeletionevents1=1;
else
        contardeletionevents1=0;
fi

if [[ $deletionevents2 == *'-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete'* ]] && [[ $deletionevents2 == *'-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete'* ]];then
        contardeletionevents2=1;
else
        contardeletionevents2=0;
fi
let sumadeletionevent=$contardeletionevents1+$contardeletionevents2
if [[ $sumadeletionevent -eq 2 ]];then
        cumplimiento[128]="SI";
else
        cumplimiento[128]="NO";
fi
#cumplimiento 4.1.14

#cumplimiento 4.1.15
admscope1=$(grep scope /etc/audit/audit.rules)
admscope2=$(auditctl -l | grep scope)
if [[ $admscope1 == *'-w /etc/sudoers -p wa -k scope'* ]] && [[ $admscope1 == *'-w /etc/sudoers.d/ -p wa -k scope'* ]] ;then
        contaradmscope1=1;
else
        contaradmscope1=0;
fi

if [[ $admscope2 == *'-w /etc/sudoers -p wa -k scope'* ]] && [[ $admscope2 == *'-w /etc/sudoers.d/ -p wa -k scope'* ]] ;then
        contaradmscope2=1;
else
        contaradmscope2=0;
fi

let sumaadmscope=$contaradmscope1 +$contaradmscope2
if [[ $sumaadmscope -eq 2 ]];then
        cumplimiento[129]="SI";
else
        cumplimiento[129]="NO";
fi
#cumplimiento 4.1.15

#cumplimiento 4.1.16
admactions1=$(grep actions /etc/audit/audit.rules)
admactions2=$(auditctl -l | grep actions)
if [[ $admactions1 == *'-w /var/log/sudo.log -p wa -k actions'* ]] && [[ $admactions2 == *'-w /var/log/sudo.log -p wa -k actions'* ]] ;then
        cumplimiento[130]="SI";
else
        cumplimiento[130]="NO";
fi
#cumplimiento 4.1.16

#cumplimiento 4.1.17
kernelmodule1=$(grep modules /etc/audit/audit.rules)
kernelmodule2=$(auditctl -l | grep modules)
if [[ $kernelmodule1 == *'-w /sbin/insmod -p x -k modules'* ]] && [[ $kernelmodule1 == *'-w /sbin/rmmod -p x -k modules'* ]] && [[ $kernelmodule1 == *'-w       /sbin/modprobe -p x -k modules'* ]] && [[ $kernelmodule1 == *'-a always,exit -F arch=b64 -S init_module -S delete_module -k modules'* ]];then
        contarkernelmodule1=1;
else
        contarkernelmodule1=0;
fi

if [[ $kernelmodule2 == *'-w /sbin/insmod -p x -k modules'* ]] && [[ $kernelmodule2 == *'-w /sbin/rmmod -p x -k modules'* ]] && [[ $kernelmodule2 == *'-w /sbin/modprobe -p x -k modules'* ]] && [[ $kernelmodule2 == *'-a always,exit -F arch=b64 -S init_module -S delete_module -k modules '* ]] ;then
        contarkernelmodule2=1;
else
        contarkernelmodule2=0;
fi

let sumakernelmodule=$contarkernelmodule1+$contarkernelmodule2
if [[ $sumakernelmodule -eq 2 ]] ; then
        cumplimiento[131]="SI";
else
        cumplimiento[131]="NO";
fi
#cumplimiento 4.1.17

#cumplimiento 4.1.18
if [[ $ejecutar132 == *'-e 2'* ]];then
        cumplimiento[132]="SI";
else
        cumplimiento[132]="NO";
fi
#cumplimiento 4.1.18

#cumplimiento 4.2.1.1
if [[ $ejecutar133 == *'2:on'* ]] && [[ $ejecutar133 == *'3:on'* ]] && [[ $ejecutar133 == *'4:on'* ]] && [[ $ejecutar133 == *'5:on'* ]] ; then
        cumplimiento[133]="SI";
else
        cumplimiento[133]="NO";
fi
#cumplimiento 4.2.1.1

#cumplimiento 4.2.1.2
cumplimiento[134]=$textoNoValidado;

#cumplimiento 4.2.1.3
if [[ $ejecutar135 == *'0640'* ]] ;then
        cumplimiento[135]="SI";
else
        cumplimiento[135]="NO";
fi
#cumplimiento 4.2.1.3

#cumplimiento 4.2.1.4
cumplimiento[136]=$textoNoValidado;

#cumplimiento 4.2.1.5
rsyslog1=$(grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
rsyslog2=$(grep '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)

if [[ $rsyslog1 == *'$ModLoad imtcp'* ]] && [[ $rsyslog2 == *'$InputTCPServerRun 514'* ]] ;then
        cumplimiento[137]="SI";
else
        cumplimiento[137]="NO";
fi
#cumplimiento 4.2.1.5

#cumplimiento 4.2.2.1
if [[ $ejecutar138 == *'2:on'* ]] && [[ $ejecutar138 == *'3:on'* ]] && [[ $ejecutar138 == *'4:on'* ]] && [[ $ejecutar138 == *'5:on'* ]];then
        cumplimiento[138]="SI";
else
        cumplimiento[138]="NO";
fi
#cumplimiento 4.2.2.1

#cumplimiento 4.2.2.2
cumplimiento[139]=$textoNoValidado;

#cumplimiento 4.2.2.3
if [[ $ejecutar140 ==  *'0640'* ]];then
        cumplimiento[140]="SI";
else
        cumplimiento[140]="NO";
fi
#cumplimiento 4.2.2.3

#cumplimiento 4.2.2.4
cumplimiento[141]=$textoNoValidado;

#cumplimiento 4.2.2.5
cumplimiento[142]=$textoNoValidado;

#cumplimiento 4.2.3
syslog1=$(rpm -q rsyslog)
syslog2=$(rpm -q syslog-ng)
if [[ `echo $ejecutar143 | grep '^rsyslog'` ]] || [[ `echo $ejecutar143 | grep '^syslog'` ]];then
        cumplimiento[143]="SI";
else
        cumplimiento[143]="NO";
fi
#cumplimiento 4.2.3

#cumplimiento 4.2.4
cumplimiento[144]=$textoNoValidado;

#cumplimiento 4.3
cumplimiento[145]=$textoNoValidado;

#cumplimiento 5.1.1
if [[ $ejecutar146 == *'2:on'* ]] && [[ $ejecutar146 == *'3:on'* ]] && [[ $ejecutar146 == *'4:on'* ]] && [[ $ejecutar146 == *'5:on'* ]] ;then
        cumplimiento[146]="SI";
else
        cumplimiento[146]="NO";
fi
#cumplimiento 5.1.1

#cumplimiento 5.1.2
rontab=$(stat /etc/crontab | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $rontab == *'600'* ]] && [[ $rontab == *'Uid:(0/root)'* ]] && [[ $rontab == *'Gid:(0/root)'* ]] ;then
        cumplimiento[147]="SI";
else
        cumplimiento[147]="NO";
fi
#cumplimiento 5.1.2

#cumplimiento 5.1.3
hourly=$(stat /etc/cron.hourly | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $hourly == *'700'* ]] && [[ $hourly == *'Uid:(0/root)'* ]] && [[ $hourly == *'Gid:(0/root)'* ]] ;then
        cumplimiento[148]="SI";
else
        cumplimiento[148]="NO";
fi
#cumplimiento 5.1.3

#cumplimiento 5.1.4
daily=$(stat /etc/cron.daily | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $daily == *'700'* ]] && [[ $daily == *'Uid:(0/root)'* ]] && [[ $daily == *'Gid:(0/root)'* ]];then
        cumplimiento[149]="SI";
else
        cumplimiento[149]="NO";
fi
#cumplimiento 5.1.4

#cumplimiento 5.1.5
weekly=$(stat /etc/cron.weekly | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $weekly == *'0700'* ]] && [[ $weekly == *'Uid:(0/root)'* ]] && [[ $weekly == *'Gid:(0/root)'* ]];then
        cumplimiento[150]="SI";
else
        cumplimiento[150]="NO";
fi
#cumplimiento 5.1.5

#cumplimiento 5.1.6
monthly=$(stat /etc/cron.monthly | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $monthly == *'700'* ]] && [[ $monthly == *'Uid:(0/root)'* ]] && [[ $monthly == *'Gid:(0/root)'* ]];then
        cumplimiento[151]="SI";
else
        cumplimiento[151]="NO";
fi
#cumplimiento 5.1.6

#cumplimiento 5.1.7
d=$(stat /etc/cron.d | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $d == *'700'* ]] && [[ $d == *'Uid:(0/root)'* ]] && [[ $d == *'Gid:(0/root)'* ]];then
        cumplimiento[152]="SI";
else
        cumplimiento[152]="NO";
fi
#cumplimiento 5.1.7

#cumplimiento 5.1.8
restricted1=$(stat /etc/cron.deny 2>&1 > /dev/null)
restricted2=$(stat /etc/at.deny 2>&1 > /dev/null)
if [[ $restricted1 == *'No such file or directory'* ]] && [[ $restricted2 == *'No such file or directory'* ]] ;then
        cumplimiento[153]="SI";
else
        cumplimiento[153]="NO";
fi
#cumplimiento 5.1.8

#cumplimiento 5.2.1
sshdconfig=$(stat /etc/ssh/sshd_config | grep Access -m 1 | tr -d '[[:space:]]' )
if [[ $sshdconfig == *'600'* ]] && [[ $sshdconfig == *'Uid:(0/root)'* ]] && [[ $sshdconfig == *'Gid:(0/root)'* ]];then
        cumplimiento[154]="SI";
else
        cumplimiento[154]="NO";
fi
#cumplimiento 5.2.1

#cumplimiento 5.2.2
if [[ $ejecutar155 == *'Protocol 2'* ]];then
        cumplimiento[155]="SI";
else
        cumplimiento[155]="NO";
fi
#cumplimiento 5.2.2

#cumplimiento 5.2.3
if [[ $ejecutar156 == *'LogLevel INFO'* ]];then
        cumplimiento[156]="SI";
else
        cumplimiento[156]="NO";
fi
#cumplimiento 5.2.3

#cumplimiento 5.2.4
if [[ $ejecutar157 == *'X11Forwarding no'* ]];then
        cumplimiento[157]="SI";
else
        cumplimiento[157]="NO";
fi
#cumplimiento 5.2.4

#cumplimiento 5.2.5
if [[ $ejecutar158 == *'MaxAuthTries 4'* ]];then #recomendado 4
        cumplimiento[158]="SI";
else
        cumplimiento[158]="NO";
fi
#cumplimiento 5.2.5

#cumplimiento 5.2.6
if [[ $ejecutar159 == *'IgnoreRhosts yes'* ]];then
        cumplimiento[159]="SI";
else
        cumplimiento[159]="NO";
fi
#cumplimiento 5.2.6

#cumplimiento 5.2.7
if [[ $ejecutar160 == *'HostbasedAuthentication no'* ]];then
        cumplimiento[160]="SI";
else
        cumplimiento[160]="NO";
fi
#cumplimiento 5.2.7

#cumplimiento 5.2.8
if [[ $ejecutar161 == *'PermitRootLogin no'* ]];then
        cumplimiento[161]="SI";
else
        cumplimiento[161]="NO";
fi
#cumplimiento 5.2.8

#cumplimiento 5.2.9
if [[ $ejecutar162 == *'PermitEmptyPasswords no'* ]];then
        cumplimiento[162]="SI";
else
        cumplimiento[162]="NO";
fi
#cumplimiento 5.2.9

#cumplimiento 5.2.10
if [[ $ejecutar163 == *'PermitUserEnvironment no'* ]];then
        cumplimiento[163]="SI";
else
        cumplimiento[163]="NO";
fi
#cumplimiento 5.2.10

#cumplimiento 5.2.11
cumplimiento[164]=$textoNoValidado;

#cumplimiento 5.2.12
Interval=$(grep "^ClientAliveInterval" /etc/ssh/sshd_config | tr -cd '[[:digit:]]')
CountMax=$(grep "^ClientAliveCountMax" /etc/ssh/sshd_config | tr -cd '[[:digit:]]')
if [[ $Interval -ge 0 ]] && [[ $Interval -le 300 ]] && [[ $CountMax -le 3 ]];then
        cumplimiento[165]="SI";
else
        cumplimiento[165]="NO";
fi
#cumplimiento 5.2.12

#cumplimiento 5.2.13
LoginGraceTime=$(grep "^LoginGraceTime" /etc/ssh/sshd_config | tr -cd '[[:digit:]]')
if [[ $LoginGraceTime -ge 0 ]] && [[ $LoginGraceTime -le 60 ]];then
        cumplimiento[166]="SI";
else
        cumplimiento[166]="NO";
fi
#cumplimiento 5.2.13

#cumplimiento 5.2.14
cumplimiento[167]=$textoNoValidado;

#cumplimiento 5.2.15
if [[ $ejecutar168 == *'Banner /etc/issue.net'* ]];then
        cumplimiento[168]="SI";
else
        cumplimiento[168]="NO";
fi
#cumplimiento 5.2.15

#completar con las validaciones pci de contraseña.
#cumplimiento 5.3.1
passwordauth=$(grep pam_pwquality.so /etc/pam.d/password-auth | tr -d '[[:space:]]')
systemauth=$(grep pam_pwquality.so /etc/pam.d/system-auth | tr -d '[[:space:]]')
longitud=$(grep ^minlen /etc/security/pwquality.conf | tr -cd '[[:digit:]]')
digito=$(grep ^dcredit /etc/security/pwquality.conf | tr -cd '[[:digit:]]')
mayuscula=$(grep ^ucredit /etc/security/pwquality.conf | tr -cd '[[:digit:]]')
minuscula=$(grep ^lcredit /etc/security/pwquality.conf | tr -cd '[[:digit:]]')
if [[ $passwordauth == *'passwordrequisitepam_pwquality.sotry_first_passretry=3'* ]];then
        passcreationval1=1;
else
        passcreationval1=0;
fi

if [[ $systemauth == *'passwordrequisitepam_pwquality.sotry_first_passretry=3'* ]];then
        passcreationval2=1;
else
        passcreationval2=0;
fi

if [[ $longitud -ge 8 ]];then #cambiar de 8 a más, 1 caracter, 1 digito, 1 mayuscula , 1 minuscula.
        passcreationval3=1;
else
        passcreationval3=0;
fi

if [[ $digito == *'1'* ]];then
        passcreationval4=1;
else
        passcreationval4=0;
fi

if [[ $mayuscula == *'1'* ]];then
        passcreationval5=1;
else
        passcreationval5=0;
fi

if [[ $minuscula == *'1'* ]];then
        passcreationval6=1;
else
        passcreationval6=0;
fi
let sumapasscreation=$passcreationval1+$passcreationval2+$passcreationval3+$passcreationval4+$passcreationval5+$passcreationval6
if [[ $sumapasscreation -eq 6 ]];then
        cumplimiento[169]="SI";
else
        cumplimiento[169]="NO";
fi
#cumplimiento 5.3.1

#cumplimiento 5.3.2
cumplimiento[170]=$textoNoValidado;

#cumplimiento 5.3.3
passwordreuse1=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth | tr -cd '[[:digit:]]')
passwordreuse2=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth | tr -cd '[[:digit:]]')
passwordreuse3=$(egrep '^password\s+required\s+pam_pwhistory.so' /etc/pam.d/password-aut | tr -cd '[[:digit:]]')
passwordreuse4=$(egrep '^password\s+required\s+pam_pwhistory.so' /etc/pam.d/system-auth | tr -cd '[[:digit:]]')
if [[ $passwordreuse1 -ge 5 ]] && [[ $passwordreuse2 -ge 5 ]] ;then #mayor o igual
        contadorunix=1;
else
        contadorunix=0;
fi

if [[ $passwordreuse3 -ge 5 ]] && [[ $passwordreuse4 -ge 5 ]];then
        contadorhistory=1;
else
        contadorhistory=0;
fi
let sumapasswordreuse=$contadorunix+$contadorhistory
if [[ $sumapasswordreuse -ge 1 ]];then
        cumplimiento[171]="SI";
else
        cumplimiento[171]="NO";
fi
#cumplimiento 5.3.3

#cumplimiento 5.3.4
passwordhashing1=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/password-auth | tr -d '[[:space:]]')
passwordhashing2=$(egrep '^password\s+sufficient\s+pam_unix.so' /etc/pam.d/system-auth | tr -d '[[:space:]]')
if [[ $passwordhashing1 == *'passwordsufficientpam_unix.sosha512'* ]] && [[ $passwordhashing2 == *'passwordsufficientpam_unix.sosha512'* ]];then
        cumplimiento[172]="SI";
else
        cumplimiento[172]="NO";
fi
#cumplimiento 5.3.4

#cumplimiento 5.4.1.1
passexpiration=$(grep PASS_MAX_DAYS /etc/login.defs | tr -cd '[[:digit:]]')

if [[ $passexpiration -le 90 ]];then # se pone hasta 90 recomendacion de nahir
        passexpirationvalid1=1;
else
        passexpirationvalid1=0;
fi
        #recorriendo usuarios para verificar accesos
contador=0
for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1);do
        dias=$(chage --list $i | grep '^Maximum number of days between password change' | tr -cd '[[:digit:]]')
        if [[ $dias -gt 90 ]];then
            let contador=$contador+1;
        fi
done

if [[ $passexpirationvalid1 -eq 1 ]] && [[ $contador -eq 0 ]];then
        cumplimiento[173]="SI";
else
        cumplimiento[173]="NO";
fi
#cumplimiento 5.4.1.1

#cumplimiento 5.4.1.2
passchanges=$(grep PASS_MIN_DAYS /etc/login.defs | tr -cd '[[:digit:]]')
if [[ $passchanges -ge 7 ]];then #>=
        passchangesvald1=1;
else
        passchangesvald1=0
fi
        #recorriendo usuarios
passchangesvald2=0
for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1);do
        diaspasschanges=$(chage --list $i | grep '^Minimum number of days between password change' | tr -cd '[[:digit:]]')
        if [[ $diaspasschanges -ge 7 ]];then #>=
            let passchangesvald2=$passchangesvald2+1;
        fi
done

if [[ $passchangesvald1 -eq 1 ]] && [[ $passchangesvald2 -eq 0 ]];then
        cumplimiento[174]="SI";
else
        cumplimiento[174]="NO";
fi
#cumplimiento 5.4.1.2

#cumplimiento 5.4.1.3
passexpiration=$(grep PASS_WARN_AGE /etc/login.defs | tr -cd '[[:digit:]]')
if [[ $passexpiration -ge 7 ]] ;then
        passexpirationval1=1;
else
        passexpirationval1=0;
fi
        #recorriendo usuarios
passexpirationval2=0
for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1);do
        diaspassexpiration=$(chage --list $i | grep '^Number of days of warning before password expires' | tr -cd '[[:digit:]]')
        if [[ $diaspassexpiration -ge 7 ]];then #>=
            let passexpirationval2=$passexpirationval2+1;
        fi
done

if [[ $passexpirationval1 -eq 1 ]] && [[ $passexpirationval2 -eq 0 ]];then
        cumplimiento[175]="SI";
else
        cumplimiento[175]="NO";
fi
#cumplimiento 5.4.1.3

#cumplimiento 5.4.1.4
inactivepass=$(useradd -D | grep INACTIVE | tr -cd '[[:digit:]]')
if [[ $inactivepass -le 30 ]];then #<=
        inactivepassval1=1;
else
        inactivepassval1=0;
fi

if [[ $inactivepassval1 -eq 1 ]];then
        cumplimiento[176]="SI";
else
        cumplimiento[176]="NO";
fi

#solo se consideró el primer script
#el segundo script no se pudo realizar la verificacion por cada usuario no se puede extraer la fecha.
#cumplimiento 5.4.1.4

#cumplimiento 5.4.1.5
cumplimiento[177]=$textoNoValidado;

#cumplimiento 5.4.2
if [[ -z $ejecutar178 ]];then
        cumplimiento[178]="SI";
else
        cumplimiento[178]="NO";
fi
#cumplimiento 5.4.2

#cumplimiento 5.4.3
if [[ $ejecutar179 == *'0'* ]];then
        cumplimiento[179]="SI";
else
        cumplimiento[179]="NO";
fi
#cumplimiento 5.4.3

#cumplimiento 5.4.4
umask1=$(grep "umask" /etc/bashrc)
umask2=$(grep "umask" /etc/profile /etc/profile.d/*.sh)
if [[ $umask1 == *'027'* ]] && [[ $umask2 == *'027'* ]];then
        cumplimiento[180]="SI";
else
        cumplimiento[180]="NO";
fi
#cumplimiento 5.4.4

#cumplimiento 5.4.5
shelltimeout1=$(grep "^TMOUT" /etc/bashrc)
shelltimeout2=$(grep "^TMOUT" /etc/bashrc)
if [[ $shelltimeout1 == *'TMOUT=600'* ]] && [[ $shelltimeout2 == *'TMOUT=600'* ]] ;then
        cumplimiento[181]="SI";
else
        cumplimiento[181]="NO";
fi
#cumplimiento 5.4.5

#cumplimiento 5.5
command1=$(grep pam_wheel.so /etc/pam.d/su | grep '^auth' | tr -d '[[:space:]]')

if [[ $command1 = "authrequiredpam_wheel.souse_uid" ]];then
        cumplimiento[182]="SI";
else
        cumplimiento[182]="NO";
fi
#cumplimiento 5.5

#cumplimiento 6.1.1
cumplimiento[183]=$textoNoValidado;

#cumplimiento 6.1.2
etcpasswd=$(stat /etc/passwd | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcpasswd == *'644'* ]] && [[ $etcpasswd == *'Uid:(0/root)'* ]] && [[ $etcpasswd == *'Gid:(0/root)'* ]];then
        cumplimiento[184]="SI";
else
        cumplimiento[184]="NO";
fi
#cumplimiento 6.1.2

#cumplimiento 6.1.3
etcshadow=$(stat /etc/shadow | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcshadow == *'000'* ]] && [[ $etcshadow == *'Uid:(0/root)'* ]] && [[ $etcshadow == *'Gid:(0/root)'* ]] ;then
        cumplimiento[185]="SI";
else
        cumplimiento[185]="NO";
fi
#cumplimiento 6.1.3

#cumplimiento 6.1.4
etcgroup=$(stat /etc/group | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcgroup == *'644'* ]] && [[ $etcgroup == *'Uid:(0/root)'* ]] && [[ $etcgroup == *'Gid:(0/root)'* ]];then
        cumplimiento[186]="SI";
else
        cumplimiento[186]="NO";
fi
#cumplimiento 6.1.4

#cumplimiento 6.1.5
etcgshadow=$(stat /etc/gshadow | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcgshadow == *000* ]] && [[ $etcgshadow == *'Uid:(0/root)'* ]] && [[ $etcgshadow == *'Gid:(0/root)'* ]];then
        cumplimiento[187]="SI";
else
        cumplimiento[187]="NO";
fi
#cumplimiento 6.1.5

#cumplimiento 6.1.6
etcpassword=$(stat /etc/passwd- | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcpassword == *'644'* ]] && [[ $etcpassword == *'Uid:(0/root)'* ]] && [[ $etcpassword == *'Gid:(0/root)'* ]] ;then
        cumplimiento[188]="SI";
else
        cumplimiento[188]="NO";
fi
#cumplimiento 6.1.6

#cumplimiento 6.1.7
etcshadowguion=$(stat /etc/shadow- | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcshadowguion == *'000'* ]] && [[ $etcshadowguion == *'Uid:(0/root)'* ]] && [[ $etcshadowguion == *'Gid:(0/root)'* ]] ;then
        cumplimiento[189]="SI";
else
        cumplimiento[189]="NO";
fi
#cumplimiento 6.1.7

#cumplimiento 6.1.8
etcgroupguion=$(stat /etc/group- | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcgroupguion == *'644'* ]] && [[ $etcgroupguion == *'Uid:(0/root)'* ]] && [[ $etcgroupguion == *'Gid:(0/root)'* ]];then
        cumplimiento[190]="SI";
else
        cumplimiento[190]="NO";
fi
#cumplimiento 6.1.8

#cumplimiento 6.1.9
etcgshadowguion=$(stat /etc/gshadow- | grep Access -m 1 | tr -d '[[:space:]]')
if [[ $etcgshadowguion == *'000'* ]] && [[ $etcgshadowguion == *'Uid:(0/root)'* ]] && [[ $etcgshadowguion == *'Gid:(0/root)'* ]];then
        cumplimiento[191]="SI";
else
        cumplimiento[191]="NO";
fi
#cumplimiento 6.1.9

#cumplimiento 6.1.10
if [[ -z $ejecutar192 ]];then
        cumplimiento[192]="SI";
else
        cumplimiento[192]="NO";
fi
#cumplimiento 6.1.10

#cumplimiento 6.1.11
if [[ -z $ejecutar193 ]];then
        cumplimiento[193]="SI";
else
        cumplimiento[193]="NO";
fi
#cumplimiento 6.1.11

#cumplimiento 6.1.12
if [[ -z $ejecutar194 ]];then
        cumplimiento[194]="SI";
else
        cumplimiento[194]="NO";
fi
#cumplimiento 6.1.12

#cumplimiento 6.1.13
cumplimiento[195]=$textoNoValidado;

#cumplimiento 6.1.14
cumplimiento[196]=$textoNoValidado;

#cumplimiento 6.2.1
if [[ -z $ejecutar197 ]];then
        cumplimiento[197]="SI";
else
        cumplimiento[197]="NO";
fi
#cumplimiento 6.2.1

#cumplimiento 6.2.2
if [[ -z $ejecutar198 ]];then
        cumplimiento[198]="SI";
else
        cumplimiento[198]="NO";
fi
#cumplimiento 6.2.2

#cumplimiento 6.2.3
if [[ -z $ejecutar199 ]];then
        cumplimiento[199]="SI";
else
        cumplimiento[199]="NO";
fi
#cumplimiento 6.2.3

#cumplimiento 6.2.4
if [[ -z $ejecutar200 ]];then
        cumplimiento[200]="SI";
else
        cumplimiento[200]="NO";
fi
#cumplimiento 6.2.4

#cumplimiento 6.2.5
if [[ $ejecutar201 = "root" ]];then
        cumplimiento[201]="SI";
else
        cumplimiento[201]="NO";
fi
#cumplimiento 6.2.5

#cumplimiento 6.2.6
if [[ -z $ejecutar202  ]];then
        cumplimiento[202]="SI";
else
        cumplimiento[202]="NO";
fi
#cumplimiento 6.2.6

#cumplimiento 6.2.7
if [[ -z $ejecutar203 ]];then
        cumplimiento[203]="SI";
else
        cumplimiento[203]="NO";
fi
#cumplimiento 6.2.7

#cumplimiento 6.2.8
if [[ -z $ejecutar204 ]];then
        cumplimiento[204]="SI";
else
        cumplimiento[204]="NO";
fi
#cumplimiento 6.2.8

#cumplimiento 6.2.9
if [[ -z $ejecutar205 ]];then
        cumplimiento[205]="SI";
else
        cumplimiento[205]="NO";
fi
#cumplimiento 6.2.9

#cumplimiento 6.2.10
if [[ -z $ejecutar206 ]];then
        cumplimiento[206]="SI";
else
        cumplimiento[206]="NO";
fi
#cumplimiento 6.2.10

#cumplimiento 6.2.11
if [[ -z $ejecutar207 ]];then
        cumplimiento[207]="SI";
else
        cumplimiento[207]="NO";
fi
#cumplimiento 6.2.11

#cumplimiento 6.2.12
if [[ -z $ejecutar208 ]];then
        cumplimiento[208]="SI";
else
        cumplimiento[208]="NO";
fi
#cumplimiento 6.2.12

#cumplimiento 6.2.13
if [[ -z $ejecutar209 ]];then
        cumplimiento[209]="SI";
else
        cumplimiento[209]="NO";
fi
#cumplimiento 6.2.13

#cumplimiento 6.2.14
if [[ -z $ejecucion210 ]];then
        cumplimiento[210]="SI";
else
        cumplimiento[210]="NO";
fi
#cumplimiento 6.2.14

#cumplimiento 6.2.15
if [[ -z $ejecucion211 ]];then
        cumplimiento[211]="SI";
else
        cumplimiento[211]="NO";
fi
#cumplimiento 6.2.15

#cumplimiento 6.2.16
if [[ -z $ejecucion212 ]];then
        cumplimiento[212]="SI";
else
        cumplimiento[212]="NO";
fi
#cumplimiento 6.2.16

#cumplimiento 6.2.17
if [[ -z $ejecucion213 ]];then
        cumplimiento[213]="SI";
else
        cumplimiento[213]="NO";
fi
#cumplimiento 6.2.17

#cumplimiento 6.2.18
if [[ -z $ejecucion214 ]];then
        cumplimiento[214]="SI";
else
        cumplimiento[214]="NO";
fi
#cumplimiento 6.2.18

#cumplimiento 6.2.19
if [[ -z $ejecucion215 ]];then
        cumplimiento[215]="SI";
else
        cumplimiento[215]="NO";
fi
#cumplimiento 6.2.19


#generando archivo resumen .csv
echo "Enunciado;Cumple?;Hostname" >> reporteValidacionHardening.csv
for ((i=0; i<${#resultado[*]}; i++));do
        if [[ -n ${numero[i]} ]];then
                echo "${numero[i]}; ${cumplimiento[i]};$nombreServer" >> reporteValidacionHardening.csv
        fi
done

#generando archivo detalle .html
parte1="<!DOCTYPE html><html><head><meta charset='UTF-8'><h1>Reporte de validación de hardening</h1></head><body><table border=1 cellspacing=0 style=table-layout:fixed><tr><td><strong>Enunciado</strong></td><td><strong>¿Cumple?</strong></td><td><strong>Resultado</strong></td></tr>"
for ((i=0; i<${#resultado[*]}; i++))
do
        parte2=$parte2" <tr><td>"${numero[$i]}"</td><td>"${cumplimiento[$i]}"</td><td><pre>"${resultado[$i]}"</pre></td></tr>"
done

#parte3="</table></body></html>"
parte3="</table>"
echo "$parte1$parte2$parte3""<br><br><br>" >> detalleValidacionHardening.html

#segunda parte ejecucion de validacion para usuarios
#5.4.1.1
#5.4.1.2
#5.4.1.3
#5.4.1.4
parte10="<table border=1 cellspacing=0 style=table-layout:fixed><caption>5.4.1.1 Ensure password expiration is 365 days or less.<br>5.4.1.2 Ensure minimum days between password changes is 7 or more.<br>5.4.1.3 Ensure password expiration warning days is 7 or more<br>5.4.1.4 Ensure inactive password lock is 30 days or less</caption><tr><th>Usuario</th><th>Resultado</th></tr>"

for i in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1);do
        resultado2=""
        resultado2=$(chage --list $i)
        parte11=$parte11" <tr><td>"$i"</td><td><pre>"$resultado2"</pre></td></tr>"
done

parte12="</table>"
echo "$parte10""$parte11""$parte12""<br><br><br>" >> detalleValidacionHardening.html

#5.4.1.5
parte20="<table border=1 cellspacing=0 style=table-layout:fixed><caption>5.4.1.5 Ensure all users last password change date is in the past</caption><tr><th>Usuario</th><th>Resultado</th></tr>"
for i in $(cat /etc/shadow | cut -d: -f1);do
        resultado20=""
        resultado20=$(chage --list $i)
        parte21=$parte21" <tr><td>"$i"</td><td><pre>"$resultado20"</pre></td></tr>"
done

parte22="</table></body></html>"
echo "$parte20""$parte21""$parte22" >> detalleValidacionHardening.html


echo "¡La ejecucuión fue exitosa!"
