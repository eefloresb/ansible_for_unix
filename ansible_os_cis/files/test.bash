#!/bin/bash

#3.1.1 Ensure IP forwarding is disabled

comando84=$(sysctl net.ipv4.ip_forward | awk '{print $3}')

if [ "$comando84" -eq 0 ]; then
echo -e "3.1.1 Ensure IP forwarding is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.1.1 Ensure IP forwarding is disabled:\e[1;31m FAIL \e[0m"
fi 

#3.1.2 Ensure packet redirect sending is disabled

comando85=$(sysctl net.ipv4.conf.all.send_redirects | awk '{print $3}')
comando86=$(sysctl net.ipv4.conf.default.send_redirects | awk '{print $3}')

if [ "$comando85" -eq 0 ] && [ "$comando86" -eq 0 ]; then
echo -e "3.1.2 Ensure packet redirect sending is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.1.2 Ensure packet redirect sending is disabled:\e[1;31m FAIL \e[0m"
fi 

#3.2.1 Ensure source routed packets are not accepted

comando87=$(sysctl net.ipv4.conf.all.accept_source_route | awk '{print $3}')
comando88=$(sysctl net.ipv4.conf.default.accept_source_route | awk '{print $3}')
comando89=$(sysctl net.ipv6.conf.all.accept_source_route | awk '{print $3}')
comando90=$(sysctl net.ipv6.conf.default.accept_source_route | awk '{print $3}')

if [ "$comando87" -eq 0 ] && [ "$comando88" -eq 0 ] && [ "$comando89" -eq 0 ] && [ "$comando90" -eq 0 ]; then
echo -e "3.2.1 Ensure source routed packets are not accepted:\e[1;32m OK \e[0m"
else
echo -e "3.2.1 Ensure source routed packets are not accepted:\e[1;31m FAIL \e[0m"
fi 

#3.2.2 Ensure ICMP redirects are not accepted

comando91=$(sysctl net.ipv4.conf.all.accept_redirects | awk '{print $3}')
comando92=$(sysctl net.ipv4.conf.default.accept_redirects | awk '{print $3}')
comando93=$(sysctl net.ipv4.conf.default.accept_redirects | awk '{print $3}')
comando94=$(sysctl net.ipv6.conf.default.accept_redirects | awk '{print $3}')

if [ "$comando91" -eq 0 ] && [ "$comando92" -eq 0 ] && [ "$comando93" -eq 0 ] && [ "$comando94" -eq 0 ]; then
echo -e "3.2.2 Ensure ICMP redirects are not accepted:\e[1;32m OK \e[0m"
else
echo -e "3.2.2 Ensure ICMP redirects are not accepted:\e[1;31m FAIL \e[0m"
fi 

#3.2.3 Ensure secure ICMP redirects are not accepted 

comando95=$(sysctl net.ipv4.conf.all.secure_redirects | awk '{print $3}')
comando96=$(sysctl net.ipv4.conf.default.secure_redirects | awk '{print $3}')

if [ "$comando95" -eq 0 ] && [ "$comando96" -eq 0 ]; then
echo -e "3.2.3 Ensure secure ICMP redirects are not accepted:\e[1;32m OK \e[0m"
else
echo -e "3.2.3 Ensure secure ICMP redirects are not accepted:\e[1;31m FAIL \e[0m"
fi 

#3.2.4 Ensure suspicious packets are logged

comando97=$(sysctl net.ipv4.conf.all.log_martians | awk '{print $3}')
comando98=$(sysctl net.ipv4.conf.default.log_martians | awk '{print $3}')

if [ "$comando97" -eq 1 ] && [ "$comando98" -eq 1 ]; then
echo -e "3.2.4 Ensure suspicious packets are logged:\e[1;32m OK \e[0m"
else
echo -e "3.2.4 Ensure suspicious packets are logged:\e[1;31m FAIL \e[0m"
fi 

#3.2.5 Ensure broadcast ICMP requests are ignored

comando99=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts | awk '{print $3}')

if [ "$comando99" -eq 1 ]; then
echo -e "3.2.5 Ensure broadcast ICMP requests are ignored:\e[1;32m OK \e[0m"
else
echo -e "3.2.5 Ensure broadcast ICMP requests are ignored:\e[1;31m FAIL \e[0m"
fi 

#3.2.6 Ensure bogus ICMP responses are ignored

comando100=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses | awk '{print $3}')

if [ "$comando100" -eq 1 ]; then
echo -e "3.2.6 Ensure bogus ICMP responses are ignored:\e[1;32m OK \e[0m"
else
echo -e "3.2.6 Ensure bogus ICMP responses are ignored:\e[1;31m FAIL \e[0m"
fi 

#3.2.7 Ensure Reverse Path Filtering is enabled

