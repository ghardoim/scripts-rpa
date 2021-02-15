#!/bin/bash

thisscriptname=$(basename $0)
while getopts ":u:h" flags; do
  case $flags in
    u)
      git init && git remote add origin $OPTARG
      git pull origin main && git push origin main -u
      git remote get-url origin
      exit ;;
    \? | h)
      source helper.sh; isUnknownFlag "$flags" $OPTARG; exit=$?
      echo; echo "usage: $thisscriptname [OPTIONS] [ARGS]"
      source helper.sh; isHelpFlag "$flags" "script to sincronize this directory with the url passed"; exit=$?
      echo; echo "options:"
      echo "    -u        url repository (mandatory)"
      echo; echo "    -h        show this help"
      exit $exit ;;
    :)
      echo; echo "$thisscriptname: flag -$OPTARG require 1 argument"
      exit 1 ;;
  esac
done
echo; echo "$thisscriptname: require flag -u with 1 argument"
exit 1