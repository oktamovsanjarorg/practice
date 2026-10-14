#!/bin/bash

PGPORT="5433"
PGUSER="sanjar"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
passed=true

echo "=========================================================="
echo "🔍 5-BOSQICH: POSTGRESQL DEVOPS & SRE AUDITI"
echo "=========================================================="

# ----------------------------------------------------
# 0-TEKSHIRUV: SYSTEMD SERVIS VA KLASTR HOLATI
# ----------------------------------------------------
echo ""
echo "--- [0. SYSTEMD SERVIS VA KLASTR HOLATI] ---"

IS_ACTIVE=$(systemctl is-active postgresql 2>/dev/null) || IS_ACTIVE="inactive"
IS_ENABLED=$(systemctl is-enabled postgresql 2>/dev/null) || IS_ENABLED="disabled"

# 1. Paket o'rnatilganligini tekshirish
if ! command -v postgres >/dev/null 2>&1 || ! command -v psql >/dev/null 2>&1; then
    echo "❌ [FAIL] 0. Paket o'rnatilmagan: 'postgresql' paketi tizimda topilmadi."
    echo "         Yechim: sudo pacman -S postgresql"
    passed=false
# 2. Klastr ma'lumotlar papkasi mavjudligini tekshirish
elif ! sudo -n test -d "/var/lib/postgres/data/base" 2>/dev/null && [ ! -d "/var/lib/postgres/data" ]; then
    echo "❌ [FAIL] 0. Klastr initsializatsiya qilinmagan: '/var/lib/postgres/data' topilmadi."
    echo "         Yechim: sudo -u postgres initdb -D /var/lib/postgres/data --locale=C.UTF-8"
    passed=false
elif [ "$IS_ACTIVE" != "active" ]; then
    echo "❌ [FAIL] 0. Servis holati: 'postgresql.service' ishlamayapti (holat: $IS_ACTIVE)."
    echo "         Yechim: sudo systemctl start postgresql"
    passed=false
elif [ "$IS_ENABLED" != "enabled" ]; then
    echo "❌ [FAIL] 0. Avtomatik ishga tushish (Auto-start): 'postgresql.service' enable qilinmagan (holat: $IS_ENABLED)."
    echo "         Server reboot bo'lsa baza o'chib qoladi! Yechim: sudo systemctl enable postgresql"
    passed=false
else
    # Socket va Port javob berishini tekshirish
    PING_DB=$(psql -p "$PGPORT" -U "$PGUSER" -d postgres -tAc "SELECT 1;" 2>/dev/null || echo "0")
    if [ "$PING_DB" != "1" ]; then
        echo "❌ [FAIL] 0. Baza soketi/porti: PostgreSQL ishlab turibdi, lekin $PGPORT port orqali javob bermayapti."
        passed=false
    else
        echo "✅ [PASS] 0. Systemd Servis & Klastr: 'postgresql.service' faol (running), avtomatik yuklanishda (enabled) va $PGPORT portida javob bermoqda."
    fi
fi

# ----------------------------------------------------
# 1-TEKSHIRUV: ROLLAR VA HUQUQLAR ISOLATSIYASI (LEAST PRIVILEGE)
# ----------------------------------------------------
echo ""
echo "--- [1. FOYDALANUVCHILAR VA ROLLOR ISOLATSIYASI] ---"

