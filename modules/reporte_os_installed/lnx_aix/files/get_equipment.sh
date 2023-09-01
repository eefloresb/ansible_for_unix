rm /tmp/usuarios.txt 2>/dev/null 
ipaddr=$(
    ip=$(ifconfig -a | grep -w inet | awk '{print $2}'|grep -v 127.0.0.1 |head -n 1)
    if echo $ip | grep -wq addr 1>/dev/null; then
        echo $ip | awk -F: '{print $2}'
    else
        echo $ip
    fi
    )
xhostname=$(hostname)
osname=$(uname)
osystemf=$(
if [[ $osname == "Linux" ]]; then 
    if [[ -f /etc/redhat-release ]]; then
          os=$(grep -Eiow "(Red Hat|CentOS)" /etc/redhat-release)
          if [[ $os == "Red Hat" ]]; then
               echo RedHat
          fi
          if [[ $os == "CentOS" ]]; then
               echo CentOS
          fi       
    elif [[ -f /etc/SuSE-release ]]; then 
            echo Suse 
    elif [[ -f /etc/os-release ]]; then
          os=$(grep -w "PRETTY_NAME=" /etc/os-release | awk -F = '{print $2}' | tr -d '"' | grep -iwoE "(debian|ubuntu|sles|suse)")
          if [[ $os == "Debian" ]]; then
               echo Debian
          elif [[ $os == "Ubuntu" ]]; then
                echo Ubuntu
          elif [[ $os == "sles" ]]; then
            echo Suse
          fi
    fi    
elif [[ $osname == "AIX" ]]; then
    echo $osname
elif [[ $osname == "SunOS" ]]; then
    echo $osname
fi
)
ossystemv=$(
if [[ $osname == "Linux" ]]
then
    if [[ -f /etc/redhat-release ]]; then 
        os=$(grep -Eiow "(Red Hat|Centos)" /etc/redhat-release) 
    elif [[ -f /etc/os-release ]]; then 
        os=$(grep -w "PRETTY_NAME=" /etc/os-release | awk -F = '{print $2}' | tr -d '"' | grep -iwoE "(debian|ubuntu|sles|suse)")
    fi
    if [[ $os == "Red Hat" ]]; then 
        version=`grep -Ewo '[[:digit:]]\.[[:digit:]]' /etc/redhat-release`
    elif [[ $os == "SLES" ]] || [[ $os=="Ubuntu" ]] || [[ $os == "Debian" ]] || [[ $os == "SUSE" ]]; then
        version=`grep -w "VERSION_ID" /etc/os-release | awk -F = '{print $2}' | tr -d '"'`
    fi
elif [[ $osname == "AIX" ]]
then 
    versiona=$(uname -a|awk '{print $4}')
    versionb=$(uname -a|awk '{print $3}')
    version="$versiona.$versionb"
elif [[ $osname == "SunOS" ]]
then 
    version=$(cat /etc/os-release|grep -i "version=" | awk -F= '{print $2}')
fi
echo $version
)
_select_data(){
    echo "$ipaddr,$xhostname,$osname,$osystemf,$ossystemv" > /tmp/usuarios.txt
    cat /tmp/usuarios.txt 
}

_select_data
