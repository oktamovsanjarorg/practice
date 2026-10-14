#!/bin/bash

PGPORT="5433"
PGUSER="sanjar"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "📊 PAYPULSE POSTGRESQL: LIVE CLUSTER TELEMETRY"
echo "=========================================================="

echo ""
echo "--- [0. SYSTEMD XIZMATI VA KLASTR TELEMETRIYASI] ---"
SERVICE_STATUS=$(systemctl is-active postgresql 2>/dev/null || echo "inactive")
SERVICE_ENABLED=$(systemctl is-enabled postgresql 2>/dev/null || echo "disabled")
echo "Systemd Service: postgresql.service -> [$SERVICE_STATUS] | Auto-start: [$SERVICE_ENABLED]"

echo ""
echo "--- [1. CLUSTER & BAZA HOLATI] ---"
psql -p "$PGPORT" -U "$PGUSER" -d postgres -c "SELECT datname, pg_size_pretty(pg_database_size(datname)) AS size FROM pg_database WHERE datname IN ('paypulse_prod', 'paypulse_recovery_test');" 2>/dev/null || echo "PostgreSQL ga ulanib bo'lmadi."

echo ""
echo "--- [2. ROLLAR VA XAVFSIZLIK (ROLE ISOLATION)] ---"
ROLE_EXISTS=$(psql -p "$PGPORT" -U "$PGUSER" -d postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='paypulse_api';" 2>/dev/null || echo "0")

if [ "$ROLE_EXISTS" = "1" ]; then
    echo "✅ 'paypulse_api' roli mavjud."
    psql -p "$PGPORT" -U "$PGUSER" -d postgres -c "SELECT rolname, rolsuper, rolcanlogin FROM pg_roles WHERE rolname='paypulse_api';"
    
    echo "Huquqlar auditi (paypulse_prod):"
    psql -p "$PGPORT" -U "$PGUSER" -d paypulse_prod -c "
    SELECT table_name, privilege_type 
    FROM information_schema.role_table_grants 
    WHERE grantee = 'paypulse_api';
    " 2>/dev/null
else
    echo "⚠️  'paypulse_api' roli hali yaratilmagan."
fi

echo ""
echo "--- [3. ZAXIRA NUSXALARI (BACKUPS)] ---"
if [ -d "$DIR/backups" ] && [ "$(ls -A "$DIR/backups" 2>/dev/null)" ]; then
    ls -lh "$DIR/backups"
else
    echo "⚠️  'backups/' katalogida hali hech qanday zaxira nusxasi yo'q."
fi

echo ""
echo "--- [4. FAOL ULASHLAR (PG_STAT_ACTIVITY)] ---"
psql -p "$PGPORT" -U "$PGUSER" -d postgres -c "
SELECT pid, usename, client_addr, state, query 
FROM pg_stat_activity 
WHERE datname = 'paypulse_prod' AND state != 'idle';
" 2>/dev/null || true

echo ""
echo "=========================================================="
