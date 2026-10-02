#!/bin/bash

echo "=== MISSION-01: JARAYONLARNI TEKSHIRISH ==="

if [ ! -f "answers.env" ]; then
    echo "[FAIL] answers.env fayli topilmadi!"
    exit 1
fi

set -a
source answers.env
set +a

if [ -z "$AGENT_PID" ] || [ -z "$BOSS_PID" ]; then
    echo "[FAIL] answers.env faylida AGENT_PID yoki BOSS_PID bo'sh qoldirilgan!"
    echo "Maslahat: answers.env faylini ochib, aniqlagan PID raqamlaringizni yozing."
    exit 1
fi

# Real PIDs
REAL_AGENT_PID=$(pgrep -f "secret-agent" | head -n 1)
REAL_BOSS_PID=$(pgrep -f "boss-system" | head -n 1)

if [ -z "$REAL_AGENT_PID" ]; then
    echo "[OGOHLANTIRISH] secret-agent jarayoni hozir ishlamayapti. Qaytadan ishga tushirish uchun ./start.sh bering."
    exit 1
fi

# 1. Check Agent PID
if [ "$AGENT_PID" -eq "$REAL_AGENT_PID" ] 2>/dev/null; then
    echo "[PASS] 1. secret-agent PID to'g'ri topildi! (PID: $AGENT_PID)"
else
    echo "[FAIL] 1. secret-agent PID noto'g'ri ko'rsatilgan!"
    echo "Maslahat: pgrep -l secret-agent yoki ps -ef | grep secret-agent orqali tekshiring."
    exit 1
fi

# 2. Check Boss PID
if [ "$BOSS_PID" -eq "$REAL_BOSS_PID" ] 2>/dev/null; then
    echo "[PASS] 2. boss-system PID to'g'ri topildi! (PID: $BOSS_PID)"
else
    echo "[FAIL] 2. boss-system PID noto'g'ri ko'rsatilgan!"
    echo "Maslahat: ps -ef | grep secret-agent dagi PPID ustuniga qarang."
    exit 1
fi

# 3. Check hierarchy (PPID of agent)
ACTUAL_PPID=$(ps -o ppid= -p "$AGENT_PID" 2>/dev/null | tr -d ' ')
if [ "$ACTUAL_PPID" -eq "$BOSS_PID" ] 2>/dev/null; then
    echo "[PASS] 3. Ota-bola zanjiri tasdiqlandi: boss-system (PID: $BOSS_PID) -> secret-agent (PID: $AGENT_PID, PPID: $ACTUAL_PPID)"
else
    echo "[FAIL] 3. boss-system agentning haqiqiy otasi emas!"
    exit 1
fi

echo ""
echo "🎉 TABRIKLAYMAN! MISSION-01 (JARAYONLAR) MUVAFFAQIYATLI YAKUNLANDI!"
echo "Siz Linux'da jarayonlar (PID, PPID, daraxt) ierarxiyasini to'liq egalladingiz."
echo ""
echo "Keyingi mission (Mission-02: Portni yashirincha band qilgan jarayonni topish) ga o'tishingiz mumkin."

# Cleanup
kill -9 "$REAL_AGENT_PID" "$REAL_BOSS_PID" 2>/dev/null || true
