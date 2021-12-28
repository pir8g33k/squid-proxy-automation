#!/bin/bash

if [ `whoami` != root ]; then
	echo "ERROR: You need to run the script as user root or add sudo before command."
	exit 1
fi

if [ ! -f /usr/bin/htpasswd ]; then
    echo "htpasswd not found"
    exit 1
fi

read -e -p "Enter Proxy username: " proxy_username

if [ -f /etc/squid/passwd ]; then
    /usr/bin/htpasswd /etc/squid/passwd $proxy_username
else
    /usr/bin/htpasswd -c /etc/squid/passwd $proxy_username
fi

if [ ! -f /usr/local/bin/jea-find-os ]; then
    echo "/usr/local/bin/jea-find-os not found"
    exit 1
fi

JEA_OS=$(/usr/local/bin/jea-find-os)

if [ $JEA_OS == "ubuntu2004" ]; then
    systemctl reload squid
elif [ $JEA_OS == "ubuntu1804" ]; then
    systemctl reload squid
elif [ $JEA_OS == "ubuntu1604" ]; then
    service squid restart
elif [ $JEA_OS == "ubuntu1404" ]; then
    service squid3 restart
elif [ $JEA_OS == "debian8" ]; then
    service squid3 restart
elif [ $JEA_OS == "debian9" ]; then
    systemctl reload squid
elif [ $JEA_OS == "debian10" ]; then
    systemctl reload squid
elif [ $JEA_OS == "centos7" ]; then
    systemctl reload squid
elif [ $JEA_OS == "centos8" ]; then
    systemctl reload squid
else
    echo "OS NOT SUPPORTED.\n"
    echo "Contact admin@serverok.in to add support for your os."
    exit 1;
fi
