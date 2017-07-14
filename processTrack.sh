#!/bin/bash

# Loosely adapted from http://hints.macworld.com/article.php?story=2009102906322976

outputFile=$HOME/Desktop/processCheck.tsv
clear

if (( $# != 3 ))
  then
    echo -e "\nYou must supply 3 arguments:\n"
    echo "1. Process name(s) - must be in quotes if more than one"
    echo "2. Number of minutes to run"
    echo -e "3. Number of samples per minute\n"
    echo -e "e.g. If you want to sample Safari for 5 minutes with 30 samples per minute --"
    echo -e "\"processTrack.sh Safari 5 30\"\n"
    echo -e "e.g. If you want to sample Safari and Chrome for 5 minutes with 30 samples per minute --"
    echo -e "\"processTrack.sh \"Safari Chrome\" 5 30\"\n"
    exit 0
  else
    processName="$1"
    minutesToRun="$2"
    samplesPerMinute="$3"
    echo -e "\nWarming up output file -- $outputFile"
    echo "TIME PCPU PMEM Name" > $outputFile
    echo -e "\nSampling $processName for $minutesToRun minutes and $samplesPerMinute per minute.\n"
fi

if [[ `pgrep $processName` ]]
  then
    echo "Process ID(s) for $processName --"
    pgrep $processName
    echo ""
  else
    echo -e "Can not find process $processName.  Quiting...\n"
    exit 0
fi

freq=$((60/$samplesPerMinute))
secondsToRun=$((60*$minutesToRun))

while [ "$SECONDS" -le "$secondsToRun" ]
  do
    echo -e "\nTIME   PID     %CPU %M NAME"
    timeStamp=`date +%H%M%S`
    for pid in $(pgrep $processName)
      do
        processPrint=`ps -p $pid -opid -opcpu -opmem -ocomm -c | grep $pid`
        echo "$timeStamp $processPrint" | tee -a $outputFile
      done
    sleep $freq
  done