comando101=$(sysctl net.ipv4.conf.all.rp_filter | awk '{print $3}')
comando102=$(sysctl net.ipv4.conf.default.rp_filter | awk '{print $3}')

if [ "$comando101" -eq 1 ] && [ "$comando102" -eq 1 ]; then
echo -e "3.2.7 Ensure Reverse Path Filtering is enabled:\e[1;32m OK \e[0m"
else
echo -e "3.2.7 Ensure Reverse Path Filtering is enabled:\e[1;31m FAIL \e[0m"
fi 

#3.2.8 Ensure TCP SYN Cookies is enabled

comando103=$(sysctl net.ipv4.tcp_syncookies | awk '{print $3}')

if [ "$comando103" -eq 1 ]; then
echo -e "3.2.8 Ensure TCP SYN Cookies is enabled:\e[1;32m OK \e[0m"
else
echo -e "3.2.8 Ensure TCP SYN Cookies is enabled:\e[1;31m FAIL \e[0m"
fi 

#3.2.9 Ensure IPv6 router advertisements are not accepted

comando104=$(sysctl net.ipv6.conf.all.accept_ra | awk '{print $3}')
comando105=$(sysctl net.ipv6.conf.default.accept_ra | awk '{print $3}')

if [ "$comando104" -eq 0 ] && [ "$comando105" -eq 0 ]; then
echo -e "3.2.9 Ensure IPv6 router advertisements are not accepted:\e[1;32m OK \e[0m"
else
echo -e "3.2.9 Ensure IPv6 router advertisements are not accepted:\e[1;31m FAIL \e[0m"
fi

#3.3.1 Ensure DCCP is disabled

comando106=$(lsmod | grep dccp)

if [ "$?" -eq 1 ]; then
echo -e "3.3.1 Ensure DCCP is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.3.1 Ensure DCCP is disabled:\e[1;31m FAIL \e[0m"
fi 

#3.3.2 Ensure SCTP is disabled

comando107=$(lsmod | grep sctp)

if [ "$?" -eq 1 ]; then
echo -e "3.3.2 Ensure SCTP is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.3.2 Ensure SCTP is disabled:\e[1;31m FAIL \e[0m"
fi 

#3.3.3 Ensure RDS is disabled

comando108=$(lsmod | grep rds)

if [ "$?" -eq 1 ]; then
echo -e "3.3.3 Ensure RDS is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.3.3 Ensure RDS is disabled:\e[1;31m FAIL \e[0m"
fi 

#3.3.4 Ensure TIPC is disabled

comando109=$(lsmod | grep tipc)

if [ "$?" -eq 1 ]; then
echo -e "3.3.4 Ensure TIPC is disabled:\e[1;32m OK \e[0m"
else
echo -e "3.3.4 Ensure TIPC is disabled:\e[1;31m FAIL \e[0m"
fi 

echo -e "##############################################################################"
echo -e "Checking Hardening on: $(hostname)"
echo -e "Date: $(date +"%m-%d-%y")"
echo -e "##############################################################################"
echo " "

#4.1.1.1 Ensure auditd is installed

comando142=$(rpm -q audit audit-libs)

if [ "$?" -eq 0 ]; then
echo -e "4.1.1.1 Ensure auditd is installed:\e[1;32m OK \e[0m"
else
echo -e "4.1.1.1 Ensure auditd is installed:\e[1;31m FAIL \e[0m"
fi 

#4.1.1.2 Ensure auditd service is enabled

comando143=$(systemctl is-enabled auditd 2>&1 > /dev/null)

if [ "$?" -eq 0 ] || [ "$comando143" == "enabled" ]; then
echo -e "4.1.1.2 Ensure auditd service is enabled:\e[1;32m OK \e[0m"
else
echo -e "4.1.1.2 Ensure auditd service is enabled:\e[1;31m FAIL \e[0m"
fi 

#4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled

comando144=$(grep -E 'kernelopts=(\S+\s+)*audit=1\b' /boot/grub2/grubenv)

if [ "$?" -eq 0 ]; then
echo -e "4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled:\e[1;32m OK \e[0m"
else
echo -e "4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled:\e[1;31m FAIL \e[0m"
fi 

#4.1.1.4 Ensure audit_backlog_limit is sufficient

comando145=$(grep -E 'kernelopts=(\S+\s+)*audit_backlog_limit=\S+\b' /boot/grub2/grubenv)

if [ "$?" -eq 0 ]; then
echo -e "4.1.1.4 Ensure audit_backlog_limit is sufficient:\e[1;32m OK \e[0m"
else
echo -e "4.1.1.4 Ensure audit_backlog_limit is sufficient:\e[1;31m FAIL \e[0m"
fi 

#4.1.2.1 Ensure audit log storage size is configured

comando146=$(grep max_log_file /etc/audit/auditd.conf)

