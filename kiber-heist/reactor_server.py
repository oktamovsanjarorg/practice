#!/usr/bin/env python3
import os
import sys
import time
import socket
import threading
import urllib.request
import urllib.parse
import json

HOST = "127.0.0.1"
PORT = 7777
TIME_LIMIT = 720  # 7 minutes
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

START_TIME = time.time()
MY_PID = os.getpid()
MY_CORES = os.cpu_count()
SECRET_DEFUSE_KEY = "CYBER-ARCH-DEVOPS-2026"

# Ensure environment variable is set in process memory
os.environ["DEFUSE_KEY"] = SECRET_DEFUSE_KEY
os.environ["REACTOR_SECURITY_STATUS"] = "LOCKED_ARMED"

# ANSI Colors
RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
BOLD = "\033[1m"
RESET = "\033[0m"

def send_telegram(text):
    if not BOT_TOKEN or not CHAT_ID:
        return
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    data = urllib.parse.urlencode({
        "chat_id": CHAT_ID,
        "text": text,
        "parse_mode": "HTML",
        "disable_web_page_preview": "true"
    }).encode()
    try:
        req = urllib.request.Request(url, data=data)
        urllib.request.urlopen(req, timeout=5)
    except Exception:
        pass

def handle_client(conn, addr):
    def send(msg):
        try:
            conn.sendall(msg.encode("utf-8"))
        except Exception:
            pass

    def recv_line(prompt=""):
        if prompt:
            send(prompt)
        buf = ""
        while True:
            char = conn.recv(1).decode("utf-8", errors="ignore")
            if not char:
                return None
            if char in ("\r", "\n"):
                if buf:
                    return buf.strip()
            else:
                buf += char

    elapsed = int(time.time() - START_TIME)
    remaining = max(0, TIME_LIMIT - elapsed)
    if remaining <= 0:
        send(f"{RED}{BOLD}💥 VAQT TUGADI! Reaktor portlab ketdi! Qayta boshlash: ./start.sh{RESET}\n")
        conn.close()
        return

    banner = f"""
{RED}{BOLD}╔══════════════════════════════════════════════════════════════════════╗
║  ⚠️   KIBER-XAVFSIZLIK: "SHADOW-CORE" REAKTORI ZARARSIZLANTIRISH      ║
╚══════════════════════════════════════════════════════════════════════╝{RESET}
  {CYAN}Operatsiya:{RESET}  REAKTORNI ZARARSIZLANTIRISH (DEFUSE)
  {YELLOW}Port:{RESET}        {PORT} (TCP)
  {YELLOW}Qolgan vaqt:{RESET} {BOLD}{remaining} soniya{RESET}
  {YELLOW}Holat:{RESET}       {RED}{BOLD}CRITICAL OVERLOAD - TAYMER KETMOQDA!{RESET}

{CYAN}Zararsizlantirish uchun 3 ta himoya kodini ketma-ket kiriting:{RESET}
----------------------------------------------------------------------
"""
    send(banner)

    # STEP 1: PID
    send(f"\n{YELLOW}[BOSQICH 1/3] Ushbu reaktor ishlayotgan jarayonning (PID) raqamini kiriting:{RESET}\n")
    send(f"{CYAN}  (Maslahat: boshqa terminalda 'ss -tulpn' yoki 'lsof -i :{PORT}' orqali qidiring){RESET}\n")
    pid_ans = recv_line(f"{BOLD}PID > {RESET}")
    if pid_ans is None:
        conn.close()
        return

    if pid_ans != str(MY_PID):
        send(f"\n{RED}❌ XATO! Kiritilgan PID ({pid_ans}) noto'g'ri. Aloqa uzildi!{RESET}\n")
        conn.close()
        return

    send(f"\n{GREEN}{BOLD}✅ 1-BOSQICH TASDIQLANDI! Jarayon aniqlandi (PID: {MY_PID}).{RESET}\n")

    # STEP 2: SECRET_DEFUSE_KEY from /proc/<PID>/environ
    send(f"\n{YELLOW}[BOSQICH 2/3] Jarayon xotirasidagi yashirin kalitni (DEFUSE_KEY) kiriting:{RESET}\n")
    send(f"{CYAN}  (Maslahat: /proc/{MY_PID}/environ faylini o'qing yoki 'strings' / 'tr' bilan oching){RESET}\n")
    key_ans = recv_line(f"{BOLD}DEFUSE_KEY > {RESET}")
    if key_ans is None:
        conn.close()
        return

    if key_ans != SECRET_DEFUSE_KEY:
        send(f"\n{RED}❌ XATO! Noto'g'ri kalit. Xavfsizlik protokoli ulanishni bekor qildi!{RESET}\n")
        conn.close()
        return

    send(f"\n{GREEN}{BOLD}✅ 2-BOSQICH TASDIQLANDI! Maxfiy kalit mos keldi.{RESET}\n")

    # STEP 3: CPU cores count
    send(f"\n{YELLOW}[BOSQICH 3/3] Oxirgi qadam: Ushbu mashinadagi jami CPU yadrolari (cores) sonini kiriting:{RESET}\n")
    send(f"{CYAN}  (Maslahat: 'nproc' yoki 'lscpu' buyrug'i natijasi){RESET}\n")
    core_ans = recv_line(f"{BOLD}CPU CORES > {RESET}")
    if core_ans is None:
        conn.close()
        return

    if core_ans != str(MY_CORES):
        send(f"\n{RED}❌ XATO! Yadro soni noto'g'ri. Qaytadan urinib ko'ring!{RESET}\n")
        conn.close()
        return

    # VICTORY!
    victory_art = f"""
{GREEN}{BOLD}
  ██████╗ ███████╗███████╗██╗   ██╗███████╗███████╗██████╗ 
  ██╔══██╗██╔════╝██╔════╝██║   ██║██╔════╝██╔════╝██╔══██╗
  ██║  ██║█████╗  █████╗  ██║   ██║███████╗█████╗  ██║  ██║
  ██║  ██║██╔══╝  ██╔══╝  ██║   ██║╚════██║██╔══╝  ██║  ██║
  ██████╔╝███████╗██║     ╚██████╔╝███████║███████╗██████╔╝
{RESET}
{CYAN}══════════════════════════════════════════════════════════════════════{RESET}
{BOLD}🎉 TABRIKLAYMIZ, SANJAR! "SHADOW-CORE" TO'LIQ ZARARSIZLANTIRILDI!{RESET}
{CYAN}══════════════════════════════════════════════════════════════════════{RESET}
  ⚡ Natija:       3/3 Xavfsizlik bosqichlari 100% muvaffaqiyatli!
  🕒 Qolgan vaqt:  {max(0, TIME_LIMIT - int(time.time() - START_TIME))} soniya
  📲 Telegram:     @Sanjaroktamovbot ga G'alaba hujjati yuborildi!
{CYAN}══════════════════════════════════════════════════════════════════════{RESET}
"""
    send(victory_art)
    conn.close()

    # Send telegram victory
    tel_msg = (
        "🏆 <b>[MISSION ACCOMPLISHED] SHADOW-CORE DEFUSED!</b>\n\n"
        "<b>Qahramon:</b> Sanjar\n"
        "<b>Operatsiya:</b> TCP 7777 kiber-qutqaruv\n"
        "<b>Tekshiruvlar:</b> PID, Kernel Environ va CPU arxitekturasi bir zumda hal qilindi!\n\n"
        "<i>\"Terminal — sizning qurolingiz, Linux — sizning maydoningiz!\"</i> 🚀🔥"
    )
    send_telegram(tel_msg)

    # Self-shutdown after win
    time.sleep(1)
    os._exit(0)

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen(5)

    pid_path = "/home/sanjar/labs/practice/kiber-heist/.reactor.pid"
    with open(pid_path, "w") as f:
        f.write(str(MY_PID))

    while True:
        try:
            conn, addr = server.accept()
            t = threading.Thread(target=handle_client, args=(conn, addr))
            t.daemon = True
            t.start()
        except Exception:
            break

if __name__ == "__main__":
    main()
