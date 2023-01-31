#!/bin/bash
trap 'kill -TERM $PID' TERM INT

webpack & # Command 1
http-server -p 3000 -c-1 & # Command 2

PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