if [ "$?" -eq 0 ]; then
echo -e "4.1.2.1 Ensure audit log storage size is configured:\e[1;32m OK \e[0m"
else
echo -e "4.1.2.1 Ensure audit log storage size is configured:\e[1;31m FAIL \e[0m"
fi 

#4.1.2.2 Ensure audit logs are not automatically deleted

comando147=$(grep max_log_file_action /etc/audit/auditd.conf | awk '{print $3}')

if [ "$comando147" == "keep_logs" ]; then
echo -e "4.1.2.2 Ensure audit logs are not automatically deleted:\e[1;32m OK \e[0m"
else
echo -e "4.1.2.2 Ensure audit logs are not automatically deleted:\e[1;31m FAIL \e[0m"
fi 

#4.1.2.3 Ensure system is disabled when audit logs are full

comando148=$(grep -w space_left_action /etc/audit/auditd.conf | awk '{print $3}')
comando149=$(grep action_mail_acct /etc/audit/auditd.conf | awk '{print $3}')
comando150=$(grep admin_space_left_action /etc/audit/auditd.conf | awk '{print $3}')

if [ "$comando148" == "email" ] && [ "$comando149" == "root" ] && [ "$comando150" == "halt" ]; then
echo -e "4.1.2.3 Ensure system is disabled when audit logs are full:\e[1;32m OK \e[0m"
else
echo -e "4.1.2.3 Ensure system is disabled when audit logs are full:\e[1;31m FAIL \e[0m"
fi 

#4.1.3 Ensure changes to system administration scope (sudoers) is collected

