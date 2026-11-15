#!/bin/bash

cat /etc/hosts | grep -v '^#' | while read ip nume rest
do
  if [ -z "$nume" ] || [ "$nume" = "localhost" ]; then
     continue
  fi
  real=$(nslookup $nume | grep '^Address' | sed -n 2p | awk '{print $2}')
  if [ "$real" != "$ip" ]; then
   echo "Bogus IP for $nume in /etc/hosts!"
  fi
done 
