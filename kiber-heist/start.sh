#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="$DIR/.reactor.pid"

# Kill old process if running
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")
    kill -9 "$OLD_PID" 2>/dev/null || true
    rm -f "$PID_FILE"
fi

# Export secret so it shows in /proc/$PID/environ
export DEFUSE_KEY="CYBER-ARCH-DEVOPS-2026"
export REACTOR_SYSTEM_STATE="ARMED_CRITICAL"

# Start reactor server in background using setsid
setsid python3 "$DIR/reactor_server.py" > "$DIR/server.log" 2>&1 < /dev/null &
sleep 0.5

# Send Telegram dispatch
[ -f "$HOME/.config/devops/telegram.env" ] && source "$HOME/.config/devops/telegram.env"
if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
python3 -c '
import os, urllib.request, urllib.parse
BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")
msg = """💣 <b>[KIBER-HEIST] "SHADOW-CORE" REAKTORI ISHGA TUSHDI!</b>\\n\\n<b>Port:</b> <code>7777</code> (TCP)\\n<b>Vaqt:</b> 7 daqiqa\\n<b>Holat:</b> Critical Overload\\n\\n⚡ Terminalingizda quyidagi buyruq bilan ulaning va tizimni qutqaring:\\n<code>nc 127.0.0.1 7777</code>"""
url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
data = urllib.parse.urlencode({"chat_id": CHAT_ID, "text": msg, "parse_mode": "HTML"}).encode()
try:
    urllib.request.urlopen(urllib.request.Request(url, data=data), timeout=5)
except Exception:
    pass
'
fi

echo "======================================================================"
echo "💣 KIBER-HEIST: SHADOW-CORE REAKTORI ISHGA TUSHIRILDI!"
echo "======================================================================"
echo "Port: 7777 (TCP)"
echo "Taymer: 7 daqiqa"
echo "Telegram: @Sanjaroktamovbot ga ogohlantirish yuborildi!"
echo ""
echo "🚀 REAKTORGA ULANISH BUYRUG'I:"
echo "   nc 127.0.0.1 7777"
echo "======================================================================"
