#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MASTER_PID=$(pgrep -f "hydra_master.py")
HEAD_COUNT=$(pgrep -f "hydra_head.py" | wc -l)

RED="\033[91m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
BOLD="\033[1m"
RESET="\033[0m"

if [ -z "$MASTER_PID" ] && [ "$HEAD_COUNT" -eq 0 ]; then
    echo -e "${GREEN}${BOLD}"
    cat << "EOF"
  ███████╗██╗      █████╗ ██╗███╗   ██╗██╗
  ██╔════╝██║     ██╔══██╗██║████╗  ██║██║
  ███████╗██║     ███████║██║██╔██╗ ██║██║
  ╚════██║██║     ██╔══██║██║██║╚██╗██║╚═╝
  ███████║███████╗██║  ██║██║██║ ╚████║██╗
  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝
EOF
    echo -e "${RESET}"
    echo -e "${CYAN}══════════════════════════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}🎉 G'ALABA! GIDRA VA UNING BARCHA BOSHLARI BATOMOM YO'Q QILINDI!${RESET}"
    echo -e "${CYAN}══════════════════════════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "${YELLOW}🧠 Mental Model (Nega oddiy 'kill' ish bermagan edi?):${RESET}"
    echo -e "1. ${BOLD}SIGCHLD va Forking:${RESET} Master jarayon o'z farzandlarining o'limini (exit code) eshitib, avtomatik yangi nusxalarni fork() qilar edi."
    echo -e "2. ${BOLD}Jarayonlar Ierarxiyasi:${RESET} Daraxtning asosiy ota jarayoni (PPID / Master) to'xtatilsa, farzandlar yetim (Orphan) qoladi va qayta tirilmaydi."
    echo -e "3. ${BOLD}Process Group (PGID):${RESET} Bir zarbada butun oilani qulatish uchun 'kill -9 -- -PGID' buyrug'i bir vaqtning o'zida hamma a'zolarni yo'q qiladi!"
    echo -e "${CYAN}══════════════════════════════════════════════════════════════════════${RESET}"

    # Telegram notification
    [ -f "$HOME/.config/devops/telegram.env" ] && source "$HOME/.config/devops/telegram.env"
    if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
    python3 -c '
import os, urllib.request, urllib.parse
BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.environ.get("TELEGRAM_CHAT_ID")
msg = """🐉⚔️ <b>[GIDRA MAG\x27LUB ETILDI!]</b>\\n\\n<b>Qahramon:</b> Sanjar\\n<b>Natija:</b> Gidra (Process Tree) butunlay yo\x27q qilindi!\\n\\n<i>"Yadro darajasidagi process tree va PGID boshqaruviga qoyil!"</i> 🏆🔥"""
url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
data = urllib.parse.urlencode({"chat_id": CHAT_ID, "text": msg, "parse_mode": "HTML"}).encode()
try:
    urllib.request.urlopen(urllib.request.Request(url, data=data), timeout=5)
except Exception:
    pass
'
    fi
    echo -e "${GREEN}📲 Telegramingizga (@Sanjaroktamovbot) g'alaba hisoboti yuborildi!${RESET}"
    exit 0
else
    echo -e "${RED}${BOLD}❌ Gidra hali butunlay yo'q qilinmadi!${RESET}"
    if [ -n "$MASTER_PID" ]; then
        echo -e "  ⚠️ Master hali tirik! (PID: $MASTER_PID)"
    fi
    echo -e "  ⚠️ Hali $HEAD_COUNT ta bosh tizimda aylanib yuribdi."
    echo -e "Holatni ko'rish uchun: ${YELLOW}./status.sh${RESET}"
    exit 1
fi
