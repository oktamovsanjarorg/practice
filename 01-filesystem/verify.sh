#!/bin/bash

echo "=== 1-BOSQICH: FAYL TIZIMI VA XIZMATNI TIKLASH AUDITI ==="
passed=true

# 1. Symlink tekshiruvi (/etc/blackbox/active.conf)
if [ ! -L "/etc/blackbox/active.conf" ]; then
    echo "❌ [FAIL] 1. /etc/blackbox/active.conf fayli mavjud emas yoki u havola (symlink) emas!"
    passed=false
elif [ ! -e "/etc/blackbox/active.conf" ]; then
    TARGET=$(readlink "/etc/blackbox/active.conf")
    echo "❌ [FAIL] 1. /etc/blackbox/active.conf BUZILGAN HAVOLA (Broken Symlink)! U mavjud bo'lmagan '$TARGET' ga ko'rsatyapti."
    echo "   Maslahat: Uni /etc/blackbox/configs/v2_production.conf ga yo'naltiring (ln -sf ...)"
    passed=false
else
    TARGET=$(readlink -f "/etc/blackbox/active.conf")
    echo "✅ [PASS] 1. Havola (symlink) to'g'ri ishlamoqda: active.conf -> $TARGET"
fi

# 2. Log katalogi va fayli tekshiruvi (/var/log/blackbox)
if [ ! -d "/var/log/blackbox" ]; then
    echo "❌ [FAIL] 2. /var/log/blackbox katalogi mavjud emas! FHS talabiga binoan uni yaratish kerak (sudo mkdir -p ...)"
    passed=false
elif [ ! -s "/var/log/blackbox/service.log" ]; then
    echo "❌ [FAIL] 2. /var/log/blackbox/service.log fayli bo'sh yoki mavjud emas! Xizmat hali log yozmagan."
    passed=false
else
    echo "✅ [PASS] 2. Log fayli muvaffaqiyatli ishlamoqda (/var/log/blackbox/service.log)"
fi

# 3. Xizmatning tirikligi va Healthcheck tekshiruvi (curl 8888)
RES=$(curl -s http://127.0.0.1:8888/ 2>/dev/null)
if [[ "$RES" == *"BLACKBOX_CORE_HEALTHY"* ]]; then
    echo "✅ [PASS] 3. Xizmat faol va sog'lom: $RES"
else
    echo "❌ [FAIL] 3. Xizmat http://127.0.0.1:8888/ da ishlamayapti yoki javob bermayapti!"
    echo "   Maslahat: ./service.sh start ni ishga tushiring va chiqqan xatolikni o'qing."
    passed=false
fi

echo ""
if [ "$passed" = true ]; then
    echo "=========================================================="
    echo "🎉 TABRIKLAYMAN! 1-BOSQICH 10/10 DARAJADA YAKUNLANDI!"
    echo "=========================================================="
    echo "Siz quyidagi muhandislik amaliyotlarini to'liq uddaladingiz:"
    echo " 1. Buzilgan havolani (Broken Symlink) aniqlab, qayta tikladingiz."
    echo " 2. FHS qoidasiga ko'ra log katalogini (/var/log/blackbox) qurdingiz."
    echo " 3. Virtual fayl tizimidan (/proc/meminfo) server resursini tekshirib, xizmat sozlamasini mosladingiz."
    echo " 4. Xizmatni muvaffaqiyatli ishga tushirib, 200 OK natijasiga erishdingiz."
    echo ""
    echo "G'alabani Git'ga saqlashni unutmang:"
    echo "  git add ."
    echo "  git commit -m 'done: 01-filesystem/broken-core-restored'"
    echo "  git push"
    
    # Muvaffaqiyatli yakunlandi
    exit 0
else
    echo "⚠️ Hali barcha shartlar bajarilmadi. Yuqoridagi maslahatlarga qarang va qaytadan ./verify.sh bering."
    exit 1
fi
