import sys
import os
from http.server import HTTPServer, BaseHTTPRequestHandler

class GatewayHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"GATEWAY_OK: Production Web Gateway v2 is running on port 8080\n")
    def log_message(self, format, *args):
        pass

try:
    server = HTTPServer(("0.0.0.0", 8080), GatewayHandler)
    print("Web Gateway started on port 8080")
    server.serve_forever()
except OSError as e:
    sys.stderr.write(f"[CRITICAL ERROR] Failed to bind to port 8080: {e}\n")
    sys.exit(1)
