#!/bin/bash

echo "=========================================================="
echo "🔍 4-BOSQICH: PAYPULSE STORAGE & MOUNT ARXITEKTURA AUDITI"
echo "=========================================================="

passed=true
DATA_MNT="/mnt/paypulse_data"
AUDIT_MNT="/mnt/paypulse_audit"

# ----------------------------------------------------
# 1-TEKSHIRUV: TRANZAKSIYA BAZASI ALOHIDA DISKI (MOUNT)
# ----------------------------------------------------
echo ""
echo "--- [1. TRANZAKSIYA BAZASI XOTIRASI AUDITI] ---"

if [ ! -d "$DATA_MNT" ]; then
    echo "❌ [FAIL] 1. Mount nuqtasi: '$DATA_MNT' katalogi mavjud emas."
    passed=false
elif ! mountpoint -q "$DATA_MNT"; then
    echo "❌ [FAIL] 1. Izolyatsiya: '$DATA_MNT' alohida blok qurilma sifatida ulanmagan (root diskda joylashgan)!"
    passed=false
else
    FSTYPE=$(findmnt -n -o FSTYPE "$DATA_MNT")
    if [ "$FSTYPE" != "ext4" ]; then
        echo "❌ [FAIL] 1. Fayl tizimi: '$DATA_MNT' uchun ext4 talab qilinadi (aniqlangan format: $FSTYPE)."
        passed=false
    else
        # Hajmni tekshirish (MB da)
        SIZE_MB=$(df -m "$DATA_MNT" | awk 'NR==2 {print $2}')
        if [ "$SIZE_MB" -lt 150 ]; then
            echo "❌ [FAIL] 1. Xotira hajmi: Ajratilgan hajm kamida 200MB bo'lishi kerak (aniqlandi: ${SIZE_MB}MB)."
            passed=false
        elif [ ! -w "$DATA_MNT" ]; then
            echo "❌ [FAIL] 1. Ruxsatlar: Joriy foydalanuvchi '$DATA_MNT' ga yozish huquqiga ega emas (Permission denied)!"
            passed=false
        elif [ ! -f "$DATA_MNT/transactions.db" ] || [ ! -f "$DATA_MNT/ledger.wal" ]; then
            echo "❌ [FAIL] 1. Dvigatel holati: Disk to'g'ri ulangan, biroq ./paypulse-db/start_engine.sh hali ishga tushirilmagan!"
            passed=false
        else
            echo "✅ [PASS] 1. Tranzaksiya xotirasi: Alohida ext4 xotira hajmi muvaffaqiyatli ulangan, ruxsatlar to'g'ri va DB dvigateli faol."
        fi
    fi
fi

# ----------------------------------------------------
# 2-TEKSHIRUV: AUDIT XOTIRASI VA INODLAR AUDITI
# ----------------------------------------------------
echo ""
echo "--- [2. AUDIT XOTIRASI VA INODLAR SALOMATLIGI AUDITI] ---"

if ! mountpoint -q "$AUDIT_MNT" 2>/dev/null; then
    echo "❌ [FAIL] 2. Audit xotirasi: '$AUDIT_MNT' ulanmagan. Iltimos, ./setup_challenge.sh ni qayta ishga tushiring."
    passed=false
else
    INODE_PCT=$(df -i "$AUDIT_MNT" | awk 'NR==2 {print $5}' | tr -d '%')
    
    if [ "$INODE_PCT" -ge 80 ]; then
        echo "❌ [FAIL] 2. Inodlar bandligi: Inodlar xavfli darajada to'lgan (${INODE_PCT}%)! Yangi tranzaksiya yozuvlarini qabul qilib bo'lmaydi."
        passed=false
    elif [ ! -f "$AUDIT_MNT/compliance_policy.json" ]; then
        echo "❌ [FAIL] 2. Ma'lumotlar butunligi: Muhim 'compliance_policy.json' fayli yo'qolgan!"
        passed=false
    elif [ ! -f "$AUDIT_MNT/compliance_2026.log" ]; then
        echo "❌ [FAIL] 2. Audit hisoboti: Inodlar bo'shatilgan bo'lishi mumkin, ammo ./paypulse-audit/run_audit.sh hali hisobot yaratmagan!"
        passed=false
    else
        echo "✅ [PASS] 2. Inodlar salomatligi: Inodlar me'yorga keltirildi (${INODE_PCT}% band) va audit hisoboti muvaffaqiyatli saqlandi."
    fi
fi

# ----------------------------------------------------
# YAKUNIY XULOSA
# ----------------------------------------------------
echo ""
if [ "$passed" = true ]; then
    echo "=========================================================="
    echo "🎉 TABRIKLAYMAN! 4-BOSQICH AUDITI 100% YASHIL BO'LDI!"
    echo "=========================================================="
    echo "Siz real tizim arxitekturasida:"
    echo "  - Blok qurilma (loop disk) yaratish va ext4 formatlashni"
    echo "  - VFS daraxtiga mount qilish va mountdan keyingi huquqlarni to'g'irlashni"
    echo "  - Real incident: Inode to'lishi (Inode exhaustion) muammosini aniqlash va bartaraf etishni"
    echo "amalda mustaqil hal qildingiz!"
    echo ""
    echo "Navbatdagi qadam: O'zgarishlarni git'ga commit qiling:"
    echo "git add . && git commit -m 'done: 04-storage-mount/production-storage-restored'"
    echo "=========================================================="
    exit 0
else
    echo "=========================================================="
    echo "⚠️  AUDIT TO'LIQ O'TMADI. Yuqoridagi xatoliklarni bartaraf eting."
    echo "Yordam uchun: HANDBOOK.md va simulate.sh vositalaridan foydalaning."
    echo "=========================================================="
    exit 1
fi
