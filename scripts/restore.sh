#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "You must pass the database name" 2>&1
  exit 1
fi

$FLAGS="--defaults-extra-file=.mysql"

gzip -d last__$1.sql /tmp/$1.sql
mysql $FLAGS -BNe "CREATE DATABASE $1"
mysql $FLAGS $1 < /tmp/$1.sql
