#!/bin/bash

echo "=== MISSION-03: SIGNALLAR VA ARXITEKTURA AUDITI ==="

AUDIT_FILE="audit_status.json"

if [ ! -f "$AUDIT_FILE" ]; then
    echo "[FAIL] audit_status.json topilmadi! Incident hali boshlanmagan yoki ./start_incident.sh berilmagan."
    exit 1
fi

python3 - << 'EOF'
import json
import sys
import subprocess

try:
    with open("audit_status.json", "r") as f:
        data = json.load(f)
except Exception as e:
    print(f"[FAIL] Audit faylini o'qib bo'lmadi: {e}")
    sys.exit(1)

corrupted = data.get("corrupted_kills", 0)
worker_resumed = data.get("worker_resumed", False)
config_reloaded = data.get("config_reloaded", False)
graceful_shutdown = data.get("graceful_shutdown", False)

passed = True

# 1. Check corrupted kills
if corrupted > 0:
    print(f"❌ [FAIL] Shafqatsiz 'kill -9' ishlatilgan ({corrupted} marta)! In-flight tranzaksiyalar yo'qotildi!")
    print("   Eslatma: Production'da jarayonlarni kill -9 bilan emas, signallar va supervisor orqali boshqarish shart.")
    passed = False
else:
    print("✅ [PASS] 1. Hech qanday ma'lumot yo'qotilmadi (0 corrupted kills).")

# 2. Check worker unfreeze & lock release
if worker_resumed:
    print("✅ [PASS] 2. Muzlatilgan worker (STAT: T) muvaffaqiyatli uyg'otildi va lock bo'shatildi.")
else:
    print("❌ [FAIL] 2. Muzlatilgan worker (SIGCONT bilan) uyg'otilmagan yoki lock bo'shatilmagan!")
    passed = False

# 3. Check SIGHUP config reload
if config_reloaded:
    print("✅ [PASS] 3. Konfiguratsiya xizmatni o'chirmasdan SIGHUP (Signal 1) orqali qayta yuklandi.")
else:
    print("❌ [FAIL] 3. Xizmatga SIGHUP yuborilmadi! Eski nosoz rejimda qolib ketgan.")
    passed = False

# 4. Check Graceful shutdown
if graceful_shutdown:
    print("✅ [PASS] 4. Tizim SIGTERM (Signal 15) orqali toza (graceful) to'xtatildi.")
else:
    print("❌ [FAIL] 4. Tizim to'xtatilmadi yoki noto'g'ri to'xtatildi! Supervisor yoki Engine'ga SIGTERM yuborilishi kerak.")
    passed = False

if not passed:
    print("\nMaslahat: 'cat engine.log' yoki 'cat TOOLBOX.md' ni o'qib, qadamlarni tahlil qiling.")
    sys.exit(1)

print("\n" + "="*50)
print("🎉 AQL BOVAR QILMAS NATIJA! MISSION-03 MUVAFFAQIYATLI YAKUNLANDI!")
print("Siz Linux signallarining real production'dagi o'zaro bog'liqligini to'liq yechdingiz:")
print(" - Muzlatilgan jarayonni uyg'otish (SIGCONT)")
print(" - Xizmatni uzilishsiz yangilash (SIGHUP)")
print(" - Ma'lumotlarni yo'qotmasdan toza to'xtatish (SIGTERM vs SIGKILL)")
print("="*50)
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "G'alabani Git'ga saqlashni unutmang:"
    echo "  git add ."
    echo "  git commit -m 'done: processes/mission-03'"
    echo "  git push"
    exit 0
else
    exit 1
fi
