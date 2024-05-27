#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Necessario ser usuario root" 2>&1
  exit 1
fi

rm -f /usr/bin/serialscale
rm -f /usr/bin/rawprinter
rm -f /usr/bin/minirps
rm -f /etc/rc.local
rm -rf /opt/iot
