#!/usr/bin/env sh
# termifun installer
# Quick usage: curl -fsSL https://raw.githubusercontent.com/P1ngu-Dev/termifun/main/install.sh | sh
# With custom directory: FUN_INSTALL_DIR=~/.local/bin ./install.sh
# Uninstall: ./install.sh uninstall

set -e

VERSION="0.1.0"
REPO="https://raw.githubusercontent.com/tunombre/termifun/main"
BIN_NAME="termifun"
BIN_DIR="${FUN_INSTALL_DIR:-/usr/local/bin}"
COMP_BASH="/etc/bash_completion.d"
COMP_ZSH="/usr/local/share/zsh/site-functions"
COMP_FISH="${HOME}/.config/fish/completions"

# ─── POSIX Colors ───
_c() { printf '\033[%sm%s\033[0m' "$1" "$2"; }
grn() { _c "32" "$1"; }
yel() { _c "33" "$1"; }
red() { _c "31" "$1"; }
cyn() { _c "36" "$1"; }
bld() { _c "1" "$1"; }
dim() { _c "2" "$1"; }

# ─── Check downloader ───
if command -v curl >/dev/null 2>&1; then
  DL="curl -fsSL"
elif command -v wget >/dev/null 2>&1; then
  DL="wget -qO-"
else
  printf '%s\n' "$(red 'Error: curl or wget is required.')"
  exit 1
fi

# ─── Write file (with or without sudo) ───
_write() {
  local url="$1" dest="$2" exec="$3"
  local dir
  dir=$(dirname "$dest")

  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" 2>/dev/null || sudo mkdir -p "$dir"
  fi

  if [ -w "$dir" ]; then
    $DL "$url" >"$dest"
    [ "$exec" = "1" ] && chmod +x "$dest"
  else
    $DL "$url" | sudo tee "$dest" >/dev/null
    [ "$exec" = "1" ] && sudo chmod +x "$dest"
  fi
}

# ─── Install ───
_install() {
  printf '\n%s\n\n' "$(bld "⚡ Installing termifun v${VERSION}...")"

  # # Main binary
  printf '  %-30s' "Binary in ${BIN_DIR}/${BIN_NAME}..."
  _write "${REPO}/bin/${BIN_NAME}" "${BIN_DIR}/${BIN_NAME}" "1"
  printf '%s\n' "$(grn 'OK')"

  # # Bash completion
  if command -v bash >/dev/null 2>&1 && [ -d "$COMP_BASH" ]; then
    printf '  %-30s' "Completion bash..."
    _write "${REPO}/completions/${BIN_NAME}.bash" "${COMP_BASH}/${BIN_NAME}" "0"
    printf '%s\n' "$(grn 'OK')"
  fi

  # # Zsh completion
  if command -v zsh >/dev/null 2>&1; then
    printf '  %-30s' "Completion zsh..."
    _write "${REPO}/completions/${BIN_NAME}.zsh" "${COMP_ZSH}/_${BIN_NAME}" "0"
    printf '%s\n' "$(grn 'OK')"
  fi

  # # Fish completion
  if command -v fish >/dev/null 2>&1; then
    printf '  %-30s' "Completion fish..."
    mkdir -p "$COMP_FISH"
    _write "${REPO}/completions/${BIN_NAME}.fish" "${COMP_FISH}/${BIN_NAME}.fish" "0"
    printf '%s\n' "$(grn 'OK')"
  fi

  # Check fzf
  if ! command -v fzf >/dev/null 2>&1; then
    printf '\n  %s\n' "$(yel 'Note: fzf is not installed.')"
    printf '  %s\n' "$(dim 'termifun works without it, but with fzf you will have interactive selection.')"
    printf '  %s\n' "$(dim 'Install fzf with your package manager: dnf/apt/pacman/brew install fzf')"
  fi

  printf '\n  %s\n' "$(grn "✓ termifun installed successfully.")"
  printf '  %s\n\n' "$(dim "Run 'termifun' to start.")"
}

# ─── Uninstall ───
_uninstall() {
  printf '\n%s\n' "$(bld 'Uninstalling termifun...')"

  for f in \
    "${BIN_DIR}/${BIN_NAME}" \
    "${COMP_BASH}/${BIN_NAME}" \
    "${COMP_ZSH}/_${BIN_NAME}" \
    "${COMP_FISH}/${BIN_NAME}.fish"; do
    if [ -f "$f" ]; then
      printf '  Removing %s... ' "$f"
      rm -f "$f" 2>/dev/null || sudo rm -f "$f"
      printf '%s\n' "$(grn 'OK')"
    fi
  done

  printf '\n  %s\n\n' "$(grn '✓ termifun uninstalled.')"
}

# ─── Main ───
case "${1:-install}" in
install | "") _install ;;
uninstall | -u) _uninstall ;;
*)
  printf 'Usage: install.sh [install|uninstall]\n'
  exit 1
  ;;
esac
