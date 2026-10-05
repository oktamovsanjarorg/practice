#!/usr/bin/env python3
import sys
import time

# 10 ta muvaffaqiyatli xabar (stdout - 1)
# 5 ta xatolik xabari (stderr - 2)

events = [
    ("out", "[SUCCESS] txn_id=1001 user=sanjar amount=$50.00 status=200\n"),
    ("err", "[ERROR] DB_TIMEOUT: Connection pool exhausted\n"),
    ("out", "[SUCCESS] txn_id=1002 user=malik amount=$120.00 status=200\n"),
    ("err", "[ERROR] PAYMENT_REJECTED: Insufficient balance\n"),
    ("out", "[SUCCESS] txn_id=1003 user=aziza amount=$15.00 status=200\n"),
    ("err", "[ERROR] DB_TIMEOUT: Connection pool exhausted\n"),
    ("out", "[SUCCESS] txn_id=1004 user=jasur amount=$99.00 status=200\n"),
    ("err", "[ERROR] AUTH_FAILED: Invalid JWT signature\n"),
    ("out", "[SUCCESS] txn_id=1005 user=nodir amount=$250.00 status=200\n"),
    ("err", "[ERROR] DB_TIMEOUT: Connection pool exhausted\n"),
    ("out", "[SUCCESS] txn_id=1006 user=shohrux amount=$10.00 status=200\n"),
    ("out", "[SUCCESS] txn_id=1007 user=dilshod amount=$45.00 status=200\n"),
    ("out", "[SUCCESS] txn_id=1008 user=umid amount=$80.00 status=200\n"),
    ("out", "[SUCCESS] txn_id=1009 user=kamol amount=$300.00 status=200\n"),
    ("out", "[SUCCESS] txn_id=1010 user=farrux amount=$75.00 status=200\n"),
]

for stream, msg in events:
    if stream == "out":
        sys.stdout.write(msg)
        sys.stdout.flush()
    else:
        sys.stderr.write(msg)
        sys.stderr.flush()
