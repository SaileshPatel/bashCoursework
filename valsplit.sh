#!/bin/bash
# Script name: valsplit.sh
# Author: Sailesh Patel 
# This program checks MIPS assembler code and outputs correct/incorrect syntax into text files


mipsFile=$1
correctFile=$2
incorrectFile=$3

declare -a correctInstructions
declare -a incorrectInstructions

# this function tests whether a mnemonic is valid
function mnemonicTest() {
	case $1 in
		'add' | 'addi' | 'sub' | 'sw' | 'lw' )
			
			;;
		*)
			incorrectInstructions[$a]=${instruction[$a]}}
			;;
	esac
}

# tests the number of parameters after mnemonic
function paramTest() {
	case $1 in
		'add' | 'addi' | 'sub' )
			if [[ $# -eq 4 ]]; then
				correctInstructions[$a]=${instruction[$a]}
			else
				incorrectInstructions[$a]=${instruction[$a]}}	
			fi
			;;
		'sw' | 'lw' )
			if [[ $# -eq 3 ]]; then
				correctInstructions[$a]=${instruction[$a]}
			else
				incorrectInstructions[$a]=${instruction[$a]}}	
			fi			
			;;
		*)
	esac
}

function registerTest() {
	temporaryRegister=t[0-9]
	savedRegister=s[0-7]

	
}

#function immediateTest() {}

#There are three command line arguments required
if [ $# -eq 3 ]; then
	# assigning command line arguments to variables
	a=0
	while read line; 
	do
		# iterating index for array 'instruction'
		a=$((a+1))
		# adding elements to instruction
		instruction[a]=$line
		mnemonicTest ${instruction[$a]}
		paramTest ${instruction[$a]}
		registerTest ${instruction[$a]}
	# while loop finishes once file has ended
	done < $mipsFile
else
	# a message is printed
	echo "These files will not be considered."
	# the program exits
	exit
fi