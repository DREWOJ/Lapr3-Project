#!/bin/bash

ALLOWED_FOLDERS="US110 US111" # US112
flag=0

for d in ./*/; do
  if [ -f $d"Makefile" ] && [[ $ALLOWED_FOLDERS =~ $(basename $d) ]]; then
    cd $d
    make &> /dev/null
    output=$(valgrind -s ./prog 2>&1)
    if echo $output | grep -q "definitely lost"; then
      echo "Memory leak detected in $d"
      flag=1
    fi
    cd ..
  fi
done
if [ $flag -eq 1 ]; then
  exit 1
fi
exit 0

