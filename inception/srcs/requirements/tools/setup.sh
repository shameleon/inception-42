#!/bin/bash

echo "/etc/hosts"
cat /etc/hosts | grep 127.0.0.1

mkdir -p ./srcs/logs/nginx
sudo chmod 777 ./srcs/logs/nginx/*