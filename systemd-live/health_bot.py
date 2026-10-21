#!/usr/bin/env python3
import time
import os
import sys

pid = os.getpid()
print(f"🚀 [START] Bot muvaffaqiyatli ishga tushdi! PID: {pid}", flush=True)

count = 1
try:
    while True:
        print(f"💓 [HEARTBEAT #{count}] Bot faol ishlamoqda. PID: {pid}", flush=True)
        time.sleep(3)
        count += 1
except KeyboardInterrupt:
    print("🛑 [STOP] Bot to'xtatildi.", flush=True)
    sys.exit(0)
