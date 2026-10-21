import os
import sqlite3
import http.server
import socketserver
import json
import sys

DB_PATH = "/app/data/orders.db"
PORT = 8000

print(f"[INIT] Ilova ishga tushmoqda... UID: {os.getuid()}", flush=True)
print(f"[INIT] SQLite ma'lumotlar bazasi ochilmoqda: {DB_PATH}", flush=True)

try:
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY, item TEXT)")
    conn.commit()
    print("[INIT] Ma'lumotlar bazasi muvaffaqiyatli ishga tushdi!", flush=True)
except Exception as e:
    print(f"[FATAL ERROR] Ma'lumotlar bazasini yaratishda halokatli xato: {e}", file=sys.stderr, flush=True)
    sys.exit(1)

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({
            "status": "success",
            "service": "orders-db-api",
            "message": "Buyurtmalar xizmati 100% barqaror ishlamoqda!"
        }).encode())

print(f"[READY] Server {PORT}-portda tinglashni boshladi...", flush=True)
with socketserver.TCPServer(("0.0.0.0", PORT), Handler) as httpd:
    httpd.serve_forever()
