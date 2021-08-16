#!/bin/bash
function checkIfError {
	if [ $1 -ne 0 ]
	then
		echo "Error in running script in `$2`".
		echo "Aboritng..."
		exit -1
	fi
}
function createUser {
	adduser $1
	checkIfError $? "createUser"
        usermod -aG sudo $1
	checkIfError $? "createUser"
 }
  
 function checkUser {
 	 echo "Switching to user."
 	su - $1
 }


if [ $# = 0 ]
then
	echo "usage: ./addSudoer.sh <userName>"
	echo "Do you continue step by step.(y/n)?"
       	read response
	
	if [ $response == "n" ]
	then
		echo "Thank you for using script."
		exit -1
	else 
		echo "Type username:"
		read username
		createUser $username	
	fi
fi

if [ $# == 1 ]
then
	createUser $1
fi
