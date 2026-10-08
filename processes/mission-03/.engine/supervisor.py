import os
import sys
import time
import subprocess
import signal
import json

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOG_FILE = os.path.join(BASE_DIR, "engine.log")
AUDIT_FILE = os.path.join(BASE_DIR, "audit_status.json")

def log(msg):
    ts = time.strftime("%Y-%m-%d %H:%M:%S")
    formatted = f"[{ts}] [WATCHDOG] {msg}"
    print(formatted, flush=True)

proc = None
running = True

def handle_term(signum, frame):
    global running, proc
    log("Termination signal received. Shutting down managed engine gracefully...")
    running = False
    if proc and proc.poll() is None:
        proc.send_signal(signal.SIGTERM)
        try:
            proc.wait(timeout=3)
        except subprocess.TimeoutExpired:
            proc.kill()
    sys.exit(0)

signal.signal(signal.SIGTERM, handle_term)
signal.signal(signal.SIGINT, handle_term)

while running:
    engine_script = os.path.join(os.path.dirname(__file__), "engine.py")
    proc = subprocess.Popen([sys.executable, engine_script])
    log(f"Spawned payment-engine with PID: {proc.pid}")
    
    ret = proc.wait()
    
    if not running:
        break
        
    if ret == 0:
        log("Engine exited normally (0). Watchdog stopping.")
        break
    else:
        # Abnormal termination (e.g. SIGKILL -9 or returncode != 0)
        log(f"⚠️ DANGER: Engine PID {proc.pid} died abruptly with code {ret}! In-flight data corrupted!")
        try:
            if os.path.exists(AUDIT_FILE):
                with open(AUDIT_FILE, "r") as f:
                    data = json.load(f)
                data["corrupted_kills"] = data.get("corrupted_kills", 0) + 1
                with open(AUDIT_FILE, "w") as f:
                    json.dump(data, f, indent=2)
        except Exception:
            pass
        log("Reviving a fresh engine instance in 1 second...")
        time.sleep(1)
