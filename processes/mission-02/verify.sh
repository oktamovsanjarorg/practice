#!/bin/bash

echo "=== MISSION-02: PORT VA JARAYONNI TEKSHIRISH ==="

# 1. Port 8080 ochiqmi?
if ! ss -tulpn | grep -q ":8080 "; then
    echo "[FAIL] 1. Port 8080 da hech qanday jarayon eshitmayapti!"
    echo "Maslahat: ./deploy.sh ni ishga tushiring."
    exit 1
fi
echo "[PASS] 1. Port 8080 faol eshitmoqda."

# 2. curl bilan tekshiruv
RESPONSE=$(curl -s http://localhost:8080)
if [[ "$RESPONSE" == *"GATEWAY_OK"* ]]; then
    echo "[PASS] 2. HTTP so'rovi to'g'ri xizmatga yetib bordi: $RESPONSE"
else
    echo "[FAIL] 2. Port 8080 da noto'g'ri xizmat javob bermoqda!"
    echo "Qabul qilingan javob: $RESPONSE"
    echo "Maslahat: Eski/noto'g'ri jarayonni to'xtatib, o'rniga ./deploy.sh ni yurgizing."
    exit 1
fi

# 3. gateway.pid tekshiruvi
if [ -f "gateway.pid" ] && kill -0 $(cat gateway.pid) 2>/dev/null; then
    PID=$(cat gateway.pid)
    echo "[PASS] 3. web-gateway PID: $PID muvaffaqiyatli qayd etilgan."
else
    echo "[FAIL] 3. gateway.pid fayli topilmadi yoki jarayon to'xtab qolgan."
    exit 1
fi

echo ""
echo "🎉 TABRIKLAYMAN! MISSION-02 MUVAFFAQIYATLI YAKUNLANDI!"
echo "Siz tarmoq portlarini band qilgan noma'lum jarayonlarni aniqlash va xavfsiz tozalashni to'liq o'rgandingiz."
echo ""
echo "Amaliyotni Git'ga saqlashni unutmang:"
echo "  git add ."
echo "  git commit -m 'done: processes/mission-02'"
echo "  git push"

# Tozalash
kill -9 "$PID" 2>/dev/null || true
rm -f gateway.pid gateway.log 2>/dev/null || true
