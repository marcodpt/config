#!/bin/bash

NAME=""
DIR="."
MAX=1

usage() {
  echo "Clean old backups starting with a name."
  echo ""
  echo "Usage: clean.sh [OPTIONS] <NAME>"
  echo ""
  echo "Arguments:"
  echo "  <NAME> The beginning of the name of the backup files. Whereas the rest is used to differentiate the files and the name is in chronological order."
  echo ""
  echo "Options:"
  echo "-d, --dir <DIRECTORY>       The directory location of backup files [default: .]"
  echo "-m, --max <MAX>             The maximum number of files to keep [default: 1]"
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -m|--max)
      MAX=$2
      shift
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
      if [[ $NAME != "" ]]; then
        usage
        exit 1
      fi
      NAME=$1
      shift
      ;;
  esac
done

if [[ $NAME == "" || $MAX -lt 1 || ! -d $DIR ]]; then
  usage
  exit 1
fi

ls -1 $DIR/$NAME* | head -n -$MAX | while read LINE; do rm $LINE ; done
