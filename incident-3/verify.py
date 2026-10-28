#!/usr/bin/env python3
import os
import sys
import urllib.request
import urllib.parse

LAB_DIR = "/home/sanjar/labs/practice/incident-3"
def _get_telegram_creds():
    token = os.environ.get("TELEGRAM_BOT_TOKEN")
    chat_id = os.environ.get("TELEGRAM_CHAT_ID")
    if not token or not chat_id:
        env_path = os.path.expanduser("~/.config/devops/telegram.env")
        if os.path.isfile(env_path):
            try:
                with open(env_path) as ef:
                    for line in ef:
                        line = line.strip().replace("export ", "")
                        if line.startswith("TELEGRAM_BOT_TOKEN="):
                            token = line.split("=", 1)[1].strip().strip('"')
                        elif line.startswith("TELEGRAM_CHAT_ID="):
                            chat_id = line.split("=", 1)[1].strip().strip('"')
            except Exception:
                pass
    return token, chat_id

BOT_TOKEN, CHAT_ID = _get_telegram_creds()

candidates = [
    os.path.join(LAB_DIR, "recovered_vault.txt"),
    os.path.join(LAB_DIR, "production.vault"),
    os.path.join(LAB_DIR, "vault.txt")
]

target_file = None
for c in candidates:
    if os.path.isfile(c):
        target_file = c
        break

if not target_file:
    print("❌ Qayta tiklangan fayl topilmadi!")
    print("Faylni quyidagi nomlardan biri bilan saqlang:")
    print("   ~/labs/sandbox/incident-phantom/recovered_vault.txt")
    print("   ~/labs/sandbox/incident-phantom/production.vault")
    sys.exit(1)

with open(target_file, "r", errors="ignore") as f:
    content = f.read()

if "FLAG{LINUX_PROC_FD_FORENSICS_2026}" in content and "MASTER_RECOVERY_KEY=0x9A4B8C1D7E3F" in content:
    print("=" * 64)
    print("🎉 G'ALABA! O'CHIRILGAN FAYL LINUX YADROSI (/proc) ORQALI TIKLANDI!")
    print("=" * 64)
    print("Topilgan Flag:")
    for line in content.splitlines():
        if "FLAG" in line:
            print("  ", line)
    print("\n🧠 Mental Model (Nega bunday bo'ldi?):")
    print("1. Linux-da 'rm' buyrug'i faylni jismonan diskdan o'chirib yubormaydi.")
    print("2. U faqat dentry (fayl nomi havolasi)ni o'chiradi (unlink).")
    print("3. Tizimda biron bir jarayon faylni ochiq (open file descriptor) ushlab turgan ekan,")
    print("   Linux Yadrosi (VFS) ushbu fayl xotirasini va disk bloklarini ASLO bo'shatmaydi!")
    print("4. /proc/<PID>/fd/<FD> orqali esa o'chirilgan faylni to'liq tiklab olish mumkin!")
    print("=" * 64)

    msg = (
        "🏆 <b>[INCIDENT RESOLVED] PHANTOM-RESCUE-01</b>\n\n"
        "<b>Muhandis:</b> Sanjar\n"
        "<b>Natija:</b> O'chirilgan <code>production.vault</code> fayli Linux yadrosi (/proc/*/fd) orqali to'liq tiklandi!\n\n"
        "<i>\"Haqiqiy DevOps uchun diskdan o'chirilgan fayl hali o'lmagan fayldir!\"</i> 🚀"
    )
    if BOT_TOKEN and CHAT_ID:
        url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
        data = urllib.parse.urlencode({"chat_id": CHAT_ID, "text": msg, "parse_mode": "HTML"}).encode()
        try:
            urllib.request.urlopen(urllib.request.Request(url, data=data), timeout=5)
            print("📲 Telegramingizga (@Sanjaroktamovbot) g'alaba hisoboti yuborildi!")
        except Exception:
            pass

    pid_file = os.path.join(LAB_DIR, ".daemon.pid")
    if os.path.exists(pid_file):
        try:
            with open(pid_file) as pf:
                pid = int(pf.read().strip())
            os.kill(pid, 9)
            os.remove(pid_file)
        except Exception:
            pass
    sys.exit(0)
else:
    print("⚠️ Fayl topildi, lekin uning ichidagi maxfiy kalitlar to'liq emas.")
    sys.exit(2)
