#Version 5
#!/bin/bash
echo "Hostname : "$HOSTNAME; 
sudo ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/';
if test -f /etc/redhat-release
then
   cat "/etc/redhat-release";
else
   lsb_release -d
fi
compgen -u > users.txt; 
while read -r username; 
do
   echo " ";
   echo "######################## ";
   echo "user : "$username;
   sudo -l -U $username;
   groups $username;
   sudo chage -l $username;
   last $username;
   sudo passwd --status $username; 
done < users.txt;
echo " ";
echo "#########################"; 
echo "##CyberArk DNA Commands##"; 
echo "#########################"; 
echo " "; 
echo "cat /etc/passwd"; 
sudo cat "/etc/passwd"; 
echo " "; 
echo "sudo cat /etc/shadow"; 
sudo cat "/etc/shadow"; 
echo " "; 
echo "cat /etc/group"; 
sudo cat "/etc/group"; 
echo " "; 
echo "sudo cat /etc/sudoers"; 
sudo cat "/etc/sudoers"; 
echo " "; 
echo "sudo lastlog | grep -v '*'"; 
sudo lastlog | grep -v '*'; 
echo "End of script"
