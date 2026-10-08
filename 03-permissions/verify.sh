#!/bin/bash

echo "=== 3-BOSQICH: PAYPULSE ENTERPRISE SECOPS AUDITI ==="

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/paypulse-platform"
passed=true

# 1. SGID tekshiruvi (build-artifacts)
rm -f "$BASE_DIR/build-artifacts/test_audit.tar.gz" 2>/dev/null
touch "$BASE_DIR/build-artifacts/test_audit.tar.gz"
if sudo -n -u paypulse_dev bash -c "echo 'audit' >> '$BASE_DIR/build-artifacts/test_audit.tar.gz'" 2>/dev/null; then
    echo "✅ [PASS] 1. Jamoaviy Hamkorlik (SGID): Ishchilar o'rtasida guruh merosxo'rligi muvaffaqiyatli ishlayapti."
else
    echo "❌ [FAIL] 1. Jamoaviy Hamkorlik (SGID): build-artifacts katalogida SGID yetishmayapti! (Fayl guruhi: $(stat -c "%G" "$BASE_DIR/build-artifacts/test_audit.tar.gz"))"
    passed=false
fi
rm -f "$BASE_DIR/build-artifacts/test_audit.tar.gz" 2>/dev/null

# 2. Sticky Bit tekshiruvi (receipts-dropzone)
TEST_RECEIPT="$BASE_DIR/receipts-dropzone/audit_receipt.json"
echo '{"id": 1}' > "$TEST_RECEIPT"
sudo -n -u paypulse_dev /bin/rm -f "$TEST_RECEIPT" 2>/dev/null
if [ -f "$TEST_RECEIPT" ]; then
    echo "✅ [PASS] 2. Tranzaksiyalar Himoyasi (Sticky Bit): Boshqa xodimlar kvitansiyalarni o'chira olmaydi."
    rm -f "$TEST_RECEIPT" 2>/dev/null
else
    echo "❌ [FAIL] 2. Tranzaksiyalar Himoyasi (Sticky Bit): receipts-dropzone papkasida Sticky bit yo'q! Birovning fayli o'chib ketmoqda."
    passed=false
fi

# 3. PCI-DSS Kalit himoyasi
KEY="$BASE_DIR/certs/stripe_signing.key"
if sudo -n -u paypulse_dev cat "$KEY" >/dev/null 2>&1; then
    echo "❌ [FAIL] 3. PCI-DSS Xavfsizligi: Maxfiy Stripe kaliti begonalarga o'qish uchun ochiq qolgan!"
    passed=false
else
    echo "✅ [PASS] 3. PCI-DSS Xavfsizligi: Maxfiy kalit faqat egasi uchun qat'iy yopilgan (600)."
fi

# 4. SUID zararsizlantirish
DIAG="$BASE_DIR/tools/net-diag"
if [ -u "$DIAG" ]; then
    echo "❌ [FAIL] 4. Imtiyozlarni Oshirish (SUID): net-diag binarida xavfli SUID biti hali ham faol!"
    passed=false
else
    echo "✅ [PASS] 4. Imtiyozlarni Oshirish (SUID): net-diag vositasi xavfsizlantirildi."
fi

echo ""
if [ "$passed" = true ]; then
    echo "=========================================================="
    echo "🎉 TABRIKLAYMAN! PAYPULSE SECOPS AUDITI 100% YASHIL BO'LDI!"
    echo "=========================================================="
    echo "Siz real ko'p foydalanuvchili FinTech infratuzilmasini:"
    echo " - Jamoaviy build hamkorligi (SGID)"
    echo " - To'lov kvitansiyalari xavfsizligi (Sticky Bit)"
    echo " - Maxfiy sertifikatlar izolatsiyasi (600)"
    echo " - Xavfli Root imtiyozlari (SUID)ni zararsizlantirish"
    echo "bo'yicha to'liq mustahkamladingiz!"
    echo ""
    echo "Git'ga saqlashni unutmang:"
    echo "  git add ."
    echo "  git commit -m 'done: 03-permissions/paypulse-hardened'"
    echo "  git push"
    exit 0
else
    echo "⚠️ Auditi to'liq yakunlanmadi. './simulate.sh' ni yurgizib, qaysi qatlam oqsayotganini ko'ring."
    exit 1
fi
