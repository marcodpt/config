#!/bin/bash

echo "***** STARTUP *****"

if [[ $(ps -ef | grep rawprinter | wc -l) -gt 1 ]]; then
  kill $(ps -ef | grep rawprinter | head -1 | awk '{print $2}')
fi

if [[ $(ps -ef | grep serialscale | wc -l) -gt 1 ]]; then
  kill $(ps -ef | grep serialscale | head -1 | awk '{print $2}')
fi

if [[ $(ps -ef | grep minirps | wc -l) -gt 1 ]]; then
  kill $(ps -ef | grep minirps | head -1 | awk '{print $2}')
fi

ID=$(lsusb | grep -e Zebra -e ARGOX | awk '{print $6}')
VENDOR=$(echo $ID | awk -F ':' '{print$1}')
DEVICE=$(echo $ID | awk -F ':' '{print$2}')

rawprinter --vendor-id 0x$VENDOR --device-id 0x$DEVICE &
serialscale /dev/ttyUSB0 --lang pt --unit Kg --min-weight 0.01 &
minirps -f /etc/iot/config.toml &

sleep 0.1
