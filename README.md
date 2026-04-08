cat << 'EOF' > README.md
# termifun

> Interactive launcher for fun CLI tools. Discover, launch, and install entertaining terminal utilities from a single command.

***

## Installation

### Quick (recommended)
```sh
curl -fsSL [https://raw.githubusercontent.com/tunombre/termifun/main/install.sh](https://raw.githubusercontent.com/tunombre/termifun/main/install.sh) | sh
```

### Using wget
```sh
wget -qO- [https://raw.githubusercontent.com/tunombre/termifun/main/install.sh](https://raw.githubusercontent.com/tunombre/termifun/main/install.sh) | sh
```

### Custom directory
```sh
FUN_INSTALL_DIR=~/.local/bin ./install.sh
```

### Manual
```sh
git clone [https://github.com/tunombre/termifun](https://github.com/tunombre/termifun)
cd termifun && ./install.sh
```

### Uninstall
```sh
./install.sh uninstall
```

***

## Usage

```
termifun            Interactive launcher with fzf
termifun --list     List installed and uninstalled tools
termifun --browse   Browse and install missing tools
termifun --version  Show version
termifun --help     Show help message
```

***

## Features

- **Automatic detection** of installed tools on your system
- **Interactive launcher** with `fzf` — search, select, and execute
- **Browse mode** — see what you are missing and install it without leaving the menu
- **Package manager detection** — dnf, pacman, apt, brew
- **Fallback** to a text-based list if fzf is not available
- **Compatible** with bash, zsh, fish, and any POSIX sh

***

## Supported Tools (~34)

| Tool | Description |
|---|---|
| `nyancat` | Animated Nyan Cat |
| `cmatrix` | Matrix falling code effect |
| `cbonsai` | Growing bonsai tree |
| `lolcat` | Rainbow-colored output |
| `cowsay` / `ponysay` | Talking animals |
| `figlet` / `toilet` | ASCII text art |
| `sl` | Steam locomotive when you mistype ls |
| `asciiquarium` | Animated ASCII aquarium |
| `nms` | Sneakers decryption effect |
| `pipes.sh` | Animated pipes |
| `unimatrix` | Matrix effect with Unicode |
| `hollywood` / `genact` | Hacker terminal |
| `tty-clock` | Terminal clock |
| `bastet` / `nethack` / `ninvaders` | ASCII games |
| `moon-buggy` / `2048-cli` / `nudoku` | More games |
| `pv` / `espeak` / `bb` | Miscellaneous |
| ...and more | |

***

## Dependencies

- `fzf` — optional but highly recommended (`dnf install fzf`)

***

## License

MIT © 2026
EOF
