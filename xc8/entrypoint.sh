#!/bin/bash

set -e


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

exec /sbin/runuser -u $USER "$@"