ROLE_INFO=$(psql -p "$PGPORT" -U "$PGUSER" -d postgres -tAc "
SELECT rolcanlogin, rolsuper 
FROM pg_roles 
WHERE rolname='paypulse_api';
" 2>/dev/null || true)

if [ -z "$ROLE_INFO" ]; then
    echo "❌ [FAIL] 1. Role mavjudligi: 'paypulse_api' xizmat roli bazada mavjud emas."
    passed=false
else
    CAN_LOGIN=$(echo "$ROLE_INFO" | cut -d'|' -f1)
    IS_SUPER=$(echo "$ROLE_INFO" | cut -d'|' -f2)

    if [ "$CAN_LOGIN" != "t" ]; then
        echo "❌ [FAIL] 1. Avtorizatsiya: 'paypulse_api' roliga LOGIN huquqi berilmagan."
        passed=false
    elif [ "$IS_SUPER" = "t" ]; then
        echo "❌ [FAIL] 1. Xavfsizlik xatosi: 'paypulse_api' roli SUPERUSER qilingan! Backend dasturiga to'liq boshqaruv huquqi berilishi taqiqlanadi."
        passed=false
    else
        # Huquqlarni tekshirish (paypulse_prod ichida)
        HAS_CONNECT=$(psql -p "$PGPORT" -U "$PGUSER" -d paypulse_prod -tAc "SELECT has_database_privilege('paypulse_api', 'paypulse_prod', 'CONNECT');" 2>/dev/null || echo "f")
        HAS_TX_SELECT=$(psql -p "$PGPORT" -U "$PGUSER" -d paypulse_prod -tAc "SELECT has_table_privilege('paypulse_api', 'transactions', 'SELECT');" 2>/dev/null || echo "f")
        HAS_SECRET_SELECT=$(psql -p "$PGPORT" -U "$PGUSER" -d paypulse_prod -tAc "SELECT has_table_privilege('paypulse_api', 'internal_audit_secrets', 'SELECT');" 2>/dev/null || echo "f")

        if [ "$HAS_CONNECT" != "t" ]; then
            echo "❌ [FAIL] 1. Bazaga ulanish: 'paypulse_api' roli 'paypulse_prod' bazasiga ulanish (CONNECT) huquqiga ega emas."
            passed=false
        elif [ "$HAS_TX_SELECT" != "t" ]; then
            echo "❌ [FAIL] 1. Jadvallarga ruxsat: 'paypulse_api' roli 'transactions' jadvalini o'qish (SELECT) huquqiga ega emas."
            passed=false
        elif [ "$HAS_SECRET_SELECT" = "t" ]; then
            echo "❌ [FAIL] 1. Maxfiylik xatari (Least Privilege): 'paypulse_api' roliga maxfiy 'internal_audit_secrets' jadvali ochiq qolgan!"
            passed=false
        else
            echo "✅ [PASS] 1. Rollar Izolyatsiyasi (Least Privilege): 'paypulse_api' xavfsiz sozlangan va maxfiy ma'lumotlar cheklangan."
        fi
    fi
fi

# ----------------------------------------------------
# 2-TEKSHIRUV: BACKUP PIPELINE
# ----------------------------------------------------
echo ""
echo "--- [2. ZAXIRA NUSXALASH PIPELINE (BACKUP)] ---"

BACKUP_SCRIPT="$DIR/backup_prod.sh"
if [ ! -f "$BACKUP_SCRIPT" ] || [ ! -x "$BACKUP_SCRIPT" ]; then
    echo "❌ [FAIL] 2. Zaxira skripti: '$BACKUP_SCRIPT' fayli yaratilmagan yoki ijro huquqiga (+x) ega emas."
    passed=false
else
    # backups papkasida fayl borligini tekshirish
    BACKUP_FILE=$(ls -1 "$DIR/backups"/* 2>/dev/null | head -n 1 || true)
    if [ -z "$BACKUP_FILE" ]; then
        echo "❌ [FAIL] 2. Zaxira fayli: 'backups/' katalogida hech qanday zaxira nusxasi topilmadi (backup_prod.sh ishga tushirilmagan)."
        passed=false
    else
        FILE_SIZE=$(stat -c "%s" "$BACKUP_FILE" 2>/dev/null || echo "0")
        if [ "$FILE_SIZE" -lt 1000 ]; then
            echo "❌ [FAIL] 2. Zaxira hajmi: Zaxira fayli juda kichik yoki bo'sh ($FILE_SIZE bayt)."
            passed=false
        else
            # Validatsiya: pg_restore yoki grep bilan jadval borligini tekshirish
            IS_VALID=false
            if pg_restore -l "$BACKUP_FILE" 2>/dev/null | grep -q "transactions"; then
                IS_VALID=true
            elif grep -q "transactions" "$BACKUP_FILE" 2>/dev/null; then
                IS_VALID=true
            fi

            if [ "$IS_VALID" = true ]; then
                echo "✅ [PASS] 2. Zaxira Butunligi: '$BACKUP_FILE' muvaffaqiyatli shakllangan va tranzaksiyalar jadvalini o'z ichiga olgan."
            else
                echo "❌ [FAIL] 2. Zaxira Butunligi: Zaxira fayli ichida 'transactions' jadvali topilmadi."
                passed=false
            fi
        fi
    fi
fi

# ----------------------------------------------------
# 3-TEKSHIRUV: DISASTER RECOVERY DRILL (TIKLASH SINOVI)
# ----------------------------------------------------
echo ""
echo "--- [3. HALOKATDAN TIKLASH SINOVI (DISASTER RECOVERY)] ---"

DB_EXISTS=$(psql -p "$PGPORT" -U "$PGUSER" -d postgres -tAc "
SELECT 1 FROM pg_database WHERE datname='paypulse_recovery_test';
" 2>/dev/null || echo "0")

if [ "$DB_EXISTS" != "1" ]; then
    echo "❌ [FAIL] 3. Tiklash bazasi: 'paypulse_recovery_test' sinov bazasi hali yaratilmagan/tiklanmagan."
    passed=false
else
    TX_COUNT=$(psql -p "$PGPORT" -U "$PGUSER" -d paypulse_recovery_test -tAc "
    SELECT count(*) FROM transactions;
    " 2>/dev/null || echo "0")

    if [ "$TX_COUNT" -lt 3 ]; then
        echo "❌ [FAIL] 3. Ma'lumotlar butunligi: Tiklangan bazada tranzaksiyalar to'liq emas (mavjud: $TX_COUNT, kutilgan: 3)."
        passed=false
    else
        echo "✅ [PASS] 3. Halokatdan Tiklash: 'paypulse_recovery_test' bazasiga barcha ma'lumotlar muvaffaqiyatli tiklandi ($TX_COUNT ta tranzaksiya)."
    fi
fi

# ----------------------------------------------------
# YAKUNIY XULOSA
# ----------------------------------------------------
echo ""
if [ "$passed" = true ]; then
    echo "=========================================================="
    echo "🎉 TABRIKLAYMAN! POSTGRESQL DEVOPS AUDITI 100% YASHIL BO'LDI!"
    echo "=========================================================="
    echo "Siz real FinTech ma'lumotlar bazasi infratuzilmasida:"
    echo "  - Least Privilege (Minimal ruxsatlar) xavfsizlik arxitekturasini"
    echo "  - Avtomatik Backup Pipeline yaratishni"
    echo "  - Disaster Recovery (Zaxiradan to'liq tiklash) amaliyotini"
    echo "yuqori standartda bajardingiz!"
    echo "=========================================================="
    exit 0
else
    echo "=========================================================="
    echo "⚠️  AUDIT TO'LIQ O'TMADI. Yuqoridagi xatoliklarni tahlil qiling."
    echo "Qo'llanma: HANDBOOK.md | Holat: ./simulate.sh"
    echo "=========================================================="
    exit 1
fi
