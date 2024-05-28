#!/bin/bash

BACKUP=""
TARGET=""

usage() {
  echo "Restore a mysql or sqlite3 database."
  echo ""
  echo "Usage: restore.sh <BACKUP> [OUTPUT] [CONNECTION]"
  echo ""
  echo "Arguments:"
  echo "  <BACKUP> The backup file generated with backup.sh"
  echo ""
  echo "  [OUTPUT] An optional output for a sqlite3 database, if the file already exists it will be treated as a mysql [CONNECTION] file."
  echo ""
  echo "  [CONNECTION] Connection file to mysql, if not passed it will use sqlite3."
  echo ""
  echo "[client]"
  echo "user=<USER>"
  echo "password=<PASS>"
  echo "host=<HOST>"
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      if [[ $BACKUP == "" ]]; then
        BACKUP="$1"
      elif [[ $TARGET == "" ]]; then
        TARGET="$1"
      else
        usage
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ $BACKUP == "" || ! -f $BACKUP ]]; then
  usage
  exit 1
fi

FILE=$(basename $BACKUP)
EXT="${FILE##*.}"
FILE="${FILE%%.*}"
FLAGS=""
DB="${FILE%%__*}"

ALT="$TARGET/$DB"
if [[ $TARGET != "" && -d $TARGET ]]; then
  if [[ -e $ALT ]]; then
    echo "[$ALT] already exists!"
    exit 1
  fi
  TARGET=$ALT
fi

if [[ $TARGET != "" && -e $TARGET && ! -f $TARGET ]]; then
  usage
  exit 1
fi

if [[ $TARGET != "" && ! -e $TARGET ]]; then
  DB=$TARGET
fi

if [[ -e $DB && ! -f $TARGET ]]; then
  echo "[$DB] already exists!"
  exit 1
fi

if [[ $TARGET != "" && -f $TARGET ]]; then 
  FLAGS="--defaults-extra-file=$TARGET"

  mysql $FLAGS -BNe 'SHOW DATABASES' | while read LINE
  do
    if [[ $LINE == $DB ]]; then
      exit 1
    fi
  done
  if [[ $? -eq 1 ]]; then
    echo "Database [$DB] already exists!"
    exit 1
  fi
fi

if [[ $EXT == "gz" ]]; then
  if [[ -e $DB ]]; then
    echo "[$DB] already exists!"
    exit 1
  fi
  gzip -d -c $BACKUP > $DB
  BACKUP=$DB
fi

if [[ -f $TARGET ]]; then
  mysql $FLAGS -BNe "CREATE DATABASE $DB"
  mysql $FLAGS $DB < $BACKUP

  if [[ -f $DB && $BACKUP == $DB ]]; then
    rm $DB
  fi
elif [[ $BACKUP != $DB ]]; then 
  cp $BACKUP $DB
fi
