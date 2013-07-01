#!/bin/bash

# Argument 1 is the target URL
# Argument 2 is the acceptable status code
# Argument 3 is a command executed in case of not matching stati

TARGET=$1
TARGET_SANITIZED=`echo $TARGET | sed 's/\//_/g'`
IDEAL_STATUS=$2
CMD=$3

RECIPIENT=yourmail@example.org

# Terminate if an issue hasn't been fixed yet
if [ -e ~/.dirty_$TARGET_SANITIZED ] ; then
	exit
	fi

	CURR_STATUS=`curl -I -s $1 | perl -n -e '/^HTTP\/1.1 (\d*)/ && print "$1\n"'`

	if [ $CURR_STATUS -ne $IDEAL_STATUS ] ; then
		OUT="Expected status $IDEAL_STATUS - got $CURR_STATUS instead."
			if [ -n $CMD ] ; then
					OUT="$OUT`$CMD`"
						fi
							touch ~/.dirty_$TARGET_SANITIZED
								echo $OUT | mail -s "Unexpected status at $TARGET" $RECIPIENT
								fi
