# Clipboard History

## Dependencies
```bash
sudo pacman -S xclip xsel wl-clipboard 
```

## Install
```bash
mkdir -p .clipboard-history && cd .clipboard-history && \
wget https://github.com/Leonardo-Antonio/clipboard-history/releases/download/v0.5/clipboard-history.tar.gz && \
tar -xvf clipboard-history.tar.gz && \
makepkg -Csi
```

## Usage
```bash
clipboard-history &
```

or 

### zsh
```bash
clipboard-history & \
echo "clipboard-history &" >> ~/.zshrc
```

### bash
```bash
clipboard-history & \
echo "clipboard-history &" >> ~/.bashrc
```

## uninstall
```bash
sudo pacman -R clipboard-history
```