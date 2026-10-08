#!/usr/bin/env python3
import os
import sys
import subprocess

MOUNT_PATH = "/mnt/paypulse_data"

def check_and_start():
    print("=" * 65)
    print("🚀 PAYPULSE CORE TRANSACTION ENGINE: STORAGE PREFLIGHT CHECK")
    print("=" * 65)

    # 1. Mount nuqtasi mavjudligini tekshirish
    if not os.path.exists(MOUNT_PATH):
        print(f"❌ [STORAGE ERROR] Ulanish nuqtasi '{MOUNT_PATH}' topilmadi.")
        print("   Arxitektura talabi: Alohida xotira diski ulanishi (mount) shart.")
        sys.exit(1)

    # 2. Alohida mount ekanligini tekshirish (root partition bo'lmasligi kerak)
    res_mount = subprocess.run(["mountpoint", "-q", MOUNT_PATH])
    if res_mount.returncode != 0:
        print(f"❌ [STORAGE VIOLATION] '{MOUNT_PATH}' alohida fayl tizimi emas (root diskda oddiy papka)!")
        print("   FinTech xavfsizlik siyosati: Ledger tranzaksiyalari alohida ajratilgan xotiraga yozilishi shart.")
        sys.exit(2)

    # 3. Fayl tizimi turini tekshirish (ext4)
    res_fs = subprocess.run(["findmnt", "-n", "-o", "FSTYPE", MOUNT_PATH], capture_output=True, text=True)
    fstype = res_fs.stdout.strip()
    if fstype != "ext4":
        print(f"❌ [FILESYSTEM MISMATCH] Fayl tizimi '{fstype}' aniqlandi.")
        print("   ACID Transaction Policy: Tranzaksiya jurnali faqat 'ext4' fayl tizimini qo'llab-quvvatlaydi.")
        sys.exit(3)

    # 4. Xotira hajmini tekshirish (kamida 150 MB)
    stat = os.statvfs(MOUNT_PATH)
    total_mb = (stat.f_blocks * stat.f_frsize) / (1024 * 1024)
    if total_mb < 150:
        print(f"❌ [INSUFFICIENT CAPACITY] Xotira hajmi juda kichik: {total_mb:.1f} MB.")
        print("   Minimal talab: Kamida 200 MB disk hajmi ajratilishi lozim.")
        sys.exit(4)

    # 5. Yozish huquqini tekshirish (Permissions check)
    wal_file = os.path.join(MOUNT_PATH, "ledger.wal")
    db_file = os.path.join(MOUNT_PATH, "transactions.db")
    try:
        with open(wal_file, "a") as f:
            f.write("TX_BLOCK_INIT: TIMESTAMP=2026-10-08 STATUS=COMMITTED\n")
        with open(db_file, "w") as f:
            f.write("SQLITE_HEADER: PAYPULSE_LEDGER_V4_ACTIVE\n")
    except PermissionError:
        current_user = os.environ.get("USER", "current_user")
        print(f"❌ [PERMISSION DENIED] Foydalanuvchi '{current_user}' '{MOUNT_PATH}' katalogiga yoza olmaydi!")
        print("   Tizim xatoligi: Yangi disk ulanganida (mount) katalog egasi root bo'lib qoladi.")
        print("   Katalog egaligi va yozish huquqini to'g'irlash zarur.")
        sys.exit(5)
    except Exception as e:
        print(f"❌ [IO ERROR] Tranzaksiyani yozishda kutilmagan xatolik: {e}")
        sys.exit(5)

    print(f"✅ [SUCCESS] Xotira tekshiruvi muvaffaqiyatli: ext4 hajmi ({total_mb:.0f} MB).")
    print(f"✅ [ONLINE] PayPulse Core Transaction Engine ISHGA TUSHDI!")
    print(f"   Tranzaksiyalar fayli: {db_file}")
    print(f"   WAL jurnali: {wal_file}")
    print("=" * 65)

if __name__ == "__main__":
    check_and_start()
