#!/bin/bash

# Prints ip address to main kernel console (probably uart) as soon as network
# is connected.

IF=$1
STATUS=$2

case "$STATUS" in
       up)
       ip add show dev $IF | sudo tee /dev/kmsg
       ;;
       down)
       ;;
       pre-up)
       ;;
       post-down)
       ;;
       *)
       ;;
esac
