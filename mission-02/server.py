import os
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler

port = int(os.environ.get("PORT", "80"))
log_path = os.environ.get("LOG_FILE", "logs/app.log")

try:
    with open(log_path, "a") as f:
        f.write(f"[STARTUP] Server starting on port {port}\n")
except Exception as e:
    sys.stderr.write(f"[FATAL] Cannot write to log file {log_path}: {e}\n")
    sys.exit(1)

class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"STATUS: OK - payments-api is running\n")
        try:
            with open(log_path, "a") as f:
                f.write(f"[REQUEST] GET {self.path} 200 OK\n")
        except Exception:
            pass

    def log_message(self, format, *args):
        pass

try:
    server = HTTPServer(("0.0.0.0", port), SimpleHandler)
    server.serve_forever()
except PermissionError:
    sys.stderr.write(f"[FATAL] Permission denied binding to port {port} (Ports < 1024 require root!)\n")
    sys.exit(1)
except Exception as e:
    sys.stderr.write(f"[FATAL] Failed to start server: {e}\n")
    sys.exit(1)
