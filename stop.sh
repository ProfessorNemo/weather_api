#!/bin/bash
trap 'kill -TERM $PID' TERM INT

PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
