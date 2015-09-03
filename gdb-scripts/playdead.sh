#!/bin/bash
#
# Playdead - Bangcle generic unpacking script
#
# Tim 'diff' Strazzere <strazz@gmail.com>
#
# Assumptions made:
#  - there is only one device running for adb to connect to (target device)
#  - folder named framework/ is full of /system/framework/ files from target device
#  - target device have root access (emulator is best and verified)
#  - target apk is installed
#  - target apk is currently running
#  - baksmali and smali are located in ~/bin/*
#
# Works on a year+ old sample and one found as recenty as today (7/16/04)
# Older samples may require a 4.3 or lower device, new samples appear to work on
# 4.4 well
#

PACKAGE=$1
ODEX_MAGIC='dey\n036'
SERVICE_PID=`adb shell ps | grep $PACKAGE | head -1 | tr -s ' ' | cut -d ' ' -f 2`

get_memory_address() {
    last_line=''
    CLONE=$(get_clone)

    adb shell su -c cat /proc/$SERVICE_PID/maps | while read line
    do
	if [[ $line != */* ]]
	then
	    MEM_LINE=$line
            MEM_LINE=`echo -n $MEM_LINE | cut -c1-17`
            MEMORY_START=`echo -n $MEM_LINE | cut -d'-' -f1`
            PEEKED=$(peek_memory)

            # Found a candidate
            if [[ "$PEEKED" = "$ODEX_MAGIC" ]]
            then
		echo `echo -n $MEM_LINE`
		break
	    fi
	fi
    done
}

get_clone() {
    retained_return=$(adb shell ls /proc/$SERVICE_PID/task/ | tail -1)
    echo ${retained_return}
}

dump_memory() {
    echo $(adb shell su -c /data/local/tmp/gdb --batch --pid $CLONE -ex "dump memory /data/local/tmp/dump.odex 0x$MEMORY_START 0x$MEMORY_END")
}

peek_memory() {
    echo $(adb shell su -c /data/local/tmp/gdb --batch --pid $CLONE -ex "x/s 0x$MEMORY_START" | cut -d'"' -f2 | cut -c1-8 | tail -1)
}

if [[ $SERVICE_PID != '' ]]
then
    echo "Attempting to find memory address for $PACKAGE inside $SERVICE_PID"
    MEM_LINE=$(get_memory_address)

    if [[ $MEM_LINE ]]
    then
	echo "Found optimized dex at $MEM_LINE"
	MEMORY_START=`echo -n $MEM_LINE | cut -d'-' -f1`
	MEMORY_END=`echo -n $MEM_LINE | cut -d'-' -f2`
	CLONE=$(get_clone)
	if [[ $CLONE ]]
	then
	    echo "Got clone $CLONE attempting to dump memory from 0x$MEMORY_START to 0x$MEMORY_END"
	    blah=$(dump_memory)
	    if [[ $blah ]]
	    then
		echo "Pulling dumped file..."
		adb pull /data/local/tmp/dump.odex
		adb shell rm /data/local/tmp/dump.odex
		echo "Deodexing..."
		java -jar ~/bin/baksmali-2.0.3.jar -x dump.odex -d framework/ -o temp-smali
		echo "Re-dexing..."
		java -jar ~/bin/smali-2.0.3.jar temp-smali -o debangcled.dex
		echo "Cleaning up..."
		rm -rf temp-smali/ dump.odex
	    fi
	fi
    else
	echo 'Unable to find memory region to dump!'
    fi
else
    echo "Unable to find pid for $PACKAGE"
fi
