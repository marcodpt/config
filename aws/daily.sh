#!/bin/bash

echo "***** DAILY *****" > /home/ubuntu/daily.log

git --work-tree=/home/ubuntu/config/ --git-dir=/home/ubuntu/config/.git/ pull >> /home/ubuntu/daily.log

for DB in "$@"
do
  /home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup $DB /home/ubuntu/backup/.mysql >> /home/ubuntu/daily.log
  /home/ubuntu/config/scripts/clean.sh -m 7 -d /home/ubuntu/backup $DB >> /home/ubuntu/daily.log
done
