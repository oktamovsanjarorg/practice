import sys
import time
from http.server import HTTPServer, BaseHTTPRequestHandler

class RogueHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(503)
        self.end_headers()
        self.wfile.write(b"503 Service Unavailable: Rogue process blocking port 8080\n")
    def log_message(self, format, *args):
        pass

try:
    server = HTTPServer(("0.0.0.0", 8080), RogueHandler)
    server.serve_forever()
except Exception as e:
    sys.exit(1)
