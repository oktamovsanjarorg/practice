import os
import sys
import time
import configparser
from http.server import HTTPServer, BaseHTTPRequestHandler

CONF_PATH = "/etc/blackbox/active.conf"

# 1. Check Symlink / Config existence
if not os.path.exists(CONF_PATH):
    if os.path.islink(CONF_PATH):
        target = os.readlink(CONF_PATH)
        sys.stderr.write(f"❌ [CRITICAL] Config symlink {CONF_PATH} is BROKEN! (Points to non-existent '{target}')\n")
    else:
        sys.stderr.write(f"❌ [CRITICAL] Configuration {CONF_PATH} not found!\n")
    sys.exit(1)

# 2. Parse Config
config = configparser.ConfigParser()
try:
    config.read(CONF_PATH)
except Exception as e:
    sys.stderr.write(f"❌ [CRITICAL] Failed to parse config {CONF_PATH}: {e}\n")
    sys.exit(1)

log_file = config.get("logging", "log_file", fallback="/var/log/blackbox/service.log")
min_mem = config.getint("requirements", "min_memory_kb", fallback=8000000)

# 3. Check Log Directory
log_dir = os.path.dirname(log_file)
if not os.path.exists(log_dir):
    sys.stderr.write(f"❌ [CRITICAL] Log directory '{log_dir}' does not exist! FHS requires logs in /var/log/...\n")
    sys.exit(2)

try:
    with open(log_file, "a") as f:
        f.write(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Boot validation in progress...\n")
except Exception as e:
    sys.stderr.write(f"❌ [CRITICAL] Cannot write to log file '{log_file}': {e}\n")
    sys.exit(2)

# 4. Check /proc/meminfo
actual_mem = None
try:
    with open("/proc/meminfo", "r") as f:
        for line in f:
            if line.startswith("MemTotal:"):
                actual_mem = int(line.split()[1])
                break
except Exception as e:
    sys.stderr.write(f"❌ [CRITICAL] Failed to read /proc/meminfo: {e}\n")
    sys.exit(3)

if actual_mem is None or actual_mem < min_mem:
    sys.stderr.write(f"❌ [CRITICAL] Kernel memory requirement failed!\n")
    sys.stderr.write(f"   Host has: {actual_mem} kB RAM (/proc/meminfo)\n")
    sys.stderr.write(f"   Config requires: {min_mem} kB RAM ({CONF_PATH})\n")
    sys.stderr.write(f"   Fix the requirement in the config to match host resources!\n")
    sys.exit(3)

# 5. Boot HTTP Health Service
class HealthHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"200 OK: BLACKBOX_CORE_HEALTHY\n")
        try:
            with open(log_file, "a") as f:
                f.write(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Healthcheck probe 200 OK\n")
        except Exception:
            pass

    def log_message(self, format, *args):
        pass

try:
    with open(log_file, "a") as f:
        f.write(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Service successfully booted on port 8888\n")
    print("✅ [BOOT SUCCESS] blackbox-service is RUNNING on http://127.0.0.1:8888")
    server = HTTPServer(("127.0.0.1", 8888), HealthHandler)
    server.serve_forever()
except Exception as e:
    sys.stderr.write(f"❌ [CRITICAL] Failed to start HTTP server: {e}\n")
    sys.exit(4)
