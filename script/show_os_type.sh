#!/bin/bash

if [ -f /etc/redhat-release ]; then
  echo "Centos/Redhat"
  exit
fi

if [ -f /etc/lsb-release ]; then
  echo "Ubuntu"
  exit
fi

echo "Unknown"
