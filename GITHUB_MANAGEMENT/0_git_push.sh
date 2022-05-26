#!/bin/bash
#Script made by helperchoi@gmail.com
SCRIPT_VERSION=0.1.20220603
DESCRIPTION="github Source Commit & Push Script"

export LANG=C
export LC_ALL=C

declare -a ARRAY_ERROR_RESULT

if [ $# -ne 1 ]
then
	echo
	echo "### 1. Create Source List File ###"
	echo "### 2. Please Input List File ###"
	echo
	echo "vi source.list"
	echo
	echo "./git_push.sh"
	echo "./SYSTEM_MANAGEMENT/use_swap.sh"
	echo "./SYSTEM_CHECK/check_os.sh"
	echo
	echo "Usage ex) : $0 source.list"
	echo
	exit 1
fi

### Git Repo Sync ###
echo
echo "[INFO] Git Repo Sync"
git pull origin main

### VERIFY LIST FILE ###

if [ -e $1 ]
then
	### VERIFY SOURCE FILE ###
	
	VERIFI_CHECK=0
	LIST_FILE=`cat $1`

	echo
	for LIST in ${LIST_FILE}
	do
		if [ ! -e ${LIST} ]	
		then
			ARRAY_ERROR_RESULT=("${ARRAY_ERROR_RESULT[@]}" "`echo "No such file or directory : ${LIST}"`")
			VERIFI_CHECK=1
		fi
	done
	echo

	if [ ${VERIFI_CHECK} -eq 0 ]
	then
		### Git Add Source ###
		LIST_FILE=`cat $1`

		for LIST in ${LIST_FILE}
		do
			git add ${LIST}
		done

		### Git Commit & Push ###
		echo 
		echo "[INFO] Please Input Commit Messages"
		read MSG
		echo

		COMMIT_MSG=$MSG

		if [ -z "${COMMIT_MSG}" ]
		then
			echo
			echo "[ERROR] Not Input Commit Messages"
			echo
			exit 1
		else
			git commit -m "${COMMIT_MSG}"

			echo
			echo "[INFO] Git Push"
			git push -u origin main
		fi

	else
		echo 
		echo "[ERROR]"
		printf "%s\n" "${ARRAY_ERROR_RESULT[@]}"
		echo
		exit 1
	fi

else
	echo
	echo "[ERROR] No such file or directory : $1"
	echo
	exit 1
fi
