#!/bin/bash

echo "***** DAILY *****" > /home/ubuntu/daily.log

git --work-tree=/home/ubuntu/config/ --git-dir=/home/ubuntu/config/.git/ pull >> /home/ubuntu/daily.log

/home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup db01 /home/ubuntu/backup/.mysql >> /home/ubuntu/daily.log
/home/ubuntu/config/scripts/clean.sh -m 35 -d /home/ubuntu/backup db01 >> /home/ubuntu/daily.log

/home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup db02 /home/ubuntu/backup/.mysql >> /home/ubuntu/daily.log
/home/ubuntu/config/scripts/clean.sh -m 35 -d /home/ubuntu/backup db02 >> /home/ubuntu/daily.log
