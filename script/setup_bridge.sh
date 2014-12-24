#!/bin/bash

usage() {
  echo "Usage: $0 br_name"
}

[ $# -ne 1 ] &&	usage && exit 1
[ "$1" = "help" -o "$1" = "-h" -o "$1" = "--help" ] && usage && exit 0

dst=$1

ifconfig $dst > /dev/null 2>&1
err=$?
if [ $err -eq 0 ]; then
	echo 2
	exit 2
fi

src=$(route | grep default | awk '{print $8}') &&
gw=$(route | grep default | awk '{print $2}')
err=$?
if [[ $err != 0 || ! -n $src || ! -n $gw ]]; then
	echo 3
	exit 3
fi

ifconfig $src > /dev/null 2>&1
err=$?
if [ $err != 0 ]; then
	echo 4
	exit 4
fi

ip=$(ifconfig $src | grep 'inet ' | awk -F"[: ]+" '{print $4}')
mask=$(ifconfig $src | grep 'inet ' | awk -F"[: ]+" '{print $8}')
mac=$(ifconfig $src | grep $src | awk '{print $5}')

if [[ ! -n $ip || ! -n $mask || ! -n $mac ]]; then
	echo 5
	exit 5
fi 

brctl addbr $dst &&
ifconfig $dst up &&
ifconfig $dst hw ether $mac &&
brctl addif $dst $src &&
ifconfig $src 0 &&
ifconfig $dst $ip netmask $mask &&
route add default gw $gw $dst

err=$?
if [ $err != 0 ]; then
	echo 6
	exit 6
fi

echo 0
exit 0
