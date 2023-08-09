from http.server import HTTPServer, SimpleHTTPRequestHandler

def run_server():
    server_address = ('', 5000)
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    httpd.serve_forever()

if __name__ == "__main__":
    run_server()
