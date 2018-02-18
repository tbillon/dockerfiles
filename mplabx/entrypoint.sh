#!/bin/sh

set -e

if [ -z "$DISPLAY" ]; then
    echo "DISPLAY variable not defined, exiting"
    exit 1
fi

if [ -z "$USER" ]; then
    echo "USER variable not defined, exiting"
    exit 1
fi

if [ -z "$USERID" ]; then
    echo "USERID variable not defined, exiting"
    exit 1
fi

if [ -z "$GROUPID" ]; then
    echo "GROUPID variable not defined, exiting"
    exit 1
fi

useradd -l -o -U -u $USERID $USER
if [ $? -ne 0 ]; then
    echo "Could not create user $USER, exiting"
    exit 1
fi

chown -R $USERID:$GROUPID /home/${USER}/
if [ $? -ne 0 ]; then
    echo "Could change ownership of project directory, exiting"
    exit 1
fi

exec /sbin/runuser -u $USER "$@"
