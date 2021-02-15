#!/bin/bash

getmac | less | sed -n 7p | awk -F" " '{ print $1 }'