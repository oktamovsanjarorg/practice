#!/bin/bash
# 01-filesystem: Nosozlik muhitini sozlash

echo "🚨 [SYSTEM ALERT] blackbox-service xizmati qulagan holatga keltirilmoqda..."

# Eski qoldiqlarni tozalash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$DIR/service.sh" stop >/dev/null 2>&1 || true
sudo rm -rf /etc/blackbox /var/log/blackbox 2>/dev/null || true

# 1. /etc/blackbox katalogi va konfiguratsiyalar
sudo mkdir -p /etc/blackbox/configs

# To'g'ri yangi konfiguratsiya fayli, lekin ichida noto'g'ri RAM talabi (999999999 kB) bor:
sudo tee /etc/blackbox/configs/v2_production.conf > /dev/null << 'EOF'
[service]
name = blackbox-core
environment = production

[logging]
# FHS talabiga binoan jurnallar /var/log da bo'lishi kerak:
log_file = /var/log/blackbox/service.log

# Buzilgan havola (Broken Symlink) yaratamiz:
sudo ln -sf /etc/blackbox/configs/non_existent_old.conf /etc/blackbox/active.conf

# 2. /var/log/blackbox papkasi ataylab yaratilmaydi (xizmat log yoza olmasligi uchun)

echo ""
echo "✅ Incident tayyorlandi! Xizmat butunlay yaroqsiz holatda."
echo "Sinab ko'rish uchun: ./service.sh start"
