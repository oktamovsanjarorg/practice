#!/bin/bash
# Production Web Gateway Deploy Script

echo "=== Deploying web-gateway on port 8080 ==="

# Check if gateway is already running
if [ -f "gateway.pid" ] && kill -0 $(cat gateway.pid) 2>/dev/null; then
    echo "[INFO] web-gateway already running with PID $(cat gateway.pid)"
    exit 0
fi

python3 web-gateway.py > gateway.log 2>&1 &
PID=$!

sleep 1

if kill -0 $PID 2>/dev/null; then
    echo "$PID" > gateway.pid
    echo "✅ [SUCCESS] web-gateway muvaffaqiyatli ishga tushdi! PID: $PID"
else
    echo "❌ [DEPLOY FAILED] web-gateway ishga tusha olmadi!"
    cat gateway.log
    exit 1
fi
