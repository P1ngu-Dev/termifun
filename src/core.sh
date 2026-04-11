# ─────────────────────────────────────────
# CORE — Colors, package manager detection,
#         package name resolution, tool scan
# ─────────────────────────────────────────

_setup_colors() {
  if [ -t 1 ] && command -v tput >/dev/null 2>&1 && [ "$(tput colors 2>/dev/null)" -ge 8 ] 2>/dev/null; then
    BOLD=$(tput bold)
    DIM=$(tput dim 2>/dev/null || printf '')
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    CYAN=$(tput setaf 6)
    RESET=$(tput sgr0)
  else
    BOLD='' DIM='' RED='' GREEN='' YELLOW='' CYAN='' RESET=''
  fi
}

_detect_pkg_manager() {
  if command -v dnf >/dev/null 2>&1; then
    PKG_MANAGER="dnf"; PKG_INSTALL="sudo dnf install -y"
  elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"; PKG_INSTALL="sudo pacman -S --noconfirm"
  elif command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"; PKG_INSTALL="sudo apt install -y"
  elif command -v brew >/dev/null 2>&1; then
    PKG_MANAGER="brew"; PKG_INSTALL="brew install"
  else
    PKG_MANAGER="unknown"; PKG_INSTALL=""
  fi
}

_get_pkg_name() {
  local hint="$1" pkg=""
  local IFS=','
  for pair in $hint; do
    local mgr="${pair%%:*}"
    local name="${pair#*:}"
    if [ "$mgr" = "$PKG_MANAGER" ]; then
      pkg="$name"
      break
    fi
  done
  printf '%s' "$pkg"
}

_scan_tools() {
  INSTALLED=()
  INSTALLED_CMDS=()
  NOT_INSTALLED=()
  NOT_INSTALLED_CMDS=()
  NOT_INSTALLED_PKGS=()
  _seen_bins=()

  for entry in "${FUN_TOOLS[@]}"; do
    local bin desc cmd hint
    IFS='|' read -r bin desc cmd hint <<< "$entry"

    # Deduplicate binaries
    local already=0
    for seen in "${_seen_bins[@]}"; do
      [ "$seen" = "$bin" ] && already=1 && break
    done
    [ "$already" = "1" ] && continue
    _seen_bins+=("$bin")

    if command -v "$bin" >/dev/null 2>&1; then
      INSTALLED+=("$(printf '%-18s  %s' "$bin" "$desc")")
      INSTALLED_CMDS+=("$cmd")
    else
      local pkg
      pkg=$(_get_pkg_name "$hint")
      NOT_INSTALLED+=("$(printf '%-18s  %s' "$bin" "$desc")")
      NOT_INSTALLED_CMDS+=("$cmd")
      NOT_INSTALLED_PKGS+=("$pkg")
    fi
  done
}
