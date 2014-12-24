#!/bin/bash

usage() {
  echo "Usage: $0 ip1 ip2 ..."
}

export REMOTE_USER=root
export REMOTE_PASSWD=hello123

[ $# -eq 0 ] && usage && exit -1
[ "$1" = "help" -o "$1" = "-h" -o "$1" = "--help" ] && usage && exit 0

[ -f ~/.ssh/id_rsa ] || ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" > /dev/null

which expect > /dev/null 2>&1
[ $? -ne 0 ] && echo "Expect is not available!" && exit -1

for ip in $*
do
  echo -n "Copy ssh public key to ${ip} ...        "
  expect -f `dirname $0`/copy_ssh_key.expect ${ip} ${REMOTE_USER} ${REMOTE_PASSWD} > /tmp/copy_ssh_key.${ip}.log 2>&1
  [ $? -eq 0 ] && echo "[   OK   ]" || echo "[ FAILED ]"
done
