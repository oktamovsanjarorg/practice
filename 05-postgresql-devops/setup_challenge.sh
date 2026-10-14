#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PGPORT="5433"
PGUSER="sanjar"

echo "=========================================================="
echo "🛠️  PAYPULSE 5-BOSQICH: POSTGRESQL DEVOPS MUHITINI SOZLASH"
echo "=========================================================="

# 1. Eski test bazalari va rollarni tozalash (Idempotent)
echo "1. Eski ma'lumotlar tozalanmoqda..."
dropdb -p "$PGPORT" -U "$PGUSER" paypulse_prod 2>/dev/null || true
dropdb -p "$PGPORT" -U "$PGUSER" paypulse_recovery_test 2>/dev/null || true
psql -p "$PGPORT" -U "$PGUSER" -d postgres -c "DROP ROLE IF EXISTS paypulse_api;" 2>/dev/null || true

# 2. Yangi paypulse_prod bazasini yaratish
echo "2. 'paypulse_prod' ma'lumotlar bazasi yaratilmoqda..."
createdb -p "$PGPORT" -U "$PGUSER" paypulse_prod

# 3. Jadvallar va ma'lumotlarni yuklash
echo "3. Production jadvallari va yozuvlari shakllantirilmoqda..."
psql -p "$PGPORT" -U "$PGUSER" -d paypulse_prod << 'EOF'
-- 1. Mijozlar jadvali
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    balance NUMERIC(12, 2) DEFAULT 0.00
);

INSERT INTO customers (name, email, balance) VALUES
('Ali Valiyev', 'ali@paypulse.uz', 1500000.00),
('Dilnoza Karimova', 'dilnoza@paypulse.uz', 3400000.00),
('Sanjar Oqtamov', 'sanjar@paypulse.uz', 9800000.00);

-- 2. Tranzaksiyalar jadvali
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    amount NUMERIC(12, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'SUCCESS',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO transactions (customer_id, amount, status) VALUES
(1, 250000.00, 'SUCCESS'),
(2, 120000.00, 'SUCCESS'),
(3, 5000000.00, 'SUCCESS');

-- 3. Maxfiy Audit Kalitlari (API ga berilmasligi SHART bo'lgan jadval)
CREATE TABLE internal_audit_secrets (
    id SERIAL PRIMARY KEY,
    secret_key VARCHAR(100) NOT NULL,
    description TEXT
);

INSERT INTO internal_audit_secrets (secret_key, description) VALUES
('RSA_PRIVATE_HSM_9921', 'Root Central Bank settlement private signing key'),
('STRIPE_WEBHOOK_SECRET_LIVE', 'Production Webhook HMAC Secret');
EOF

# 4. Papka va huquqlarni sozlash
mkdir -p "$DIR/backups"
rm -f "$DIR/backups"/* 2>/dev/null || true

chmod +x "$DIR"/*.sh 2>/dev/null || true

echo ""
echo "✅ POSTGRESQL AMALIYOT MUHITI TAYYOR!"
echo "   - Port:       $PGPORT"
echo "   - Baza:       paypulse_prod"
echo "   - Jadvallar:  customers, transactions, internal_audit_secrets"
echo "   - JIRA TICKET: JIRA_TICKET.md ni o'qing."
echo "=========================================================="
