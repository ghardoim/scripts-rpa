#!/bin/bash

source helper.sh; recursive="-r"
thisscriptname=$(basename $0); dirDestiny="\"C:\Users\\$(whoami)\Documents\""; dirToSearch="\"./\""
function options {
  echo; echo "options:"
  echo "    -n        filename or part of it (mandatory)"
  echo; echo "    -w        directory where you want to look"
  echo "                 default: where it is being executed"
  echo; echo "    -d        where you want to put"
  echo "                 default: users documents"
  echo; echo "    -e        file extension"
  echo; echo "    -f        look only for files"
  echo; echo "    -b        create back-up"
}

while getopts ":n:e:w:d:hfb" flags; do
  case $flags in
  
    n) filename="\"*$OPTARG*"\";;
    e) extension="\"*.$(echo $OPTARG| tr -d -c [:alpha:])\"";;
    w) dirToSearch="\"$OPTARG\"";;
    d) dirDestiny="$OPTARG";;
    f) type="-type f" && recursive="";;
    b) backup="--backup=t";;
    \? | h)
        isUnknownFlag "$flags" $OPTARG; exit=$?
        echo; echo "usage: $thisscriptname [OPTIONS] [ARGS]"
        
        isHelpFlag "$flags" "script to find and paste files in another place"; exit=$?
        options; exit $exit;;
    :)
      echo; echo "$thisscriptname: flag -$OPTARG require 1 argument"
      exit 1;;
  esac
done

files=$(eval "find $dirToSearch -iname $filename$extension $type")
if [ ! "$files" ]; then
  echo; echo "$thisscriptname found no files to copy"
else
  for file in $files; do
    echo; echo "$thisscriptname will go copying $file to destiny: $dirDestiny"
    eval "cp $recursive $backup $file $dirDestiny"
  done
fi