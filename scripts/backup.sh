#!/bin/bash

COMPRESS=0
CONN=""
DB=""
DIR="."

usage() {
  echo "Backup a mysql or sqlite3 database."
  echo ""
  echo "Usage: backup.sh [OPTIONS] <DATABASE> [CONNECTION]"
  echo ""
  echo "Arguments:"
  echo "  <DATABASE> The database name in the case of mysql or the database path in the case of sqlite3."
  echo ""
  echo "  [CONNECTION] Connection file to mysql, if not passed it will use sqlite3."
  echo ""
  echo "[client]"
  echo "user=<USER>"
  echo "password=<PASS>"
  echo "host=<HOST>"
  echo ""
  echo "Options:"
  echo "-d, --dir <DIRECTORY>       The directory location of backup files [default: $DIR]"
  echo "-c, --compress              Compress the file after the backup finishes."
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -c|--compress)
      COMPRESS=1
      shift
      ;;
    -d|--dir)
      DIR="$2"
      shift
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      if [[ $DB == "" ]]; then
        DB="$1"
      elif [[ $CONN == "" ]]; then
        CONN="$1"
      else
        usage
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ ! -d $DIR ]]; then
  usage
  exit 1
fi

DATE=$(date +"%Y-%m-%dT%H_%M")

if [[ $CONN == "" ]]; then
  if [[ ! -f $DB ]]; then
    usage
    exit 1
  fi
  FILE="$DIR/$(basename $DB)__$DATE"
  sqlite3 $DB ".backup '$FILE'"
else
  if [[ ! -f $CONN ]]; then
    usage
    exit 1
  fi
  FLAGS="--defaults-extra-file=$CONN"
  FLAGS="$FLAGS --force"
  FLAGS="$FLAGS --opt"
  FLAGS="$FLAGS --databases"
  FLAGS="$FLAGS --routines"
  FLAGS="$FLAGS --set-gtid-purged=OFF"
  FLAGS="$FLAGS --max_allowed_packet=512M"
  FLAGS="$FLAGS --column-statistics=0"

  FILE="$DIR/${DB}__$DATE.sql"
  mysqldump $FLAGS $DB > $FILE
fi

if [[ $COMPRESS -ne 0 ]]; then
  gzip $FILE
fi
