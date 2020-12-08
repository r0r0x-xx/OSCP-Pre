#!/bin/bash

DEST=$1
LOG=$2

echo "LDAP Enumeration for $DEST"
nmap -p 389,3268 --script ldap-rootdse $DEST
nmap -p 389,3268 --script ldap-search --script-args 'ldap.username="cn=ldaptest,cn=users,dc=cqure,dc=net",ldap.password=ldaptest,ldap.qfilter=custom,ldap.searchattrib="operatingSystem",ldap.searchvalue="Windows *Server*",ldap.attrib={operatingSystem,whencreated,OperatingSystemServicePack}' $DEST
nmap -p 389,3268 --script ldap-search --script-args 'ldap.username="cn=access,cn=users,dc=cqure,dc=htb",ldap.password=ldaptest,ldap.qfilter=users,ldap.attrib=sAMAccountName' $DEST

nmap -p 389,3268 --script ldap-brute --script-args ldap.base='"cn=users,dc=cqure,dc=net"' $DEST
echo "LDAP Enumeration finished."
