#!/bin/bash

echo "***** STARTUP *****"

kill $(ps -ef | grep rawprinter | head -1 | awk '{print $2}')
kill $(ps -ef | grep serialscale | head -1 | awk '{print $2}')
kill $(ps -ef | grep minirps | head -1 | awk '{print $2}')

rawprinter --vendor-id 0x0a5f --device-id 0x000a &
serialscale /dev/ttyUSB0 --lang pt --unit Kg --min-weight 0.01 &
minirps -f /etc/iot/config.toml &

sleep 0.1
