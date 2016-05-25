#!/bin/bash

gateway=`ip route get 8.8.8.8 | head -1 | awk '{print $3}'`
interface=`ip route get 8.8.8.8 | head -1 | awk '{print $5}'`
address=`ip route get 8.8.8.8 | head -1 | awk '{print $7}'`

echo "gateway:   ${gateway}"
echo "interface: ${interface}"
echo "address:   ${address}"
