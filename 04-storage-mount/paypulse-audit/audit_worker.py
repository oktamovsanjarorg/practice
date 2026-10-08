#!/usr/bin/env python3
import os
import sys
import subprocess

AUDIT_PATH = "/mnt/paypulse_audit"

def run_audit():
    print("=" * 65)
    print("🔍 PAYPULSE REGULATORY COMPLIANCE AUDITOR (PCI-DSS & SEC)")
    print("=" * 65)

    if not os.path.exists(AUDIT_PATH):
        print(f"❌ [CRITICAL ERROR] Audit xotirasi '{AUDIT_PATH}' topilmadi!")
        print("   Iltimos, avval ./setup_challenge.sh skriptini ishga tushiring.")
        sys.exit(1)

    target_file = os.path.join(AUDIT_PATH, "compliance_2026.log")

    print(f"1. Audit hisobotini yozishga urinish: {target_file}")
    try:
        with open(target_file, "w") as f:
            f.write("2026-10-08 09:00:00 [AUDIT_PASS] All 4,819,200 transactions certified.\n")
            f.write("Integrity hash: SHA256(9a8fbc81d...e01) VALID.\n")
        print("✅ [SUCCESS] Audit hisoboti muvaffaqiyatli yaratildi va saqlandi!")
        print(f"   Hisobot manzili: {target_file}")
        print("=" * 65)
    except OSError as e:
        print(f"\n❌ [CRITICAL ENOSPC ERROR] Hisobotni yozib bo'lmadi: {e}")
        print("   Alomat: Tizim yadrosi 'No space left on device' xatosini qaytardi.")
        print("   Jira xabari: 'df -h' da disk bo'sh ko'rinsa-da, tizim nima sababdan fayl yozolmayapti?")
        print("   Tahlil qiling: Inodlar (df -i) bandligini tekshiring.")
        print("=" * 65)
        sys.exit(2)

if __name__ == "__main__":
    run_audit()
