pkgname=clipboard-history
pkgver=0.3
pkgrel=1
pkgdesc="Aplicación en Python para guardar y visualizar el historial del portapapeles"
arch=('any')
url="https://github.com/tuusuario/clipboard-history"
license=('MIT')

depends=('python' 'xclip' 'xsel' 'wl-clipboard' 'gtk3' 'python-gobject')  # libs del sistema
makedepends=('python-pip' 'python-virtualenv')  # para crear venv e instalar deps

source=("https://github.com/Leonardo-Antonio/clipboard-history/releases/download/v$pkgver/clipboard-history.tar.gz")
sha256sums=('SKIP')

build() {
  cd "$srcdir"
  python -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
  deactivate
}

package() {
  cd "$srcdir"

  install -Dm755 "launch.bash" "$pkgdir/usr/bin/clipboard-history"
  install -Dm755 "clipboard_history.sh" "$pkgdir/usr/share/clipboard-history/clipboard_history.sh"
  install -Dm644 "main.py" "$pkgdir/usr/share/clipboard-history/main.py"
  install -Dm644 "requirements.txt" "$pkgdir/usr/share/clipboard-history/requirements.txt"

  install -d "$pkgdir/usr/share/clipboard-history/assets"
  install -Dm644 "assets/icon.svg" "$pkgdir/usr/share/clipboard-history/assets/icon.svg"

  install -d "$pkgdir/usr/share/clipboard-history/gui"
  install -Dm644 "gui/button_icon.py" "$pkgdir/usr/share/clipboard-history/gui/button_icon.py"
  install -Dm644 "gui/read.py" "$pkgdir/usr/share/clipboard-history/gui/read.py"

  # Copiar el entorno virtual completo
  cp -r venv "$pkgdir/usr/share/clipboard-history/venv"

  # Crear script lanzador que activa el entorno virtual
  cat > "$pkgdir/usr/bin/clipboard-history" << EOF
#!/bin/bash
export AUTO_EXEC_PASTE=1
source /usr/share/clipboard-history/venv/bin/activate
python /usr/share/clipboard-history/main.py &
/usr/share/clipboard-history/clipboard_history.sh
EOF

  chmod +x "$pkgdir/usr/bin/clipboard-history"
}
