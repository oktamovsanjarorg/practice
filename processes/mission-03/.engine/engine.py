import os
import sys
import time
import signal
import json

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOG_FILE = os.path.join(BASE_DIR, "engine.log")
LOCK_FILE = "/tmp/practice_tx.lock"
AUDIT_FILE = os.path.join(BASE_DIR, "audit_status.json")
CONFIG_FILE = os.path.join(BASE_DIR, "config.json")

def log(msg):
    ts = time.strftime("%Y-%m-%d %H:%M:%S")
    formatted = f"[{ts}] {msg}"
    print(formatted, flush=True)

audit_data = {
    "worker_resumed": False,
    "lock_cleared": False,
    "config_reloaded": False,
    "graceful_shutdown": False,
    "corrupted_kills": 0
}

def save_audit():
    with open(AUDIT_FILE, "w") as f:
        json.dump(audit_data, f, indent=2)

save_audit()

system_mode = "MAINTENANCE_BLOCKED"
worker_pid = None

def spawn_worker():
    global worker_pid
    # Create lock file
    with open(LOCK_FILE, "w") as f:
        f.write("TX_IN_PROGRESS: Order #98421 - $450.00\n")
    
    # Fork a child worker that pauses itself with SIGSTOP
    pid = os.fork()
    if pid == 0:
        # Child process: tx_worker
        # Set process name if possible
        try:
            import ctypes
            libc = ctypes.CDLL('libc.so.6')
            libc.prctl(15, b'tx-worker', 0, 0, 0)
        except Exception:
            pass
        
        # Child pauses itself simulating a freeze/hang
        os.kill(os.getpid(), signal.SIGSTOP)
        
        # When resumed via SIGCONT, finish transaction and release lock
        time.sleep(0.5)
        if os.path.exists(LOCK_FILE):
            os.remove(LOCK_FILE)
        sys.exit(0)
    else:
        worker_pid = pid
        log(f"[STARTUP] Payment Engine started (PID: {os.getpid()}). Current mode: {system_mode}")
        log(f"[WARN] In-flight transaction worker spawned (PID: {worker_pid}), but got FROZEN with lock {LOCK_FILE}!")
        log(f"[HINT] Check worker state using 'ps aux | grep {worker_pid}' (notice the STAT column)!")

spawn_worker()

def handle_sighup(signum, frame):
    global system_mode
    log(f"[SIGNAL] SIGHUP (Signal 1) received!")
    if os.path.exists(LOCK_FILE):
        log(f"[BLOCKED] SIGHUP reload aborted! Lock {LOCK_FILE} is still held by worker PID {worker_pid}!")
        log(f"[ACTION NEEDED] You must unfreeze/resume worker PID {worker_pid} first!")
        return

    try:
        with open(CONFIG_FILE, "r") as f:
            cfg = json.load(f)
            system_mode = cfg.get("system_mode", "ACTIVE")
            audit_data["config_reloaded"] = True
            audit_data["worker_resumed"] = True
            audit_data["lock_cleared"] = True
            save_audit()
            log(f"[SUCCESS] Config reloaded via SIGHUP! System mode is now: {system_mode}")
            log(f"[NEXT STEP] Now perform a GRACEFUL shutdown (SIGTERM) to finalize the operation.")
    except Exception as e:
        log(f"[ERROR] Failed to read config: {e}")

def handle_sigterm(signum, frame):
    log(f"[SIGNAL] SIGTERM (Signal 15) received. Performing graceful shutdown...")
    if os.path.exists(LOCK_FILE):
        os.remove(LOCK_FILE)
    audit_data["graceful_shutdown"] = True
    save_audit()
    log(f"[SHUTDOWN] All buffers flushed. Clean exit with 0 data loss.")
    sys.exit(0)

signal.signal(signal.SIGHUP, handle_sighup)
signal.signal(signal.SIGTERM, handle_sigterm)

while True:
    time.sleep(1)
