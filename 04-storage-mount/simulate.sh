#!/bin/bash

echo "=========================================================="
echo "📊 PAYPULSE PLATFORM: STORAGE INFRASTRUCTURE SIMULATION"
echo "=========================================================="

echo ""
echo "--- [1. STORAGE TOPOLOGY (FINDMNT) ] ---"
findmnt -l | grep -E "TARGET|paypulse" || echo "Hozircha hech qanday PayPulse mount nuqtalari ulanmagan."

echo ""
echo "--- [2. INCIDENT 1: CORE DATABASE STORAGE (/mnt/paypulse_data)] ---"
DATA_MNT="/mnt/paypulse_data"
if [ ! -d "$DATA_MNT" ]; then
    echo "❌ Mount nuqtasi: '$DATA_MNT' papkasi mavjud emas."
elif ! mountpoint -q "$DATA_MNT"; then
    echo "⚠️  Mount holati: '$DATA_MNT' mavjud, ammo bu alohida disk emas (root papka)."
else
    FSTYPE=$(findmnt -n -o FSTYPE "$DATA_MNT")
    SRC=$(findmnt -n -o SOURCE "$DATA_MNT")
    echo "✅ Mount holati: Ulangan ($SRC -> $DATA_MNT)"
    echo "   Fayl tizimi:  $FSTYPE"
    df -h "$DATA_MNT" | awk 'NR==2 {print "   Hajmi:        " $2 " (Bo\x27sh joy: " $4 ")"}'
    if [ -w "$DATA_MNT" ]; then
        echo "✅ Yozish huquqi: Egasi va ruxsatlar to'g'ri (yozish mumkin)."
    else
        echo "❌ Yozish huquqi: Ruxsat yo'q (Permission denied)!"
    fi
fi

echo ""
echo "--- [3. INCIDENT 2: AUDIT SERVICE INODE STATUS (/mnt/paypulse_audit)] ---"
AUDIT_MNT="/mnt/paypulse_audit"
if mountpoint -q "$AUDIT_MNT"; then
    echo "Disk hajmi bo'yicha ko'rsatkich (df -h):"
    df -h "$AUDIT_MNT" | awk 'NR==2 {print "   Jami: " $2 " | Band: " $3 " (" $5 ") | Bo\x27sh: " $4}'
    
    echo "Inodlar bo'yicha ko'rsatkich (df -i):"
    df -i "$AUDIT_MNT" | awk 'NR==2 {print "   Jami Inodlar: " $2 " | Band: " $3 " (" $5 ") | Bo\x27sh: " $4}'
    
    INODE_PCT=$(df -i "$AUDIT_MNT" | awk 'NR==2 {print $5}' | tr -d '%')
    if [ "$INODE_PCT" -ge 95 ]; then
        echo "🚨 XAVF: Inodlar 95%+ to'lgan! Yangi fayl yaratish 'No space left on device' bilan yiqiladi."
    else
        echo "✅ Inodlar holati barqaror ($INODE_PCT% band)."
    fi
else
    echo "⚠️  Audit xotirasi ulanmagan."
fi

echo ""
echo "=========================================================="
