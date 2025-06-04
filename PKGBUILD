pkgname=clipboard-history
pkgver=0.2
pkgrel=1
pkgdesc="Clipboard history manager built in Python (Gestor de historial del portapapeles en Python)"
arch=('any')
url="https://github.com/Leonardo-Antonio/clipboard-history"
license=('MIT')
depends=('python' 'xclip' 'xsel' 'wl-clipboard' 'gtk3' 'python-gobject' 'python-pyperclip' 'python-pyautogui')
makedepends=('python-pip')

source=("https://github.com/Leonardo-Antonio/clipboard-history/releases/download/v$pkgver/clipboard-history.tar.gz")
sha256sums=('SKIP')

build() {
  cd "$srcdir/$pkgname-$pkgver"
  # No es necesario construir nada
}

package() {
  cd "$srcdir/$pkgname-$pkgver"

  install -d "$pkgdir/usr/share/$pkgname"
  install -Dm755 clipboard_history.sh "$pkgdir/usr/share/$pkgname/clipboard_history.sh"
  install -Dm644 main.py "$pkgdir/usr/share/$pkgname/main.py"
  install -Dm644 requirements.txt "$pkgdir/usr/share/$pkgname/requirements.txt"

  install -Dm644 assets/icon.svg "$pkgdir/usr/share/icons/hicolor/scalable/apps/$pkgname.svg"

  install -d "$pkgdir/usr/share/$pkgname/assets"
  install -Dm644 assets/icon.svg "$pkgdir/usr/share/$pkgname/assets/icon.svg"

  install -d "$pkgdir/usr/share/$pkgname/gui"
  install -Dm644 gui/button_icon.py "$pkgdir/usr/share/$pkgname/gui/button_icon.py"
  install -Dm644 gui/read.py "$pkgdir/usr/share/$pkgname/gui/read.py"

  # Instalar archivo .desktop
  install -Dm644 clipboard-history.desktop "$pkgdir/usr/share/applications/$pkgname.desktop"

  # Crear lanzador
  install -Dm755 /dev/stdin "$pkgdir/usr/bin/$pkgname" << 'EOF'
#!/bin/bash
export AUTO_EXEC_PASTE=1
python /usr/share/clipboard-history/main.py &
/usr/share/clipboard-history/clipboard_history.sh
EOF
}
