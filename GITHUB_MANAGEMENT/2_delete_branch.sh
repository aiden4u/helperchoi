#!/bin/bash
#Script made by helperchoi@gmail.com
SCRIPT_VERSION=0.1.20220610
DESCRIPTION="github PR branch Delete."

export LANG=C
export LC_ALL=C

### Git Repo Sync ###
echo
echo "[INFO] Github PR Branch Delete : pr_branch"

git pull origin main

git checkout main

git branch -D pr_branch

git push --delete origin pr_branch

git pull origin main
