#!/bin/bash
#Script name: valsplit.sh
#Author: Sailesh Patel 
#This program checks MIPS assembler code and outputs correct/incorrect syntax into text files
#There are three command line arguments required

if [ $# -ne 3 ]; then
	echo "These files will not be considered."
fi

mipsFile=$1
correctFile=$2
incorrectFile=$3