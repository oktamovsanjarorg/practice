import os
import sys

user = os.getenv("DB_USER")
pwd = os.getenv("DB_PASS")

if not user or not pwd:
    print(f"❌ XATO: DB_USER='{user}', DB_PASS='{pwd}'. Python bu o'zgaruvchilarni ko'rmayapti!")
    sys.exit(1)

print(f"🎉 AJOYIB! Python o'zgaruvchilarni ko'rdi:")
print(f"   DB_USER = {user}")
print(f"   DB_PASS = {pwd}")
