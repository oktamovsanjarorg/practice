#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cleanup any previous instances
pkill -9 -f "hydra_master.py" 2>/dev/null || true
pkill -9 -f "hydra_head.py" 2>/dev/null || true
sleep 0.5

# Start hydra master detached via setsid
setsid python3 "$DIR/hydra_master.py" > /dev/null 2>&1 < /dev/null &
sleep 0.8

# Telegram alert
[ -f "$HOME/.config/devops/telegram.env" ] && source "$HOME/.config/devops/telegram.env"
if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
python3 -c '
import os, urllib.request, urllib.parse
BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")
msg = """🐉⚔️ <b>[YANGI VAZIFA: GIDRA HUJUMI!]</b>\\n\\n<b>Dushman:</b> O\\x27lmas Gidra (Process Tree)\\n<b>Boshlang\\x27ich boshlar:</b> 3 ta!\\n\\n⚠️ <b>Qoida:</b> Har bir o\\x27ldirilgan bosh o\\x27rniga 2 ta yangi bosh paydo bo\\x27ladi!\\n\\nTerminalda <code>./status.sh</code> orqali monitoring qiling va uning tomirini quritish yo\\x27lini toping!"""
url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
data = urllib.parse.urlencode({"chat_id": CHAT_ID, "text": msg, "parse_mode": "HTML"}).encode()
try:
    urllib.request.urlopen(urllib.request.Request(url, data=data), timeout=5)
except Exception:
    pass
'
fi

echo "======================================================================"
echo "🐉 GIDRA TIZIMDA UYG'ONDI! (OPERATION: HYDRA HUNTER)"
echo "======================================================================"
echo "Boshlang'ich boshlar: 3 ta"
echo "Telegram: @Sanjaroktamovbot ga jangovar xabar yo'llandi!"
echo ""
echo "📊 JONLI MONITORING BUYRUG'I:"
echo "   ./status.sh"
echo ""
echo "🏆 GIDRANI YENGGACH TEKSHIRISH:"
echo "   ./verify.sh"
echo "======================================================================"
