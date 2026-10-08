#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/paypulse-platform"

echo "=========================================================="
echo "🏢 PAYPULSE PLATFORM: LIVE INFRASTRUCTURE SIMULATION"
echo "=========================================================="

echo ""
echo "--- [TEST 1: Jamoaviy Hamkorlik (SGID Sinovi)] ---"
rm -f "$BASE_DIR/build-artifacts/api-v1.tar.gz" 2>/dev/null
# 1. Sanjar build faylini yaratadi:
touch "$BASE_DIR/build-artifacts/api-v1.tar.gz"
FILE_GROUP=$(stat -c "%G" "$BASE_DIR/build-artifacts/api-v1.tar.gz")
echo "1. Sanjar 'api-v1.tar.gz' yaratdi. Fayl guruhi: '$FILE_GROUP'"

# 2. Boshqa dasturchi (paypulse_dev) uni yangilashga urinadi:
if sudo -u paypulse_dev bash -c "echo 'patch' >> '$BASE_DIR/build-artifacts/api-v1.tar.gz'" 2>/dev/null; then
    echo "✅ [SUCCESS] paypulse_dev faylni muvaffaqiyatli yangiladi! Guruh merosxo'rligi (SGID) ishlamoqda."
else
    echo "❌ [FAIL] paypulse_dev faylni yangilay olmadi (Permission denied)!"
    echo "   Sabab: Fayl guruhi '$FILE_GROUP' bo'lib qolgan (paypulse_team emas). Papkaga SGID yetishmayapti!"
fi

echo ""
echo "--- [TEST 2: Tranzaksiyalarni O'chirish Xuruji (Sticky Bit Sinovi)] ---"
# 1. Sanjar to'lov kvitansiyasini yaratadi:
RECEIPT="$BASE_DIR/receipts-dropzone/order_9941.json"
echo '{"order_id": 9941, "amount": 540.00, "status": "PAID"}' > "$RECEIPT"
echo "1. Sanjar '$RECEIPT' kvitansiyasini umumiy bo'limga tashladi."

# 2. Boshqa foydalanuvchi (paypulse_dev) uni o'chirib yuborishga urinadi:
DEL_OUT=$(sudo -n -u paypulse_dev /bin/rm -f "$RECEIPT" 2>&1)
if [ ! -f "$RECEIPT" ]; then
    echo "❌ [CRITICAL BREACH] paypulse_dev boshqa odamning (Sanjar) kvitansiyasini o'chirib yubordi!"
    echo "   Sabab: Umumiy 777 papkada Sticky Bit yo'q! Birovning faylini birov o'chira olmasligi kerak."
else
    echo "✅ [SUCCESS] Linux yadrosi o'chirishga yo'l qo'ymadi: $DEL_OUT"
    echo "   Sticky Bit muvaffaqiyatli himoya qildi!"
fi

echo ""
echo "--- [TEST 3: PCI-DSS Maxfiy Kalitlar Auditi] ---"
KEY="$BASE_DIR/certs/stripe_signing.key"
KEY_PERM=$(stat -c "%a" "$KEY")
echo "1. Kalit huquqi: $KEY_PERM"
if sudo -u paypulse_dev cat "$KEY" >/dev/null 2>&1; then
    echo "❌ [SECURITY VIOLATION] Begona foydalanuvchi (paypulse_dev) maxfiy Stripe kalitini o'qiy oldi!"
    echo "   PCI-DSS qoidasi: Maxfiy kalitlar faqat egasiga ochiq bo'lishi shart (chmod 600)!"
else
    echo "✅ [SUCCESS] Begona foydalanuvchilar maxfiy kalitni o'qiy olmadi (Permission denied)!"
fi

echo ""
echo "--- [TEST 4: SUID Imtiyozlarini Tekshirish] ---"
DIAG="$BASE_DIR/tools/net-diag"
if [ -u "$DIAG" ]; then
    echo "❌ [SECURITY BREACH] '$DIAG' vositasida SUID biti mavjud!"
    sudo -u paypulse_dev "$DIAG"
    echo "   Xavf: Oddiy foydalanuvchi Root huquqiga ega bo'lib qolishi mumkin! SUID ni olib tashlang."
else
    echo "✅ [SUCCESS] SUID xavfi yo'q. Dastur xavfsiz holatda:"
    sudo -u paypulse_dev "$DIAG"
fi

echo ""
echo "=========================================================="
