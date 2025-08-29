#!/bin/bash

# Emayer Cutter - Flutter Web Build and Run Script for Linux x86_64
# Bu script Flutter web uygulamasını build eder ve local olarak çalıştırır

set -e  # Hata durumunda scripti durdur

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log fonksiyonları
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

 

 

# Web desteği kontrolü
check_web_support() {
    log_info "Web desteği kontrolü yapılıyor..."
    
    if ! flutter config --list | grep -q "enable-web: true"; then
        log_info "Web desteği etkinleştiriliyor..."
        flutter config --enable-web
    fi
    
    log_success "Web desteği etkin"
}

# Bağımlılıkları yükle
install_dependencies() {
    log_info "Bağımlılıklar yükleniyor..."
    
    if [ -f "pubspec.lock" ]; then
        log_info "Mevcut bağımlılıklar güncelleniyor..."
        flutter pub get
    else
        log_info "Yeni bağımlılıklar yükleniyor..."
        flutter pub get
    fi
    
    log_success "Bağımlılıklar yüklendi"
}

# Web build al
build_web() {
    log_info "Web build alınıyor..."
    
    # Build klasörünü temizle
    if [ -d "build/web" ]; then
        log_info "Eski build klasörü temizleniyor..."
        rm -rf build/web
    fi
    
    # Release build al
    log_info "Release build alınıyor (flutter build web --release)..."
    flutter build web --release
    
    if [ ! -d "build/web" ]; then
        log_error "Web build başarısız! build/web klasörü oluşturulamadı."
        exit 1
    fi
    
    log_success "Web build başarıyla tamamlandı"
}

# Local web server başlat
start_local_server() {
    log_info "Local web server başlatılıyor..."

    # Port kontrolü
    PORT=8080
    while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
        log_warning "Port $PORT kullanımda, $((PORT+1)) deneniyor..."
        PORT=$((PORT+1))
        if [ $PORT -gt 8090 ]; then
            log_error "Uygun port bulunamadı!"
            exit 1
        fi
    done

    log_info "Web uygulaması http://localhost:$PORT adresinde başlatılıyor..."
    log_info "Durdurmak için Ctrl+C tuşlarına basın"

    cd build/web

    # Python3 ile SVG desteği olan HTTP server başlat (tercih edilen)
    if command -v python3 &> /dev/null; then
        log_info "Python3 ile SVG desteği olan HTTP server başlatılıyor..."
        python3 - <<EOF
import http.server
import socketserver
import mimetypes
import os

PORT = $PORT
WEB_DIR = os.getcwd()

class SVGFriendlyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # SVG dosyaları için MIME type'ını ayarla
        if self.path.endswith('.svg'):
            self.send_header('Content-type', 'image/svg+xml')
        elif self.path.endswith('.woff2'):
            self.send_header('Content-type', 'font/woff2')
        elif self.path.endswith('.woff'):
            self.send_header('Content-type', 'font/woff')
        elif self.path.endswith('.ttf'):
            self.send_header('Content-type', 'font/ttf')
        # CORS header'ı ekle
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def log_message(self, format, *args):
        # Log mesajlarını bastır (sessiz mod)
        pass

with socketserver.TCPServer(('', PORT), SVGFriendlyHTTPRequestHandler) as httpd:
    print("SVG desteği ile HTTP server http://localhost:$PORT adresinde çalışıyor...")
    print("Durdurmak için Ctrl+C tuşlarına basın")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer durduruluyor...")
        httpd.shutdown()
EOF
        return
    fi

    # Node.js ile http-server başlat (SVG desteği ile)
    if command -v npx &> /dev/null; then
        log_info "Node.js http-server ile SVG desteği olan server başlatılıyor..."
        npx http-server -p $PORT --cors -s -c-1 2>/dev/null || {
            log_warning "npx http-server başarısız, alternatif deneniyor..."
        }
        return
    fi

    # Python2/3 ile basit HTTP server başlat (fallback)
    if command -v python &> /dev/null; then
        log_info "Python ile temel HTTP server başlatılıyor..."
        python -m SimpleHTTPServer $PORT 2>/dev/null || python -m http.server $PORT
        return
    fi

    # PHP ile HTTP server başlat (fallback)
    if command -v php &> /dev/null; then
        log_info "PHP ile HTTP server başlatılıyor..."
        php -S localhost:$PORT
        return
    fi

    log_error "Hiçbir HTTP server bulunamadı!"
    log_info "Lütfen aşağıdakilerden birini yükleyin:"
    log_info "- Python3: sudo apt install python3 (önerilen)"
    log_info "- Node.js: sudo apt install nodejs npm"
    log_info "- PHP: sudo apt install php"
    log_info ""
    log_info "Veya manuel olarak build/web klasörünü bir web server ile çalıştırın."
    exit 1
}

# Ana fonksiyon
main() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Emayer Cutter Web Builder${NC}"
    echo -e "${BLUE}  Linux x86_64 Edition${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
    
    # Çalışma dizinini kontrol et
    if [ ! -f "pubspec.yaml" ]; then
        log_error "pubspec.yaml bulunamadı! Lütfen Flutter proje dizininde çalıştırın."
        exit 1
    fi
    
    # Web desteği kontrolü
    check_web_support
    
    # Bağımlılıkları yükle
    install_dependencies
    
    # Web build al
    build_web
    
    # Local server başlat
    start_local_server
}

# Script çalıştır
main "$@"
