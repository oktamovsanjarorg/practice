#!/bin/bash

echo "=== Tekshiruv boshlandi ==="

# 1. Port 8080 javob beryaptimi?
RES=$(curl -s http://localhost:8080)
if [[ "$RES" == *"STATUS: OK"* ]]; then
    echo "[PASS] 1. Server localhost:8080 da ishlamoqda."
else
    echo "[FAIL] 1. localhost:8080 ga ulanib bo'lmadi! ($RES)"
    exit 1
fi

# 2. Log fayl yozilyaptimi?
if [ -s "logs/app.log" ]; then
    echo "[PASS] 2. Log fayl (logs/app.log) muvaffaqiyatli yozilmoqda."
else
    echo "[FAIL] 2. Log fayl bo'sh yoki mavjud emas!"
    exit 1
fi

echo ""
echo "🎉 TABRIKLAYMAN! MISSION-01 MUVAFFAQIYATLI YAKUNLANDI!"
echo "DevOps darajangiz +10 XP ga oshdi."
