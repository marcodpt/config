#!/bin/bash

echo "***** STARTUP *****"

rawprinter --vendor-id 0x0a5f --device-id 0x000a &
serialscale /dev/ttyUSB0 --lang pt --unit Kg --min-weight 0.01 &
minirps -f /etc/iot/config.toml &
