#!/bin/bash

# verifica_ip nume ip server_dns
verifica_ip() {
  nume="$1"
  ip="$2"
  dns="$3"
  real=$(nslookup "$nume" "$dns" | grep '^Address' | sed -n 2p | awk '{print $2}')
  if [ "$real" != "$ip" ]; then
    echo "Bogus IP for $nume in /etc/hosts!"
  fi
}

cat /etc/hosts | grep -v '^#' | while read ip nume rest
do
  if [ -z "$nume" ] || [ "$nume" = "localhost" ]; then
     continue
  fi
  verifica_ip "$nume" "$ip" "8.8.8.8"
done
echo "Mihu Darius"
