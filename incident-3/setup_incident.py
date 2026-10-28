#!/usr/bin/env python3
import os
import sys
import time
import subprocess
import urllib.request
import urllib.parse
import json

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

SECRET_CONTENT = """# [CONFIDENTIAL PRODUCTION ENVIRONMENT VAULT]
# INCIDENT: PHANTOM-RESCUE-01
FLAG=FLAG{LINUX_PROC_FD_FORENSICS_2026}
DATABASE_URL=postgresql://fintech_admin:v99_SuperSecretKernelPass@prod-db.internal:5432/payments
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
MASTER_RECOVERY_KEY=0x9A4B8C1D7E3F
"""

def send_telegram(text):
    if not BOT_TOKEN or not CHAT_ID:
        return None
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    data = urllib.parse.urlencode({
        "chat_id": CHAT_ID,
        "text": text,
        "parse_mode": "HTML",
        "disable_web_page_preview": "true"
    }).encode()
    req = urllib.request.Request(url, data=data)
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            return json.load(r)
    except Exception as e:
        sys.stderr.write(f"Telegram error: {e}\n")
        return None

def setup():
    os.makedirs(LAB_DIR, exist_ok=True)
    pid_file = os.path.join(LAB_DIR, ".daemon.pid")
    
    # Kill any existing daemon
    if os.path.exists(pid_file):
        try:
            with open(pid_file) as pf:
                pid = int(pf.read().strip())
            os.kill(pid, 9)
        except Exception:
            pass
        os.remove(pid_file)

    vault_file = os.path.join(LAB_DIR, "production.vault")
    with open(vault_file, "w") as f:
        f.write(SECRET_CONTENT)

    worker_script = os.path.join(LAB_DIR, "vault-sync-worker.py")
    with open(worker_script, "w") as f:
        f.write(f'''#!/usr/bin/env python3
import os, time, sys

vault_path = "{vault_file}"
try:
    # Open file descriptor
    fd = open(vault_path, "r")
    # Simulate accidental deletion from disk
    os.unlink(vault_path)
except Exception as e:
    sys.exit(1)

# Keep holding the file descriptor in memory
while True:
    time.sleep(2)
''')
    os.chmod(worker_script, 0o755)

    # Spawn daemon completely detached
    proc = subprocess.Popen(
        [sys.executable, worker_script],
        cwd=LAB_DIR,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        stdin=subprocess.DEVNULL,
        start_new_session=True
    )
    with open(pid_file, "w") as pf:
        pf.write(str(proc.pid))

    # Give it 0.5s to start and unlink
    time.sleep(0.5)

    # Create verify.sh
    verifier_script = f'''#!/usr/bin/env python3
import os
import sys
import urllib.request
import urllib.parse

LAB_DIR = "{LAB_DIR}"

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

if "FLAG{{LINUX_PROC_FD_FORENSICS_2026}}" in content and "MASTER_RECOVERY_KEY=0x9A4B8C1D7E3F" in content:
    print("=" * 64)
    print("🎉 G'ALABA! O'CHIRILGAN FAYL LINUX YADROSI (/proc) ORQALI TIKLANDI!")
    print("=" * 64)
    print("Topilgan Flag:")
    for line in content.splitlines():
        if "FLAG" in line:
            print("  ", line)
    print("\\n🧠 Mental Model (Nega bunday bo'ldi?):")
    print("1. Linux-da 'rm' buyrug'i faylni jismonan diskdan o'chirib yubormaydi.")
    print("2. U faqat dentry (fayl nomi havolasi)ni o'chiradi (unlink).")
    print("3. Tizimda biron bir jarayon faylni ochiq (open file descriptor) ushlab turgan ekan,")
    print("   Linux Yadrosi (VFS) ushbu fayl xotirasini va disk bloklarini ASLO bo'shatmaydi!")
    print("4. /proc/<PID>/fd/<FD> orqali esa o'chirilgan faylni to'liq tiklab olish mumkin!")
    print("=" * 64)

    msg = (
        "🏆 <b>[INCIDENT RESOLVED] PHANTOM-RESCUE-01</b>\\n\\n"
        "<b>Muhandis:</b> Sanjar\\n"
        "<b>Natija:</b> O'chirilgan <code>production.vault</code> fayli Linux yadrosi (/proc/*/fd) orqali to'liq tiklandi!\\n\\n"
        "<i>\\\"Haqiqiy DevOps uchun diskdan o'chirilgan fayl hali o'lmagan fayldir!\\\"</i> 🚀"
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
'''
    v_py = os.path.join(LAB_DIR, "verify.py")
    with open(v_py, "w") as f:
        f.write(verifier_script)
    os.chmod(v_py, 0o755)

    v_sh = os.path.join(LAB_DIR, "verify.sh")
    with open(v_sh, "w") as f:
        f.write(f"#!/usr/bin/env bash\npython3 {v_py}\n")
    os.chmod(v_sh, 0o755)

    # Send telegram alert
    alert_text = (
        "🚨 <b>[CRITICAL INCIDENT] KOD: PHANTOM-404</b>\n"
        "<b>Prioritet:</b> P1 (Data Loss Emergency)\n"
        "<b>Host:</b> Arch Linux (Local Node)\n"
        "<b>Joylashuv:</b> <code>~/labs/sandbox/incident-phantom/</code>\n\n"
        "<b>Hodisa Tafsiloti:</b>\n"
        "Kompaniyaning eng muhim maxfiy kalitlari (<code>production.vault</code>) diskdan <code>rm -f</code> orqali o'chirib yuborildi! Git'da yo'q, zaxira nusxasi yo'q!\n\n"
        "Ammo tizimda ushbu fayl bilan ishlayotgan bitta fantom jarayon (worker) hali ham tirik.\n\n"
        "⚠️ <b>Diqqat:</b> Jarayonni o'ldirsangiz (kill), kalit abadiy yo'qoladi!\n\n"
        "🎯 <b>Vazifa:</b>\n"
        "Linux Kernel (<code>/proc</code>) orqali o'chirilgan faylni toping va <code>recovered_vault.txt</code> nomiga tiklang!\n"
        "Keyin <code>./verify.sh</code> ni ishga tushiring."
    )
    send_telegram(alert_text)
    print("PROVISIONED_SUCCESSFULLY")

if __name__ == "__main__":
    setup()
