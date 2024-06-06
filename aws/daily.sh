#!/bin/bash

echo "***** DAILY *****"

git --work-tree=/home/ubuntu/config/ --git-dir=/home/ubuntu/config/.git/ pull

for DB in "$@"
do
  /home/ubuntu/config/scripts/backup.sh -c -d /home/ubuntu/backup $DB /home/ubuntu/backup/.mysql
  /home/ubuntu/config/scripts/clean.sh -m 8 -d /home/ubuntu/backup $DB
done
