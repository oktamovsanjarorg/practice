#!/bin/bash
# Incidentni ishga tushirish (8080 portini ayg'oqchi jarayon bilan band qilish)

# Avvalgi eski qoldiqlarni tozalash
pkill -f "rogue-service.py" 2>/dev/null || true
pkill -f "web-gateway.py" 2>/dev/null || true
rm -f gateway.pid gateway.log 2>/dev/null || true

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
setsid python3 "$DIR/.internal/rogue-service.py" </dev/null >/dev/null 2>&1 &

sleep 0.5
echo "🚨 DIQQAT: Port 8080 da noma'lum jarayon paydo bo'ldi va portni egallab oldi!"
echo "Incident boshlandi. ./deploy.sh orqali tekshirib ko'rishingiz mumkin."
