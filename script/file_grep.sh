#!/bin/bash

usage() {
  echo "Print all lines in fileB which match any line in fileA."
  echo "Blank line is ignored in fileA."
  echo ""
  echo "Usage:"
  echo "  ${0} fileA fileB"
  echo ""
}

if [ "$1" = "help" -o "$1" = "-h" -o "$1" = "--help" ]; then
  usage
  exit 0
fi

if [ $# -ne 2 ]; then
  usage
  exit -1
fi

for file in $*
do
  if [ ! -f $file ]; then
    echo "Error: File '$file' not exist." 1>&2
    exit -1
  fi
done

while read lineA
do
  [ "${lineA}" = "" ] && continue
  grep ${lineA} $2
done < ${1}

exit 0
