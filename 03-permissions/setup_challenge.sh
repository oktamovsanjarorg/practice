#!/bin/bash
# 03-permissions: Challenge muhitini sozlash

VAULT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/vault"
rm -rf "$VAULT_DIR" 2>/dev/null || true
mkdir -p "$VAULT_DIR"

# 1. Maxfiy backup fayl (noto'g'ri ochiq huquqda: 777)
echo "DATABASE_DUMP_PASSWORDS: admin_hash_98741" > "$VAULT_DIR/secret_database.bak"
chmod 777 "$VAULT_DIR/secret_database.bak"

# 2. Ishga tushirish skripti (x huquqi yetishmaydi: 644)
cat << 'EOF' > "$VAULT_DIR/deploy_app.sh"
#!/bin/bash
echo "Deploying production application..."
EOF
chmod 644 "$VAULT_DIR/deploy_app.sh"

# 3. Jamoaviy papka (SGID biti qo'yilmagan: 755)
mkdir -p "$VAULT_DIR/team_share"
chmod 755 "$VAULT_DIR/team_share"

# 4. Umumiy vaqtinchalik bo'lim (Sticky bit qo'yilmagan: 777)
mkdir -p "$VAULT_DIR/public_dropzone"
chmod 777 "$VAULT_DIR/public_dropzone"

# 5. Xavfli SUID fayl (zararsizlantirish kerak: 4755)
echo "#!/bin/bash" > "$VAULT_DIR/backdoor_tool"
echo "echo 'Rogue binary execution...'" >> "$VAULT_DIR/backdoor_tool"
chmod 4755 "$VAULT_DIR/backdoor_tool"

echo "✅ [SECOPS CHALLENGE TAYYOR]"
echo "Tekshiruv manzili: $VAULT_DIR"
echo "Fayllar holatini 'ls -la $VAULT_DIR' orqali ko'ring."
