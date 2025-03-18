#!/bin/bash

source ./utils/helper.sh

function options {
  echo; echo "options:"
  echo "    -n        new nickname (mandatory)"
  echo; echo "    -o        old nickname (mandatory)"
}

while getopts ":o:n:h" flags; do
  case $flags in
  
  o) oldName=$OPTARG;;
  n) newName=$OPTARG;;
  \? | h)
        isUnknownFlag "$flags" $OPTARG; exit=$?
        echo; echo "usage: $thisscriptname [OPTIONS] [ARGS]"
        
        isHelpFlag "$flags" "script to change your nickname in urls of git remote branches"; exit=$?
        options; exit $exit;;
    :)
      echo; echo "$(basename $0): flag -$OPTARG require 1 argument"
      exit 1;;
  esac
done

oldUrl=$(git remote get-url origin)
newUrl=$(echo ${oldUrl/"$oldName"/"$newName"})
git remote set-url origin $newUrl