comando151=$(grep scope /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.3 Ensure changes to system administration scope (sudoers) is collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.3 Ensure changes to system administration scope (sudoers) is collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.4 Ensure login and logout events are collected

comando152=$(grep logins /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.4 Ensure login and logout events are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.4 Ensure login and logout events are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.5 Ensure session initiation information is collected

comando153=$(grep -E '(session|logins)' /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.5 Ensure session initiation information is collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.5 Ensure session initiation information is collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.6 Ensure events that modify date and time information are collected

comando154=$(grep time-change /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.6 Ensure events that modify date and time information are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.6 Ensure events that modify date and time information are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.7 Ensure events that modify the system's Mandatory Access Controls are collected

comando155=$(grep MAC-policy /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.7 Ensure events that modify the system's Mandatory Access Controls are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.7 Ensure events that modify the system's Mandatory Access Controls are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.8 Ensure events that modify the system's network environment are collected

comando156=$(grep system-locale /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.8 Ensure events that modify the system's network environment are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.8 Ensure events that modify the system's network environment are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.9 Ensure discretionary access control permission modification events are collected

comando157=$(auditctl -l | grep perm_mod /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.9 Ensure discretionary access control permission modification events are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.9 Ensure discretionary access control permission modification events are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.10 Ensure unsuccessful unauthorized file access attempts are collected

comando158=$(grep access /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.10 Ensure unsuccessful unauthorized file access attempts are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.10 Ensure unsuccessful unauthorized file access attempts are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.11 Ensure events that modify user/group information are collected

comando159=$(grep identity /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.11 Ensure events that modify user/group information are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.11 Ensure events that modify user/group information are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.12 Ensure successful file system mounts are collected

comando160=$(grep mounts /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.12 Ensure successful file system mounts are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.12 Ensure successful file system mounts are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.13 Ensure use of privileged commands is collected

#comando161=$()

#4.1.14 Ensure file deletion events by users are collected 

comando162=$(grep delete /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.14 Ensure file deletion events by users are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.14 Ensure file deletion events by users are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.15 Ensure kernel module loading and unloading is collected

comando163=$(grep modules /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.15 Ensure kernel module loading and unloading is collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.15 Ensure kernel module loading and unloading is collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.16. Ensure system administrator actions (sudolog) are collected

comando164=$(grep -E "^\s*-w\s+$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//')\s+-p\s+wa\s+-k\s+actions" /etc/audit/rules.d/*.rules)

if [ "$?" -eq 0 ]; then
echo -e "4.1.16. Ensure system administrator actions (sudolog) are collected:\e[1;32m OK \e[0m"
else
echo -e "4.1.16. Ensure system administrator actions (sudolog) are collected:\e[1;31m FAIL \e[0m"
fi 

#4.1.17 Ensure the audit configuration is immutable

comando165=$(grep "^\s*[^#]" /etc/audit/rules.d/*.rules | tail -1)

if [ "$comando165" == "-e 2" ]; then
echo -e "4.1.17 Ensure the audit configuration is immutable:\e[1;32m OK \e[0m"
else
echo -e "4.1.17 Ensure the audit configuration is immutable:\e[1;31m FAIL \e[0m"
fi 

#4.2.1.1 Ensure rsyslog is installed

comando166=$(rpm -q rsyslog)

if [ "$?" -eq 0 ]; then
echo -e "4.2.1.1 Ensure rsyslog is installed:\e[1;32m OK \e[0m"
else
echo -e "4.2.1.1 Ensure rsyslog is installed:\e[1;31m FAIL \e[0m"
fi 

#4.2.1.2 Ensure rsyslog Service is enabled

comando167=$(systemctl is-enabled rsyslog 2>&1 > /dev/null)

if [ "$?" -eq 0 ] || [ "$comando167" == "enabled" ]; then
echo -e "4.2.1.2 Ensure rsyslog Service is enabled:\e[1;32m OK \e[0m"
else
echo -e "4.2.1.2 Ensure rsyslog Service is enabled:\e[1;31m FAIL \e[0m"
fi 

#4.2.1.3 Ensure rsyslog default file permissions configured

comando168=$(grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>&1 > /dev/null)

if [ "$?" -eq 0 ]; then
echo -e "4.2.1.3 Ensure rsyslog default file permissions configured:\e[1;32m OK \e[0m"
else
echo -e "4.2.1.3 Ensure rsyslog default file permissions configured:\e[1;31m FAIL \e[0m"
fi 

#4.2.1.4 Ensure logging is configured

#comando169=$()

#4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host

comando170=$(grep "^*.*[^I][^I]*@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>&1 > /dev/null)

if [ "$?" -eq 0 ]; then
echo -e "4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host:\e[1;32m OK \e[0m"
else
echo -e "4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host:\e[1;31m FAIL \e[0m"
fi 

#4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts

comando171=$(grep '$ModLoad imtcp' /etc/rsyslog.conf 2>&1 > /dev/null)
comando172=$(grep '$InputTCPServerRun 514' /etc/rsyslog.conf 2>&1 > /dev/null)

if [ ! -z "$comando171" ] && [ ! -z "$comando172" ]; then
echo -e "4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts:\e[1;32m OK \e[0m"
else
echo -e "4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts:\e[1;31m FAIL \e[0m"
fi 

#4.2.2.1 Ensure journald is configured to send logs to rsyslog

comando173=$(grep -e ^\s*ForwardToSyslog /etc/systemd/journald.conf)

if [ "$comando173" == "ForwardToSyslog=yes" ]; then
echo -e "4.2.2.1 Ensure journald is configured to send logs to rsyslog:\e[1;32m OK \e[0m"
else
echo -e "4.2.2.1 Ensure journald is configured to send logs to rsyslog:\e[1;31m FAIL \e[0m"
fi 

#4.2.2.2 Ensure journald is configured to compress large log files

comando174=$(grep -e ^\s*Compress /etc/systemd/journald.conf)

if [ "$comando174" == "Compress=yes" ]; then
echo -e "4.2.2.2 Ensure journald is configured to compress large log files:\e[1;32m OK \e[0m"
else
echo -e "4.2.2.2 Ensure journald is configured to compress large log files:\e[1;31m FAIL \e[0m"
fi 

#4.2.2.3 Ensure journald is configured to write logfiles to persistent disk

comando175=$(grep -e ^\s*Storage /etc/systemd/journald.conf)

if [ "$comando175" == "Storage=persistent" ]; then
echo -e "4.2.2.3 Ensure journald is configured to write logfiles to persistent disk:\e[1;32m OK \e[0m"
else
echo -e "4.2.2.3 Ensure journald is configured to write logfiles to persistent disk:\e[1;31m FAIL \e[0m"
fi 

#4.2.3 Ensure permissions on all logfiles are configured

comando176=$(find /var/log -name "prueba.txt.*" -type f -perm /037 -ls -o -type d -perm /026 -ls | wc -l)

if [ "$comando176" -eq 0 ]; then
echo -e "4.2.3 Ensure permissions on all logfiles are configured:\e[1;32m OK \e[0m"
else
echo -e "4.2.3 Ensure permissions on all logfiles are configured:\e[1;31m FAIL \e[0m"
fi 

#4.3 Ensure logrotate is configured

echo -e "##############################################################################"
echo -e "Checking Hardening on: $(hostname)"
echo -e "Date: $(date +"%m-%d-%y")"
echo -e "##############################################################################"
echo " "

#5.1.1 Ensure cron daemon is enabled

comando177=$(systemctl is-enabled crond 2>&1 > /dev/null)

if [ "$?" -eq 0 ] || [ "$comando177" == "enabled" ]; then
echo -e "5.1.1 Ensure cron daemon is enabled:\e[1;32m OK \e[0m"
else
echo -e "5.1.1 Ensure cron daemon is enabled:\e[1;31m FAIL \e[0m"
fi 

#5.1.2 Ensure permissions on /etc/crontab are configured

comando178=$(stat /etc/crontab | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando178" == "-rw------- root root" ]; then
echo -e "5.1.2 Ensure permissions on /etc/crontab are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.2 Ensure permissions on /etc/crontab are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.3 Ensure permissions on /etc/cron.hourly are configured

comando179=$(stat /etc/cron.hourly | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando179" == "drwx------ root root" ]; then
echo -e "5.1.3 Ensure permissions on /etc/cron.hourly are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.3 Ensure permissions on /etc/cron.hourly are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.4 Ensure permissions on /etc/cron.daily are configured

comando180=$(stat /etc/cron.daily | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando180" == "drwx------ root root" ]; then
echo -e "5.1.4 Ensure permissions on /etc/cron.daily are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.4 Ensure permissions on /etc/cron.daily are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.5 Ensure permissions on /etc/cron.weekly are configured

comando181=$(stat /etc/cron.weekly | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando181" == "drwx------ root root" ]; then
echo -e "5.1.5 Ensure permissions on /etc/cron.weekly are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.5 Ensure permissions on /etc/cron.weekly are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.6 Ensure permissions on /etc/cron.monthly are configured

comando182=$(stat /etc/cron.monthly | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando182" == "drwx------ root root" ]; then
echo -e "5.1.6 Ensure permissions on /etc/cron.monthly are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.6 Ensure permissions on /etc/cron.monthly are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.7 Ensure permissions on /etc/cron.d are configured

comando183=$(stat /etc/cron.d | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando183" == "drwx------ root root" ]; then
echo -e "5.1.7 Ensure permissions on /etc/cron.d are configured:\e[1;32m OK \e[0m"
else
echo -e "5.1.7 Ensure permissions on /etc/cron.d are configured:\e[1;31m FAIL \e[0m"
fi 

#5.1.8 Ensure at/cron is restricted to authorized users

comando184=/etc/cron.deny

if [ -f "$comando184" ]; then
echo -e "5.1.8 Ensure at/cron is restricted to authorized users:\e[1;32m OK \e[0m"
else
echo -e "5.1.8 Ensure at/cron is restricted to authorized users:\e[1;31m FAIL \e[0m"
fi 

#5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured

comando185=$(stat /etc/ssh/sshd_config | grep Acceso | head -1 | awk '{print $2, $6, $10}' | cut -d '/' -f2 | cut -d ')' -f1,2,3 | sed 's/)//g')

if [ "$comando185" == "-rw------- root root" ]; then
echo -e "5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured:\e[1;31m FAIL \e[0m"
fi 

#5.2.2 Ensure SSH access is limited

comando186=$(sshd -T | grep -E '^\s*(allow|deny)(users|groups)\s+\S+' | wc -l)

if [ "$comando186" -gt 0 ]; then
echo -e "5.2.2 Ensure SSH access is limited:\e[1;32m OK \e[0m"
else
echo -e "5.2.2 Ensure SSH access is limited:\e[1;31m FAIL \e[0m"
fi 

#5.2.3 Ensure permissions on SSH private host key files are configured

comando187=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat {} \; | grep Acceso | grep Uid | awk '{print $2, $6}' | cut -d '/' -f2 | sed 's/)//g' | sort -u)
comando188=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec stat {} \; | grep Acceso | grep Uid | awk '{print $2, $6}' | cut -d '/' -f2 | sed 's/)//g' | sort -u | wc -l)

if [ "$comando187" == "-rw------- root" ] && [ "$comando188" -eq 1 ]; then
echo -e "5.2.3 Ensure permissions on SSH private host key files are configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.3 Ensure permissions on SSH private host key files are configured:\e[1;31m FAIL \e[0m"
fi 

#5.2.4 Ensure permissions on SSH public host key files are configured

comando189=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \; | grep Acceso | grep Uid | awk '{print $2, $6}' | cut -d '/' -f2 | sed 's/)//g' | sort -u)
comando190=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \; | grep Acceso | grep Uid | awk '{print $2, $6}' | cut -d '/' -f2 | sed 's/)//g' | sort -u | wc -l)

if [ "$comando189" == "-rw------- root" ] && [ "$comando190" -eq 1 ]; then
echo -e "5.2.4 Ensure permissions on SSH public host key files are configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.4 Ensure permissions on SSH public host key files are configured:\e[1;31m FAIL \e[0m"
fi 

#5.2.5 Ensure SSH LogLevel is appropriate

comando191=$(sshd -T | grep -i loglevel | awk '{print $2}')

if [ "$comando191" == "VERBOSE" ] || [ "$comando191" == "INFO" ]; then
echo -e "5.2.5 Ensure SSH LogLevel is appropriate:\e[1;32m OK \e[0m"
else
echo -e "5.2.5 Ensure SSH LogLevel is appropriate:\e[1;31m FAIL \e[0m"
fi

#5.2.6 Ensure SSH X11 forwarding is disabled

comando192=$(sshd -T | grep -i x11forwarding | awk '{print $2}')

if [ "$comando192" == "no" ] || [ "$comando192" == "NO" ]; then
echo -e "5.2.6 Ensure SSH X11 forwarding is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.6 Ensure SSH X11 forwarding is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.7 Ensure SSH MaxAuthTries is set to 4 or less

comando193=$(sshd -T | grep -i maxauthtries | awk '{print $2}')

if [ "$comando193" -le 6 ]; then
echo -e "5.2.7 Ensure SSH MaxAuthTries is set to 4 or less:\e[1;32m OK \e[0m"
else
echo -e "5.2.7 Ensure SSH MaxAuthTries is set to 4 or less:\e[1;31m FAIL \e[0m"
fi

#5.2.8 Ensure SSH IgnoreRhosts is enabled

comando194=$(sshd -T | grep -i ignorerhosts | awk '{print $2}')

if [ "$comando194" == "yes" ] || [ "$comando194" == "YES" ]; then
echo -e "5.2.8 Ensure SSH IgnoreRhosts is enabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.8 Ensure SSH IgnoreRhosts is enabled:\e[1;31m FAIL \e[0m"
fi

#5.2.9 Ensure SSH HostbasedAuthentication is disabled

comando195=$(sshd -T | grep -i hostbasedauthentication | awk '{print $2}')

if [ "$comando195" == "no" ] || [ "$comando195" == "NO" ]; then
echo -e "5.2.9 Ensure SSH HostbasedAuthentication is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.9 Ensure SSH HostbasedAuthentication is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.10 Ensure SSH root login is disabled

comando196=$(sshd -T | grep -i permitrootlogin | awk '{print $2}')

if [ "$comando196" == "no" ] || [ "$comando196" == "NO" ]; then
echo -e "5.2.10 Ensure SSH root login is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.10 Ensure SSH root login is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.11 Ensure SSH PermitEmptyPasswords is disabled

comando197=$(sshd -T | grep -i permitemptypasswords | awk '{print $2}')

if [ "$comando197" == "no" ] || [ "$comando197" == "NO" ]; then
echo -e "5.2.11 Ensure SSH PermitEmptyPasswords is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.11 Ensure SSH PermitEmptyPasswords is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.12 Ensure SSH PermitUserEnvironment is disabled

comando198=$(sshd -T | grep -i permituserenvironment | awk '{print $2}')

if [ "$comando198" == "no" ] || [ "$comando198" == "NO" ]; then
echo -e "5.2.12 Ensure SSH PermitUserEnvironment is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.12 Ensure SSH PermitUserEnvironment is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.13 Ensure SSH Idle Timeout Interval is configured

comando199=$(sshd -T | grep -i clientaliveinterval | awk '{print $2}')
comando200=$(sshd -T | grep -i clientalivecountmax | awk '{print $2}')

if [ "$comando199" -gt 1 ] && [ "$comando199" -le 300 ] && [ "$comando200" -gt 0 ] && [ "$comando200" -le 3 ]; then
echo -e "5.2.13 Ensure SSH Idle Timeout Interval is configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.13 Ensure SSH Idle Timeout Interval is configured:\e[1;31m FAIL \e[0m"
fi

#5.2.14 Ensure SSH LoginGraceTime is set to one minute or less

comando201=$(sshd -T | grep -i logingracetime | awk '{print $2}')

if [ "$comando201" -ge 1 ] && [ "$comando201" -le 60 ]; then
echo -e "5.2.14 Ensure SSH LoginGraceTime is set to one minute or less:\e[1;32m OK \e[0m"
else
echo -e "5.2.14 Ensure SSH LoginGraceTime is set to one minute or less:\e[1;31m FAIL \e[0m"
fi

#5.2.15 Ensure SSH warning banner is configured

comando202=$(sshd -T | grep -i banner | awk '{print $2}')

if [ "$comando202" == "/etc/bsshd.bn" ]; then
echo -e "5.2.15 Ensure SSH warning banner is configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.15 Ensure SSH warning banner is configured:\e[1;31m FAIL \e[0m"
fi

#5.2.16 Ensure SSH PAM is enabled

comando203=$(sshd -T | grep -i usepam | awk '{print $2}')

if [ "$comando203" == "yes" ] || [ "$comando203" == "YES" ]; then
echo -e "5.2.16 Ensure SSH PAM is enabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.16 Ensure SSH PAM is enabled:\e[1;31m FAIL \e[0m"
fi

#5.2.17 Ensure SSH AllowTcpForwarding is disabled

comando204=$(sshd -T | grep -i allowtcpforwarding | awk '{print $2}')

if [ "$comando204" == "no" ] || [ "$comando204" == "NO" ]; then
echo -e "5.2.17 Ensure SSH AllowTcpForwarding is disabled:\e[1;32m OK \e[0m"
else
echo -e "5.2.17 Ensure SSH AllowTcpForwarding is disabled:\e[1;31m FAIL \e[0m"
fi

#5.2.18 Ensure SSH MaxStartups is configured

comando205=$(sshd -T | grep -i maxstartups | awk '{print $2}')

if [ "$comando205" == "10:30:60" ]; then
echo -e "5.2.18 Ensure SSH MaxStartups is configured:\e[1;32m OK \e[0m"
else
echo -e "5.2.18 Ensure SSH MaxStartups is configured:\e[1;31m FAIL \e[0m"
fi

#5.2.19 Ensure SSH MaxSessions is set to 4 or less

comando206=$(sshd -T | grep -i maxsessions | awk '{print $2}')

if [ "$comando206" -le 4 ]; then
echo -e "5.2.19 Ensure SSH MaxSessions is set to 4 or less:\e[1;32m OK \e[0m"
else
echo -e "5.2.19 Ensure SSH MaxSessions is set to 4 or less:\e[1;31m FAIL \e[0m"
fi

#5.2.20 Ensure system-wide crypto policy is not over-ridden

comando207=$(grep '^CRYPTO_POLICY=' /etc/sysconfig/sshd)

if [ "$?" -eq 0 ]; then
echo -e "5.2.10 Ensure system-wide crypto policy is not over-ridden:\e[1;32m OK \e[0m"
else
echo -e "5.2.10 Ensure system-wide crypto policy is not over-ridden:\e[1;31m FAIL \e[0m"
fi

#5.3.1 Create custom authselect profile

comando208=$(authselect current | grep 'Profile ID:')

if [ "$?" -eq 0 ]; then
echo -e "5.3.1 Create custom authselect profile:\e[1;32m OK \e[0m"
else
echo -e "5.3.1 Create custom authselect profile:\e[1;31m FAIL \e[0m"
fi

#5.3.2 Select authselect profile

comando209=$(authselect current)

if [ "$?" -eq 0 ]; then
echo -e "5.3.2 Select authselect profile:\e[1;32m OK \e[0m"
else
echo -e "5.3.2 Select authselect profile:\e[1;31m FAIL \e[0m"
fi

#5.3.3 Ensure authselect includes with-faillock

comando210=$(authselect current | grep with-faillock)

if [ "$?" -eq 0 ]; then
echo -e "5.3.3 Ensure authselect includes with-faillock:\e[1;32m OK \e[0m"
else
echo -e "5.3.3 Ensure authselect includes with-faillock:\e[1;31m FAIL \e[0m"
fi

#5.4.1 Ensure password creation requirements are configured

comando211=$(grep pam_pwquality.so /etc/pam.d/system-auth /etc/pam.d/password-auth | wc -l)
comando212=$(grep ^minlen /etc/security/pwquality.conf | wc -l)
comando213=$(grep ^minclass /etc/security/pwquality.conf | wc -l)

if [ "$comando211" -eq 2 ] && [ "$comando212" -gt 0 ] && [ "$comando213" -gt 0 ]; then
echo -e "5.4.1 Ensure password creation requirements are configured:\e[1;32m OK \e[0m"
else
echo -e "5.4.1 Ensure password creation requirements are configured:\e[1;31m FAIL \e[0m"
fi

#5.4.2 Ensure lockout for failed password attempts is configured

comando214=$(grep -E '^\s*auth\s+required\s+pam_faillock.so\s+' /etc/pam.d/password-auth /etc/pam.d/system-auth)

if [ "$?" -eq 0 ]; then
echo -e "5.4.2 Ensure lockout for failed password attempts is configured:\e[1;32m OK \e[0m"
else
echo -e "5.4.2 Ensure lockout for failed password attempts is configured:\e[1;31m FAIL \e[0m"
fi

#5.4.3 Ensure password reuse is limited

comando215=$(grep -E '^\s*password\s+(requisite|sufficient)\s+(pam_pwquality\.so|pam_unix\.so)\s+.*remember=([5-9]|[1-4][0-9])[0-9]*\s*.*$' /etc/pam.d/system-auth)

if [ "$?" -eq 0 ]; then
echo -e "5.4.3 Ensure password reuse is limited:\e[1;32m OK \e[0m"
else
echo -e "5.4.3 Ensure password reuse is limited:\e[1;31m FAIL \e[0m"
fi

#5.4.4 Ensure password hashing algorithm is SHA-512

comando216=$(grep -E '^\s*password\s+sufficient\s+pam_unix.so\s+.*sha512\s*.*$' /etc/pam.d/password-auth /etc/pam.d/system-auth)

if [ "$?" -eq 0 ]; then
echo -e "5.4.4 Ensure password hashing algorithm is SHA-512:\e[1;32m OK \e[0m"
else
echo -e "5.4.4 Ensure password hashing algorithm is SHA-512:\e[1;31m FAIL \e[0m"
fi

#5.5.1.1 Ensure password expiration is 365 days or less

comando217=$(grep PASS_MAX_DAYS /etc/login.defs | grep -v '#' | awk '{print $2}')

if [ "$comando217" -le 365 ]; then
echo -e "5.5.1.1 Ensure password expiration is 365 days or less:\e[1;32m OK \e[0m"
else
echo -e "5.5.1.1 Ensure password expiration is 365 days or less:\e[1;31m FAIL \e[0m"
fi

#5.5.1.2 Ensure minimum days between password changes is 7 or more

comando218=$(grep PASS_MIN_DAYS /etc/login.defs | grep -v '#' | awk '{print $2}')

if [ "$comando218" -ge 7 ]; then
echo -e "5.5.1.1 Ensure password expiration is 365 days or less:\e[1;32m OK \e[0m"
else
echo -e "5.5.1.1 Ensure password expiration is 365 days or less:\e[1;31m FAIL \e[0m"
fi

#5.5.1.3 Ensure password expiration warning days is 7 or more

comando219=$(grep PASS_WARN_AGE /etc/login.defs | grep -v '#' | awk '{print $2}')

if [ "$comando219" -ge 7 ]; then
echo -e "5.5.1.3 Ensure password expiration warning days is 7 or more:\e[1;32m OK \e[0m"
else
echo -e "5.5.1.3 Ensure password expiration warning days is 7 or more:\e[1;31m FAIL \e[0m"
fi

#5.5.1.4 Ensure inactive password lock is 30 days or less

comando220=$(useradd -D | grep INACTIVE)

if [ "$comando220" == "INACTIVE=30" ]; then
echo -e "5.5.1.4 Ensure inactive password lock is 30 days or less:\e[1;32m OK \e[0m"
else
echo -e "5.5.1.4 Ensure inactive password lock is 30 days or less:\e[1;31m FAIL \e[0m"
fi

#5.5.1.5 Ensure all users last password change date is in the past

#comando221=$()

#5.5.2 Ensure system accounts are secured

comando222=$(awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000)' /etc/passwd | awk -F':' '{print $7}' | sort -u)
comando223=$(awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $3<1000)' /etc/passwd | awk -F':' '{print $7}' | sort -u | wc -l)

if [ "$comando222" == "/sbin/nologin" ] && [ "$comando223" -eq 1 ] ; then
echo -e "5.5.2 Ensure system accounts are secured:\e[1;32m OK \e[0m"
else
echo -e "5.5.2 Ensure system accounts are secured:\e[1;31m FAIL \e[0m"
fi

#5.5.3 Ensure default user shell timeout is 900 seconds or less

comando224=$(grep "^TMOUT" /etc/profile /etc/profile.d/*.sh /etc/bashrc)

if [ "$?" -eq 0 ] ; then
echo -e "5.5.3 Ensure default user shell timeout is 900 seconds or less:\e[1;32m OK \e[0m"
else
echo -e "5.5.3 Ensure default user shell timeout is 900 seconds or less:\e[1;31m FAIL \e[0m"
fi

#5.5.4 Ensure default group for the root account is GID 0

comando225=$(grep "^root:" /etc/passwd | cut -f4 -d:)

if [ "$comando225" -eq 0 ] ; then
echo -e "5.5.4 Ensure default group for the root account is GID 0:\e[1;32m OK \e[0m"
else
echo -e "5.5.4 Ensure default group for the root account is GID 0:\e[1;31m FAIL \e[0m"
fi

#5.5.5 Ensure default user umask is 027 or more restrictive

comando226=$(grep "umask" /etc/profile /etc/profile.d/*.sh /etc/bashrc | grep -v '#' | awk '{print $2,$3}' | grep 'umask 027' | sort -u | wc -l)

if [ "$comando226" -eq 1 ] ; then
echo -e "5.5.5 Ensure default user umask is 027 or more restrictive:\e[1;32m OK \e[0m"
else
echo -e "5.5.5 Ensure default user umask is 027 or more restrictive:\e[1;31m FAIL \e[0m"
fi

#5.6 Ensure root login is restricted to system console

#5.7 Ensure access to the su command is restricted

comando227=$(grep pam_wheel.so /etc/pam.d/su | grep -v '#')

if [ "$?" -eq 0 ] ; then
echo -e "5.7 Ensure access to the su command is restricted:\e[1;32m OK \e[0m"
else
echo -e "5.7 Ensure access to the su command is restricted:\e[1;31m FAIL \e[0m"
fi

