#!/bin/bash
# Blackbox Core Service Manager

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIDFILE="$DIR/.engine/service.pid"

case "$1" in
    start)
        if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
            echo "[INFO] Service already running (PID: $(cat "$PIDFILE"))"
            exit 0
        fi
        
        echo "🚀 Starting blackbox-service..."
        python3 "$DIR/.engine/core-service.py" &
        PID=$!
        
        sleep 1
        
        if kill -0 $PID 2>/dev/null; then
            echo $PID > "$PIDFILE"
            echo "Service started successfully with PID: $PID"
            exit 0
        else
            echo "❌ Service crashed during startup! (Exit code: $?)"
            exit 1
        fi
        ;;
    stop)
        if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
            kill $(cat "$PIDFILE")
            rm -f "$PIDFILE"
            echo "Service stopped."
        else
            echo "Service is not running."
        fi
        ;;
    status)
        if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
            echo "Service is RUNNING (PID: $(cat "$PIDFILE"))"
            curl -s http://127.0.0.1:8888/
        else
            echo "Service is STOPPED."
        fi
        ;;
    *)
        echo "Foydalanish: $0 {start|stop|status}"
        exit 1
        ;;
esac
