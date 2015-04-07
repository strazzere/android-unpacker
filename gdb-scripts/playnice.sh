#!/bin/bash
#
# Playnice - SecShell generic unpacking script
#
# Dwayne Yuen
#
# Functions almost identically to the playdead bangcle unpacker, with some minor differences
# - searches for a dex header instead of odex
# - uses gdb find to find the dex header
#
# Requires gdb to be in /data/local/tmp
#

PACKAGE=$1
DEX_MAGIC='dex\n035'
FOUND_STR='pattern found.'
SERVICE_PID=`adb shell "ps" | grep $PACKAGE | head -1 | tr -s ' ' | cut -d ' ' -f 2`
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

if [[ $SERVICE_PID != '' ]]
then
    echo "Attempting to find memory address for $PACKAGE inside $SERVICE_PID"
    CLONE=$(adb shell su -c "ls /proc/$SERVICE_PID/task/" | tail -1 | tr -d "\r")
    echo "Found clone pid at $CLONE"

    for line in $(adb shell su -c "cat /proc/$CLONE/maps"); do
	if [[ $line != */* ]]
	then
	    MEM_LINE=$line
            MEM_LINE=`echo -n $MEM_LINE | cut -c1-17`
            MEMORY_START=`echo -n $MEM_LINE | cut -d'-' -f1`
            MEMORY_END=`echo -n $MEM_LINE | cut -d'-' -f2`

            echo "Searching 0x$MEMORY_START - 0x$MEMORY_END for \"$DEX_MAGIC\""
            FOUND=($(adb shell su -c "/data/local/tmp/gdb --batch --pid $CLONE -ex 'find 0x$MEMORY_START, 0x$MEMORY_END, \"$DEX_MAGIC\"'" | tail -2))

            # Search for "pattern found"
            echo ${FOUND[1]} | grep -q $FOUND_STR
            if [[ $? -eq 0 ]]; then
		DEX_START=$(echo ${FOUND[0]} | tr -d "\r")
		break
            fi
	fi
    done


    if [ -n "$DEX_START" ]
    then
	    echo "Found dex at $DEX_START"
	    if [ -n "$CLONE" ]
	    then
	        echo "Got clone $CLONE attempting to dump memory from $DEX_START to 0x$MEMORY_END"
	        blah=$(adb shell su -c "/data/local/tmp/gdb --batch --pid $CLONE -ex 'dump memory /data/local/tmp/dump.dex $DEX_START 0x$MEMORY_END'")
	        if [[ $blah ]]
	        then
		        echo "Pulling dumped file..."
		        adb pull /data/local/tmp/dump.dex
		        adb shell rm /data/local/tmp/dump.dex
	        fi
	    fi
    else
	    echo 'Unable to find memory region to dump!'
    fi
else
    echo "Unable to find pid for $PACKAGE"
fi

IFS=$SAVEIFS
