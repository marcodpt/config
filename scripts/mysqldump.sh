#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "You must pass the database name" 2>&1
  exit 1
fi

FLAGS="--defaults-extra-file=.mysql"
FLAGS="${FLAGS} --force"
FLAGS="${FLAGS} --opt"
FLAGS="${FLAGS} --databases"
FLAGS="${FLAGS} --routines"
FLAGS="${FLAGS} --set-gtid-purged=OFF"
FLAGS="${FLAGS} --max_allowed_packet=512M"
FLAGS="${FLAGS} --column-statistics=0"

DATE=$(date +"%Y-%m-%dT%H_%M")

mysqldump $FLAGS $1 > $1__$DATE.sql
gzip $1__$DATE.sql
ln -sf $1__$DATE.sql.gz last__$1.sql.gz
