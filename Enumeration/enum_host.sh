#!/bin/bash
target=$1

echo $target

nmap -P0 -sT -sV -O -A --top-ports 2000 -sC -O --script-args=unsafe -oA $target.results.nmap $target
nmap -P0 -sT -sV -O -A -p- -sC -oA $target.results.fullports $target 

/root/scripts/enum_smb.sh $target $target.smb.results
/root/scripts/enum_snmp.sh  $target
nmap -P0 -sU -sV -O -A --top-ports 2000 -sC -O --script-args=unsafe -oA $target.results.udp.nmap $target

