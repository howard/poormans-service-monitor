#!/bin/bash

# Argument 1 is the target URL
# Argument 2 is the acceptable status code
# Argument 3 is a command executed in case of not matching status

TARGET=$1
TARGET_SANITIZED=`echo $TARGET | sed 's/\//_/g'`
IDEAL_STATUS=$2
CMD=$3

RECIPIENT=chris.ortner@gmail.com

function notify {
    OUT="Expected status $IDEAL_STATUS - got $CURR_STATUS instead."
    if [ -n $CMD ] ; then
        OUT="$OUT`$CMD`"
    fi
    if [ -z $CURR_STATUS ] ; then
        TARGET="$TARGET: Service is unreachable"
    fi
    
    touch ~/.dirty_$TARGET_SANITIZED
    echo $OUT | mail -s "Unexpected status at $TARGET" $RECIPIENT
}

# Terminate if an issue hasn't been fixed yet
if [ -e ~/.dirty_$TARGET_SANITIZED ] ; then
	exit
fi

CURR_STATUS=`curl -I -s $1 | perl -n -e '/^HTTP\/1.1 (\d*)/ && print "$1\n"'`

if [[ $CURR_STATUS != $IDEAL_STATUS ]] ; then
    notify
fi
