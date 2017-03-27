#!/bin/bash
#Script name: valsplit.sh
#Author: Sailesh Patel 
#This program checks MIPS assembler code and outputs correct/incorrect syntax into text files
#There are three command line arguments required

if [ $# -ne 3 ]; then
	echo "These files will not be considered."
fi

# assigning command line arguments to variables
mipsFile=$1
correctFile=$2
incorrectFile=$3

# work out what to do with this? 
mnemonicTest( ){
	mnu[0]='add'
	mnu[1]='sub'
	mnu[2]='addi'
	mnu[3]='lw'
	mnu[4]='sw'
}


# code currently just loops through file
a=0
while read line; 
do
	# goes through each line
	a=$((a+1))
	echo "MIPS $a: $line";
done < $1
