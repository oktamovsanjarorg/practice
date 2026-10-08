#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUDIT_MNT="/mnt/paypulse_audit"
AUDIT_IMG="$DIR/paypulse-audit/audit_disk.img"
DATA_MNT="/mnt/paypulse_data"

echo "=========================================================="
echo "🛠️  PAYPULSE 4-BOSQICH: STORAGE & MOUNT MUHITINI O'RNATISH"
echo "=========================================================="

# 1. Oldingi mountlarni tozalash (Idempotent)
if mountpoint -q "$AUDIT_MNT" 2>/dev/null; then
    echo "1. Eski audit mounti ajratilmoqda (umount)..."
    sudo umount "$AUDIT_MNT" 2>/dev/null || true
fi
sudo rm -rf "$AUDIT_MNT" 2>/dev/null || true

if mountpoint -q "$DATA_MNT" 2>/dev/null; then
    echo "2. Eski data mounti ajratilmoqda (umount)..."
    sudo umount "$DATA_MNT" 2>/dev/null || true
fi
sudo rm -rf "$DATA_MNT" 2>/dev/null || true

# 2. INCIDENT 2 muhitini shakllantirish (Inode to'lishi holati)
echo "3. Audit diski yaratilmoqda (audit_disk.img - 25MB, 2000 Inode)..."
rm -f "$AUDIT_IMG" 2>/dev/null || true
fallocate -l 25M "$AUDIT_IMG"
mkfs.ext4 -F -q -N 2000 "$AUDIT_IMG"

sudo mkdir -p "$AUDIT_MNT"
sudo mount -o loop "$AUDIT_IMG" "$AUDIT_MNT"
sudo chown -R "$USER:$USER" "$AUDIT_MNT"

# Asl qonuniy fayllar:
echo '{"version": "4.0", "pci_dss_compliant": true, "auth": "FinTech-Central"}' > "$AUDIT_MNT/compliance_policy.json"
echo "ARCHIVE: Q1-Q3 2025 AUDIT CLEAR" > "$AUDIT_MNT/audit_archive_2025.txt"

# Nosoz fon jarayoni qoldirgan bo'sh lock fayllar to'foni (Inode saturation):
mkdir -p "$AUDIT_MNT/orphaned_sessions"
echo "4. Inode to'lishi nosozligi shakllantirilmoqda..."
for i in $(seq 1 1990); do
    touch "$AUDIT_MNT/orphaned_sessions/sess_${i}.lock" 2>/dev/null || break
done

# Huquqlarni to'g'irlash
chmod +x "$DIR"/*.sh "$DIR/paypulse-db"/*.sh "$DIR/paypulse-audit"/*.sh 2>/dev/null || true
chmod +x "$DIR/paypulse-db/engine.py" "$DIR/paypulse-audit/audit_worker.py" 2>/dev/null || true

echo ""
echo "✅ MUHIT MUVAFFAQIYATLI TAYYORLANDI!"
echo "   - JIRA TICKET: JIRA_TICKET.md faylini o'qing."
echo "   - HANDBOOK:    HANDBOOK.md qo'llanmasidan foydalaning."
echo "   - AUDIT:       ./paypulse-audit/run_audit.sh (Hozir yiqiladi: No space left on device)"
echo "   - DB ENGINE:   ./paypulse-db/start_engine.sh (Hozir yiqiladi: Mount yo'q)"
echo "=========================================================="
