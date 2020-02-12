#!/bin/bash
# Roku API tool
# This tool sends requests to the roku streaming device API via ECP (external control protocol). It can effectively control any roku device on the local network. To find roku devices, just scan for port 8060 using nmap or ncat.

roku_host="" # IP or hostname of roku device

usage() {
	echo -e "usage: $0 <command>\nCommands:\n\tapplist - get list of installed apps\n\tactiveapp - shows app currently being used\n\tinfo - shows info about device\n\tlaunchapp <appid> - launch app specified by appID\n\tlockdown - keeps roku on the home screen"
	exit
}

# Function sends a GET request to the roku on port 8060 (ECP) to request a resource.
# GET requests usually request information from the roku, for example the app list.
send_get() {
    resource=$1 # Format: example/resource
    
    if test -z $resource; then
	    echo "[!] error in 'send_get' function: resource var not set"
	    exit
    fi

    echo "[*] Sent request"
    request=`wget -O - -q http://$roku_host:8060/$resource`
    echo "[*] Response received"
    sleep 1
    echo $request
}

# Function sends a POST request to roku on port 8060 (ECP) to request a resource.
# POST requests to the API are typically for controlling the roku. Like pressing buttons.
send_post() {
    resource=$1 # Format: example/resource
    
    if test -z $resource; then
	    echo "[!] error in 'send_post' function: resource var not set"
	    exit
    fi

    echo "[*] Sent request"
    request=`wget -O - -q --post-data="" http://$roku_host:8060/$resource`
    echo "[*] Command successful"
    sleep 1
    echo $request
}

# Evalutate command line argument count
if test $# == 0; then
	echo "error: at least one argument required"
	usage
fi

# Make sure roku_host variable is set
if test -z $roku_host; then
	echo "error: variable roku_host not set"
	exit 1
fi

case $1 in
	"applist")
		send_get query/apps
		;;
	"activeapp")
		send_get query/active-app
		;;
	"info")
		send_get query/active-app
		;;
	"launchapp")
		send_post launch/$2
		;;
	"lockdown")
		while true
		do
			echo "[*] Keeping user on home screen"
			send_post keypress/Home
			sleep 3
		done
		;;
	*)
		usage
esac
