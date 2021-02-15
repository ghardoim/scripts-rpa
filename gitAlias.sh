#!/bin/bash

git switch -c $1
git push --set-upstream origin $1

#.gitconfig
#[alias]
#	new-branch = !gitAlias.sh $1