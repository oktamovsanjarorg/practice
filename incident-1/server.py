from http.server import HTTPServer, BaseHTTPRequestHandler
import json

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({
            "status": "online",
            "service": "paypulse-core-api",
            "message": "To'lov tizimi muvaffaqiyatli ishlamoqda!"
        }).encode())

if __name__ == '__main__':
    # Dasturchi loopback interfeysiga bog'lab qo'ygan
    server = HTTPServer(('0.0.0.0', 5000), Handler)
    print("Core API server started on 127.0.0.1:5000")
    server.serve_forever()
