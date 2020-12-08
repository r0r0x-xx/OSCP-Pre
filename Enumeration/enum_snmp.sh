#!/bin/bash

DEST=$1
echo "SNMP Enumeration for $DEST"
snmp-check -w -r 3 $DEST
snmpwalk -c public -v1 $DEST 
snmpwalk -c public -v2c $DEST 
snmpwalk -c public -v1 $DEST 1.3.6.1.4.1.77.1.2.25
snmpwalk -c public -v1 $DEST 1.3.6.1.2.1.25.4.2.1.2
snmpwalk -c public -v1 $DEST 1.3.6.1.2.1.6.13.1.3
snmpwalk -c public -v1 $DEST 1.3.6.1.2.1.25.6.3.1.2
snmpenum $DEST public /usr/share/snmpenum/cisco.txt
snmpenum $DEST public /usr/share/snmpenum/linux.txt
snmpenum $DEST public /usr/share/snmpenum/windows.txt

hydra -P /usr/share/seclists/Discovery/SNMP/snmp.txt snmp://$DEST -t 4
echo "SNMP Enumeration finished."
