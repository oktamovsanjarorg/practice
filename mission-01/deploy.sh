#!/bin/bash

# Deploy script for payments-api
echo "Starting deployment of payments-api..."

# TODO: Nega server ishga tushmayapti?
python3 server.py &
PID=$!

sleep 1

if kill -0 $PID 2>/dev/null; then
    echo "Deployment SUCCESS! PID: $PID"
else
    echo "Deployment FAILED! Server to'xtab qoldi."
    exit 1
fi
