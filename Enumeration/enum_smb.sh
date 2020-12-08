#!/bin/bash

DEST=$1
LOG=$2

echo "SMB Enumeration for $DEST"
enum4linux -r -a -s /usr/share/enum4linux/share-list.txt $DEST > $DEST.enum4linux 2>&1
nmap -sC -vvv -sV -sU -sS --script smb-enum-users,smb-enum-shares,smb-os-discovery,smb-protocols,smb-security-mode,smb-system-info,smb2-capabilities,smb2-security-mode,smb-vuln-ms08-067,smb-vuln-ms10-054,smb-vuln-ms10-061 –script-args=unsafe=1 -p U:137,T:139 $DEST -oA $DEST.smb_nmap1
nmap -sC -sV -Pn -vv -p -p U:137,T:139,T:445 --script='(smb*) and not (brute or broadcast or dos or external or fuzzer)' --script-args=unsafe=1 $DEST -oA $DEST.smb_nmap2
nmap -sV -v -p U:137,T:139,T:445 --script=vuln --script-args=unsafe=1 $DEST -oA $DEST.smb_vulns

nmap -vvv -sV -sU -sS -p U:137,T:139,T:445 --script=vuln,smb-os-discovery,smb-enum-users,smb-enum-shares,smb-os-discovery,smb-protocols,smb-security-mode,smb-system-info,smb2-capabilities,smb2-security-mode,smb-vuln-ms08-067,smb-vuln-ms10-054,smb-vuln-ms10-061 –script-args=unsafe=1 $DEST -oA $DEST.smball

echo "SMB Enumeration finished."
