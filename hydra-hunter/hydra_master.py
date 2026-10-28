#!/usr/bin/env python3
import os
import sys
import time
import subprocess
import signal

DIR = os.path.dirname(os.path.abspath(__file__))
LOG_FILE = os.path.join(DIR, "hydra.log")
HEAD_SCRIPT = os.path.join(DIR, "hydra_head.py")
MAX_HEADS = 16
AUTO_SHUTDOWN_SECONDS = 360  # 6 minutes

start_time = time.time()
counter = 0
heads = {}  # pid -> head_id

def log(msg):
    ts = time.strftime("%H:%M:%S")
    line = f"[{ts}] {msg}\n"
    with open(LOG_FILE, "a") as f:
        f.write(line)

def spawn_head():
    global counter
    counter += 1
    head_name = f"head_{counter}"
    proc = subprocess.Popen([sys.executable, HEAD_SCRIPT, head_name], cwd=DIR)
    heads[proc.pid] = proc
    log(f"🌱 Yangi bosh paydo bo'ldi: {head_name} (PID: {proc.pid})")
    return proc.pid

def cleanup_and_exit(signum=None, frame=None):
    log("💀 Master jarayoni to'xtatildi.")
    sys.exit(0)

signal.signal(signal.SIGTERM, cleanup_and_exit)
signal.signal(signal.SIGINT, cleanup_and_exit)

# Initial 3 heads
with open(LOG_FILE, "w") as f:
    f.write(f"=== GIDRA MASTER ISHGA TUSHDI (PID: {os.getpid()}) ===\n")

for _ in range(3):
    spawn_head()

while True:
    if time.time() - start_time > AUTO_SHUTDOWN_SECONDS:
        log("⌛ Vaqt tugadi! Gidra uyquga ketdi.")
        for p in list(heads.values()):
            try:
                p.terminate()
            except Exception:
                pass
        sys.exit(0)

    # Check dead heads
    dead_pids = []
    for pid, proc in list(heads.items()):
        if proc.poll() is not None:
            dead_pids.append(pid)

    for pid in dead_pids:
        del heads[pid]
        log(f"⚔️ Bosh chopildi (PID: {pid})!")
        if len(heads) < MAX_HEADS:
            log("⚡ Uning o'rniga 2 TA YANGI BOSH o'sib chiqmoqda!")
            spawn_head()
            spawn_head()
        else:
            log(f"🔥 DIQQAT: Gidra maksimal quvvatda ({len(heads)} ta bosh)! Yangi bosh sig'maydi!")

    time.sleep(0.3)
