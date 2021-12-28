#!/bin/bash

if [ `whoami` != root ]; then
	echo "ERROR: You need to run the script as user root or add sudo before command."
	exit 1
fi

if [ ! -f /usr/local/bin/jea-find-os ]; then
    echo "/usr/local/bin/jea-find-os not found"
    exit 1
fi

JEA_OS=$(/usr/local/bin/jea-find-os)

if [ $JEA_OS == "ubuntu2004" ]; then
    /usr/bin/apt -y remove --purge squid3
    rm -rf /etc/squid/
elif [ $JEA_OS == "ubuntu1804" ]; then
    /usr/bin/apt -y remove --purge squid3
    /bin/rm -rf /etc/squid/
elif [ $JEA_OS == "ubuntu1604" ]; then
    /usr/bin/apt -y remove --purge squid3
    /bin/rm -rf /etc/squid3/
    /bin/rm -rf /etc/squid/
elif [ $JEA_OS == "ubuntu1404" ]; then
    /usr/bin/apt remove --purge squid3 -y
    /bin/rm -rf /etc/squid3/
    /bin/rm -rf /etc/squid/
elif [ $JEA_OS == "debian8" ]; then
    echo "Uninstalling Squid Proxy on Debian 8"
    /usr/bin/apt -y remove --purge squid
    /bin/rm -rf /etc/squid3/
    /bin/rm -rf /etc/squid/
elif [ $JEA_OS == "debian9" ]; then
    echo "Uninstalling Squid Proxy on Debian 9"
    /usr/bin/apt -y remove --purge squid
    /bin/rm -rf /etc/squid/
    /bin/rm -rf /var/spool/squid
elif [ $JEA_OS == "debian10" ]; then
    echo "Uninstalling Squid Proxy on Debian 10"
    /usr/bin/apt -y remove --purge squid squid-common squid-langpack
    /bin/rm -rf /etc/squid/
    /bin/rm -rf /var/spool/squid
elif [ $JEA_OS == "centos7" ]; then
    yum remove squid -y
    /bin/rm -rf /etc/squid/
elif [ $JEA_OS == "centos8" ]; then
    yum remove squid -y
    /bin/rm -rf /etc/squid/
else
    echo "OPERATING SYSTEM NOT SUPPORTED.\n"
    echo "Contact us to add support for your os."
    exit 1;
fi

rm -f /usr/local/bin/squid-add-user > /dev/null 2>&1

echo 
echo 
echo "Squid Proxy uninstalled."
echo "Thank you for using squid proxy installer"
echo 