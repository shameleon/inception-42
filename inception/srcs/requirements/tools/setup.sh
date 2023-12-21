#!/bin/bash

# ANSI escape code
GR='\033[1;32m'
YL='\033[0;33m'
BL='\033[1;34m'
CY='\033[0;36m'
NC='\033[0m'

#############################################################
# Checking /etc/hosts file for 127.0.0.1
# and changing localhost to domain name
# only if 127.0.0.1 is at the first lines of the file
#############################################################
target='/etc/hosts'
localhost="localhost"
domain="jmouaike.42.fr"
domain2="www.jmouaike.42.fr"
dns=$(cat $target | awk '$1 ~ /^127.0.0.1/ { print $2 }')
dns2=$(cat $target | awk '$1 ~ /^127.0.0.1/ { print $3 }')
line=$(cat /etc/hosts | grep -n "^127.0.0.1" | awk '{print $1}' | cut -d : -f 1)

echo -e "${CY}⣿⣿⣿ setup.sh ⣿⣿⣿${NC}"
if [[ "$dns" = "$localhost" ]]; then
    sudo sed -i '1s/'"$localhost"'/'"$domain $domain2"'/' "$target"
    dns=$(cat $target | awk '$1 ~ /^127.0.0.1/ { print $2 }')
    dns2=$(cat $target | awk '$1 ~ /^127.0.0.1/ { print $3 }')
fi
if [[ "$dns" = "$domain" ]]; then
    echo -e "Domain${GR} [ok] ${YL} $dns $dns2${NC}"
fi