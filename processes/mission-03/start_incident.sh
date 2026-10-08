#!/bin/bash
# Mission-03: Incidentni ishga tushirish

pkill -f "supervisor.py" 2>/dev/null || true
pkill -f "engine.py" 2>/dev/null || true
pkill -f "tx-worker" 2>/dev/null || true
rm -f /tmp/practice_tx.lock engine.log 2>/dev/null || true

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
setsid python3 "$DIR/.engine/supervisor.py" </dev/null >> "$DIR/engine.log" 2>&1 &

sleep 1

echo "🚨 INCIDENT BOSHLANDI: Payment Engine ishga tushdi va nosoz holatda!"
echo ""
echo "Tergovni 'tail -f engine.log' orqali boshlashingiz mumkin."
