#!/bin/bash
# Eski jarayonlarni tozalash
pkill -f "secret-agent" 2>/dev/null || true
pkill -f "boss-system" 2>/dev/null || true

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
setsid "$DIR/.scripts/boss-system" </dev/null >/dev/null 2>&1 &

sleep 0.5
echo "✅ Jarayonlar orqa fonda (fon rejimida) ishga tushirildi!"
echo "Tekshirish va qidiruvni boshlashingiz mumkin."
