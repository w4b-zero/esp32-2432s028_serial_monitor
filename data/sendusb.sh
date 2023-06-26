#!/bin/bash
PATHS="/"
HOSTNAME=$(hostname)
mkdir -p /home/silly/mylogs
LOGFILE=/home/silly/mylogs/sendusb-`date +%h%d%y`.log
UNAME=$USER
if [[ -z $UNAME ]];
then
UNAME="Crontab"
fi
if [[ -z $2 ]];
then
max=0
else
max=$2-1
fi

touch $LOGFILE

#for path in $PATHS
#do
ANZ=""
if [[ $2 -gt 1 ]]; then
ANZ=0
fi
for ((x=0;x<=max;x++)); do
if [[ $2 -gt 1 ]]; then
ANZ=$((ANZ + 1))
fi
    SERUSB=`usb-devices | grep -c "USB Serial" | awk '{print $1}'`

    CPULOAD=`top -b -n 2 -d1 | grep "CPU(s)" | tail -n1 | awk '{print $2}' |awk -F. '{print $1}'`

if [[ $SERUSB -lt 1 ]]; then
echo "`date "+%F %H:%M:%S"` /dev/ttyUSB0 not online!"
echo "`date "+%F %H:%M:%S"` /dev/ttyUSB0 not online!" >> $LOGFILE
else
        stty -F /dev/ttyUSB0 115200
        if [[ -n $1 && $1 != "clear" ]]; then
            echo -e "`date "+%H:%M:%S"` $1$ANZ" > /dev/ttyUSB0
            echo "`date "+%H:%M:%S"` $UNAME: $1$ANZ\r send!"
            echo "`date "+%H:%M:%S"` $UNAME: $1$ANZ\r send!" >> $LOGFILE

        elif [[ -n $1 && $1 == "clear" ]]; then
#            echo -e "1\r2\r3\r4\r5\r6\r7\r8\r9\r10\r11\r12\r13\r14\r15\r16\r17\r18\r19\r" > /dev/ttyUSB0
            echo -e "\r\r\r\r\r\r\r\r\r\r\r" > /dev/ttyUSB0
            echo -e "\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rclear Screen" > /dev/ttyUSB0
            echo "$UNAME: clear Screen"
            echo "`date "+%H:%M:%S"` $UNAME: clear Screen send!" >> $LOGFILE
 
        elif [[ -z $1 ]]; then
            echo -e "`date "+%H:%M:%S"` CPU:$CPULOAD" > /dev/ttyUSB0
            echo "`date "+%H:%M:%S"` $UNAME: CPU:$CPULOAD\r send!"
            echo "`date "+%H:%M:%S"` $UNAME: CPU:$CPULOAD\r send!" >> $LOGFILE
        fi
    fi
done
#done