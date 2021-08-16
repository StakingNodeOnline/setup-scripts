#!/bin/bash
HARMONY_DIR="harmony"

HMYCLI_LINUX="curl -LO https://harmony.one/hmycli && mv hmycli hmy && chmod +x hmy"
HMYCLI_MAC="curl -O https://raw.githubusercontent.com/harmony-one/go-sdk/master/scripts/hmy.sh"

function harmony_destroy {
	rm -rf $HARMONY_DIR
	echo "harmony directory destroyed."
}

function mac_install {
	mkdir $HARMONY_DIR 
	if [ $? -eq 0 ]
	then 
		cd $HARMONY_DIR
	else 
		echo "Serious error in script. "
		exit -1 
	fi 

	echo "Downloading Harmony CLI tool"
	$HMYCLI_MAC
	chmod u+x hmy.sh 
	./hmy.sh -d 
}

function entry_point {
	if [ $# -eq 2 ]
	then 
		case $2 in 

		mac_install)
			mac_install
			;;
		harmony_destroy)
			harmony_destroy
			;;
		esac
	fi
}



if [ `uname` = "Linux" ]
then 
	echo "Linux"
	$HMYCLI_LINUX
else 
	mac_install
fi 





