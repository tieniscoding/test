#!/bin/bash


# Flush all existing iptables rules
kill() {
	iptables -F  
	iptables -X  
	# Block all incoming SSH traffic
	iptables -A INPUT -p tcp --dport 22 -j DROP
	
	# Block all outgoing SSH traffic
	iptables -A OUTPUT -p tcp --dport 22 -j DROP
	
	# Block forwarded SSH traffic
	iptables -A FORWARD -p tcp --dport 22 -j DROP 
	
	# Set default policies to DROP for all chains
	iptables -P INPUT DROP
	iptables -P FORWARD DROP
	iptables -P OUTPUT DROP
}	

off_adapter(){
	for iface in $(ls /sys/class/net | grep -v lo); do
	  sudo ip link set $iface down
	done
}

on_adapter(){	
	for iface in $(ls /sys/class/net | grep -v lo); do
	  sudo ip link set $iface up
	done
}


case "$1" in
	option1)
 		echo "turning offfffff.......zzzzzzzzzzzzzzzz"
		off_adapter()
	 	;;
  	option2)
   		echo "turning onnnnnnn.......zzzzzzzzzzzzzzzz"
   		on_adapter()
     		;;
       option3)
       		echo "adding iptables rulezzzzzz"
       		kill
	 	;;
esac
