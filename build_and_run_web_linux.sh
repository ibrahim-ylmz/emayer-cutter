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
    
    # Opsiyonel: CanvasKit (Skia) ile derleme için bayrak
    CANVASKIT_FLAG=""
    if [[ " $* " == *" --canvaskit "* ]]; then
        log_info "CanvasKit etkin: FLUTTER_WEB_USE_SKIA=true"
        CANVASKIT_FLAG="--dart-define=FLUTTER_WEB_USE_SKIA=true"
    fi

    # Release build al (PWA cache kapalı, base-href kök)
    log_info "Release build alınıyor (flutter build web --release --base-href / --pwa-strategy=none $CANVASKIT_FLAG)..."
    flutter build web --release --base-href / --pwa-strategy=none $CANVASKIT_FLAG
    
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

    # Node.js 'serve' ile SPA fallback (tercih edilir)
    if command -v npx &> /dev/null; then
        if npx --yes serve --version >/dev/null 2>&1; then
            log_info "npx serve -s ile SPA fallback etkin."
            npx --yes serve -s -l $PORT .
            return
        fi
    fi

    # Python ile SPA fallback'li basit HTTP server
    if command -v python3 &> /dev/null; then
        log_info "Python3 ile SPA fallback'li HTTP server başlıyor..."
        python3 - <<'PY'
import http.server
import socketserver
import os

PORT = int(os.environ.get('PORT', '8080'))
WEB_DIR = os.getcwd()

class SPARequestHandler(http.server.SimpleHTTPRequestHandler):
    def translate_path(self, path):
        # Standart yolu çöz
        path = super().translate_path(path)
        return path

    def send_head(self):
        path = self.translate_path(self.path)
        # Dosya varsa normal servis et
        if os.path.exists(path) and os.path.isfile(path):
            return http.server.SimpleHTTPRequestHandler.send_head(self)
        # Yoksa index.html'e düş
        index_path = os.path.join(WEB_DIR, 'index.html')
        if os.path.exists(index_path):
            self.path = '/index.html'
            return http.server.SimpleHTTPRequestHandler.send_head(self)
        return http.server.SimpleHTTPRequestHandler.send_head(self)

with socketserver.TCPServer(('', PORT), SPARequestHandler) as httpd:
    print(f"Serving SPA at http://localhost:{PORT}")
    try:
        httpd.serve_forever()
    except BrokenPipeError:
        pass
PY
        return
    elif command -v python &> /dev/null; then
        log_info "Python2/3 ile SPA fallback denemesi..."
        python - <<'PY' 2>/dev/null || python - <<'PY'
import SimpleHTTPServer as server, SocketServer as socketserver, os
PORT=int(os.environ.get('PORT','8080'))
WEB_DIR=os.getcwd()
class SPA(server.SimpleHTTPRequestHandler):
    def send_head(self):
        path = self.translate_path(self.path)
        if os.path.exists(path) and os.path.isfile(path):
            return server.SimpleHTTPRequestHandler.send_head(self)
        index_path = os.path.join(WEB_DIR, 'index.html')
        if os.path.exists(index_path):
            self.path = '/index.html'
            return server.SimpleHTTPRequestHandler.send_head(self)
        return server.SimpleHTTPRequestHandler.send_head(self)
httpd=socketserver.TCPServer(('',PORT),SPA)
print('Serving SPA at http://localhost:%d' % PORT)
httpd.serve_forever()
PY
PY
        return
    fi

    # PHP ile basit HTTP server (SPA fallback sağlanamaz)
    if command -v php &> /dev/null; then
        log_info "PHP ile HTTP server başlıyor (SPA fallback yok)."
        php -S localhost:$PORT
        return
    fi

    log_error "Hiçbir uygun HTTP server bulunamadı!"
    log_info "Lütfen aşağıdakilerden birini yükleyin:"
    log_info "- Node.js: sudo apt install nodejs npm (önerilen: 'npx serve -s')"
    log_info "- Python3: sudo apt install python3"
    log_info "- PHP: sudo apt install php"
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
