#!/usr/bin/env python3
import os, time, sys

vault_path = "/home/sanjar/labs/practice/incident-3/production.vault"
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
