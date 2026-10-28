#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$DIR/hydra.log"

MASTER_PID=$(pgrep -f "hydra_master.py" | head -n 1)
HEAD_COUNT=$(pgrep -f "hydra_head.py" | wc -l)

RED="\033[91m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
BOLD="\033[1m"
RESET="\033[0m"

echo -e "${RED}${BOLD}======================================================================${RESET}"
echo -e "${RED}${BOLD}🐉 GIDRA MONITORINGI (LIVE STATUS)${RESET}"
echo -e "${RED}${BOLD}======================================================================${RESET}"

if [ -n "$MASTER_PID" ]; then
    echo -e "  Holat:          ${RED}${BOLD}TIRIK VA FAOL ⚠️${RESET}"
    echo -e "  Master PID:     ${YELLOW}${BOLD}$MASTER_PID${RESET} (Ajdahoning yuragi)"
    
    # PGID
    PGID=$(ps -o pgid= -p "$MASTER_PID" 2>/dev/null | tr -d ' ')
    echo -e "  Process Group:  ${CYAN}${BOLD}$PGID${RESET}"
    echo -e "  Tirik boshlar:  ${YELLOW}${BOLD}$HEAD_COUNT ta${RESET}"
    echo ""
    echo -e "${CYAN}Tirik boshlar PID ro'yxati:${RESET}"
    pgrep -f "hydra_head.py" | while read -r p; do
        echo -e "   🐉 [PID: $p]"
    done
else
    if [ "$HEAD_COUNT" -gt 0 ]; then
        echo -e "  Master Holati:  ${GREEN}${BOLD}O'LGAN (Yurak to'xtatildi!)${RESET}"
        echo -e "  Qolgan boshlar: ${YELLOW}${BOLD}$HEAD_COUNT ta etim bosh (Orphan)${RESET}"
        echo -e "  ${CYAN}Endi ularni 'kill' qilsangiz, yangisi o'smaydi! Tozalang!${RESET}"
    else
        echo -e "  Holat:          ${GREEN}${BOLD}GIDRA BUTKUL YO'Q QILINDI! 🎉${RESET}"
        echo -e "  ${GREEN}Tekshirish uchun: ./verify.sh ni ishga tushiring!${RESET}"
    fi
fi

echo -e "\n${YELLOW}So'nggi hodisalar (hydra.log):${RESET}"
if [ -f "$LOG_FILE" ]; then
    tail -n 6 "$LOG_FILE"
fi
echo -e "${RED}${BOLD}======================================================================${RESET}"
