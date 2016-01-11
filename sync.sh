#!/bin/bash

function FetchMergePush {

	cd $1
	shift

	/usr/bin/git fetch upstream

	BRANCHES=$@

	for BRANCH in $BRANCHES ; do
		/usr/bin/git checkout ${BRANCH}
		/usr/bin/git merge -m "Merge upstream/${BRANCH}" upstream/${BRANCH}
		/usr/bin/git push
		#Create "ar" release when first of month
		if [ $(date '+%d') -eq "01" ] ; then
			/usr/bin/git tag -a ${BRANCH}_ar_$(date "+%Y%m")00 -m "Apertoso Release"
			/usr/bin/git push --tags	
		fi
	done

}

FetchMergePush /home/github/odoo 8.0 9.0 master
FetchMergePush /home/github/odoo-enterprise 9.0 master


