#!/bin/bash

for ferramenta in "$(choco list --local-only)"
do
  choco upgrade $(echo "$ferramenta" | awk -F" " '{ print $1 }') -y
done