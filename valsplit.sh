#!/bin/bash
# Script name: valsplit.sh
# Author: Sailesh Patel
# This program checks MIPS assembler code and outputs correct/incorrect syntax into text files

declare -a correctInstructions
declare -a incorrectInstructions

mipsFile=$1
correctFile=$2
incorrectFile=$3

# this function tests whether a mnemonic is valid
function mnemonicTest() {
	case $1 in
		# if $1 equals any of these mnemonics
		'add' | 'addi' | 'sub' | 'sw' | 'lw' )
				correctInstructions[$a]=${instruction[$a]}
			;;
		*)
				echo ${instruction[$a]} >> $incorrectFile
				echo ${instruction[$a]}
				echo "Please use a correct mnemonic."
		;;
	esac
}

# tests the number of parameters after mnemonic
function paramTest() {
	# if $1...
	case $1 in
		# is one of these mnemonics
		'add' | 'addi' | 'sub' )
			# if the number of argument is 4
			if [[ $# -eq 4 ]]; then
				# add to correct instructions
				correctInstructions[$a]=${instruction[$a]}
			else
				# echo the instruction
				echo ${instruction[$a]} >> $incorrectFile
				echo ${instruction[$a]}
				# echo message
				echo "Please use three parameters."
			fi
			;;
		# is one of these mnemonics
		'sw' | 'lw' )

			if [[ $# -eq 3 ]]; then
				correctInstructions[$a]=${instruction[$a]}
			else
				echo ${instruction[$a]} >> $incorrectFile
				echo ${instruction[$a]}
				echo "Please use two parameters."
			fi
			;;
	esac
}


regTest() {
		# Using regular expression to check if it meets a MIPS register format
		sOrTCheck='\$(s|t).*'
		# Using a regular expression to see if it is an stored instruction
    signCheck='\$s.*'
		# Using an regular expression to see if the format meets the number range
    rangeCheck='\$(s[0-7]$|t[0-9]$)'
		# starts by checking if the register does not starts with s or t
		if [[ ! $1 =~ $sOrTCheck ]];then
						# echos a message with the argument
						echo "Incorrect register name $1. Use s or t"
						# echos the entire instruction
						echo ${instruction[$a]}
		# if the condition has been met
		else
						# if the argument does not meet the regular expression
						if [[ ! $1 =~ $signCheck ]];then
							# stores mesage with correct values
							registerMsg="Temporary registers are numbered 0 to 9"
						else
							# stores message with correct values
							registerMsg="Stored registers are numbered 0 to 7"
						fi

						# if the argument does not meet the range of numbers
						if [[ ! $1 =~  $rangeCheck ]]; then
							# echo message with string
							echo "Incorrect register number $1. $registerMsg"
							echo ${instruction[$a]}
						fi

		fi
}

function registerTest() {
	case $1 in
		'add' | 'sub')
			for params in $2 $3 $4 ; do
				regTest $params
			done
			;;
		'addi')
			for params in $2 $3; do
				regTest $params
			done
			;;
		'lw' | 'sw')
			for params in $2; do
				regTest $params
			done
			;;
	esac
}

#function immediateTest() {} #-?[0-9][0-9]

#There are three command line arguments required
if [ $# -eq 3 ]; then
	# declaring the instruction array
	declare -a instruction
	# assigning command line arguments to variables
	a=0
	index=1
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
