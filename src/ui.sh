# ─────────────────────────────────────────
# UI — Interactive menus and display functions
# ─────────────────────────────────────────

# ── FZF LAUNCHER — Installed tools ──────
_fzf_launch() {
  local count="${#INSTALLED[@]}"
  if [ "$count" -eq 0 ]; then
    printf '\n%sNo tools installed!%s \nSwitching to browse mode...\n' "$YELLOW" "$RESET"
    sleep 1.5
    NEXT_ACTION="browse"
    return 0
  fi

  local header="${count} installed tools · Enter: run · Ctrl-b: browse · Ctrl-o: online · Ctrl-h: help · Esc: exit"

  local output key selection
  output=$(printf '%s\n' "${INSTALLED[@]}" | \
    fzf \
      --expect=ctrl-b,ctrl-o,ctrl-h \
      --prompt="⚡ termifun > " \
      --header="$header" \
      --header-first \
      --height=70% \
      --border=rounded \
      --color='header:cyan,prompt:yellow,pointer:magenta,hl:green' \
      --no-multi \
      --exact
  ) || return 0

  [ -z "$output" ] && return 0

  key=$(head -n1 <<< "$output")
  selection=$(tail -n+2 <<< "$output")

  if [ "$key" = "ctrl-b" ]; then
    NEXT_ACTION="browse"
    return
  elif [ "$key" = "ctrl-o" ]; then
    NEXT_ACTION="online"
    return
  elif [ "$key" = "ctrl-h" ]; then
    NEXT_ACTION="help_launch"
    return
  fi

  [ -z "$selection" ] && return 0

  local i=0
  for line in "${INSTALLED[@]}"; do
    if [ "$line" = "$selection" ]; then
      local cmd="${INSTALLED_CMDS[$i]}"
      printf '\n%s▶ Running:%s %s\n\n' "$BOLD" "$RESET" "$cmd"
      sleep 0.3
      eval "$cmd"
      return
    fi
    i=$((i + 1))
  done
}

# ── FZF BROWSER — Not installed tools ───
_fzf_browse() {
  local count="${#NOT_INSTALLED[@]}"
  if [ "$count" -eq 0 ]; then
    printf '\n%sYou have all tools installed!%s\n\n' "$GREEN" "$RESET"
    sleep 2
    NEXT_ACTION="launch"
    return 0
  fi

  local header="${count} tools available to install · Enter: install · Ctrl-l: launch · Ctrl-h: help · Esc: exit"

  local output key selection
  output=$(printf '%s\n' "${NOT_INSTALLED[@]}" | \
    fzf \
      --expect=ctrl-l,ctrl-h \
      --prompt="📦 install > " \
      --header="$header" \
      --header-first \
      --height=70% \
      --border=rounded \
      --color='header:yellow,prompt:green,pointer:cyan,hl:yellow' \
      --no-multi \
      --exact
  ) || return 0

  [ -z "$output" ] && return 0

  key=$(head -n1 <<< "$output")
  selection=$(tail -n+2 <<< "$output")

  if [ "$key" = "ctrl-l" ]; then
    NEXT_ACTION="launch"
    return
  elif [ "$key" = "ctrl-h" ]; then
    NEXT_ACTION="help_browse"
    return
  fi

  [ -z "$selection" ] && return 0

  local i=0
  for line in "${NOT_INSTALLED[@]}"; do
    if [ "$line" = "$selection" ]; then
      local pkg="${NOT_INSTALLED_PKGS[$i]}"
      local bin
      bin=$(printf '%s' "$line" | awk '{print $1}')
      if [ -z "$pkg" ] || [ "$pkg" = "-" ]; then
        printf '\n%sPackage not found or cannot be installed automatically for "%s" via %s.%s\n' "$RED" "$bin" "$PKG_MANAGER" "$RESET"
        printf '\n%sPress Enter to return to menu...%s' "$DIM" "$RESET"
        read -r
        NEXT_ACTION="browse"
        return
      fi
      printf 'Install %s%s%s via %s%s%s? [y/N] ' "$GREEN" "$pkg" "$RESET" "$CYAN" "$PKG_MANAGER" "$RESET"
      local answer
      read -r answer
      case "$answer" in
        [yY]|[yY][eE][sS])
          printf '\n%s▶ Installing:%s %s%s%s  via %s%s%s\n\n' \
            "$BOLD" "$RESET" "$GREEN" "$pkg" "$RESET" "$CYAN" "$PKG_MANAGER" "$RESET"
          eval "$PKG_INSTALL $pkg"
          ;;
        *)
          printf '\n%sSkipping. Press Enter to return...%s' "$DIM" "$RESET"
          read -r
          NEXT_ACTION="browse"
          return
          ;;
      esac

      hash -r 2>/dev/null || true
      _scan_tools

      printf '\n%sPress Enter to return to menu...%s' "$DIM" "$RESET"
      read -r
      NEXT_ACTION="browse"
      return
    fi
    i=$((i + 1))
  done
}

# ── FZF ONLINE — Online tool launcher ───
_fzf_online() {
  local count="${#ONLINE_ITEMS[@]}"
  local header="${count} online tools · Enter: run · Ctrl-l: launch · Ctrl-h: help · Esc: exit"

  local output key selection
  output=$(printf '%s\n' "${ONLINE_ITEMS[@]}" | \
    fzf \
      --expect=ctrl-l,ctrl-h \
      --prompt="🌐 online > " \
      --header="$header" \
      --header-first \
      --height=70% \
      --border=rounded \
      --color='header:blue,prompt:cyan,pointer:green,hl:blue' \
      --no-multi \
      --exact
  ) || return 0

  [ -z "$output" ] && return 0

  key=$(head -n1 <<< "$output")
  selection=$(tail -n+2 <<< "$output")

  if [ "$key" = "ctrl-l" ]; then
    NEXT_ACTION="launch"
    return
  elif [ "$key" = "ctrl-h" ]; then
    NEXT_ACTION="help_online"
    return
  fi

  [ -z "$selection" ] && return 0

  local i=0
  for line in "${ONLINE_ITEMS[@]}"; do
    if [ "$line" = "$selection" ]; then
      local cmd="${ONLINE_CMDS[$i]}"
      local req="${ONLINE_REQBINS[$i]}"
      local pkg="${ONLINE_PKGS[$i]}"

      # Check if required binary is available
      if ! command -v "$req" >/dev/null 2>&1; then
        printf '\n%s⚠ Required tool not found:%s %s%s%s\n' "$YELLOW" "$RESET" "$BOLD" "$req" "$RESET"
        if [ -z "$pkg" ] || [ "$pkg" = "-" ]; then
          printf '%sCannot install automatically for %s. Please install %s manually.%s\n\n' \
            "$RED" "$PKG_MANAGER" "$req" "$RESET"
          printf '%sPress Enter to return to menu...%s' "$DIM" "$RESET"
          read -r
          NEXT_ACTION="online"
          return
        fi
        printf 'Install %s%s%s via %s%s%s? [y/N] ' "$GREEN" "$pkg" "$RESET" "$CYAN" "$PKG_MANAGER" "$RESET"
        local answer
        read -r answer
        case "$answer" in
          [yY]|[yY][eE][sS])
            printf '\n%s▶ Installing:%s %s%s%s  via %s%s%s\n\n' \
              "$BOLD" "$RESET" "$GREEN" "$pkg" "$RESET" "$CYAN" "$PKG_MANAGER" "$RESET"
            eval "$PKG_INSTALL $pkg"
            printf '\n%sPress Enter to continue...%s' "$DIM" "$RESET"
            read -r
            ;;
          *)
            printf '\n%sSkipping. Press Enter to return...%s' "$DIM" "$RESET"
            read -r
            NEXT_ACTION="online"
            return
            ;;
        esac
        # Re-check after attempted install
        hash -r 2>/dev/null || true
        if ! command -v "$req" >/dev/null 2>&1; then
          printf '\n%sInstallation may have failed. Please check manually.%s\n' "$RED" "$RESET"
          printf '%sPress Enter to return...%s' "$DIM" "$RESET"
          read -r
          NEXT_ACTION="online"
          return
        fi
      fi

      printf '\n%s▶ Running:%s %s\n\n' "$BOLD" "$RESET" "$cmd"
      sleep 0.3
      eval "$cmd"
      printf '\n%sPress Enter to return to menu...%s' "$DIM" "$RESET"
      read -r
      NEXT_ACTION="online"
      return
    fi
    i=$((i + 1))
  done
}

# ── HELP SCREEN ──────────────────────────
_show_fzf_help() {
  local return_to="$1"

  clear
  printf '\n%s%s⚡ TERMIFUN HELP & KEYBINDS%s\n' "$BOLD" "$CYAN" "$RESET"
  printf '──────────────────────────────────────────────\n\n'

  printf '%sGENERAL NAVIGATION%s\n' "$BOLD" "$RESET"
  printf '  %sUp/Down%s      Move selection up or down\n' "$GREEN" "$RESET"
  printf '  %sEnter%s        Run (Launch/Online) or Install (Browse)\n' "$GREEN" "$RESET"
  printf '  %sEscape%s       Exit the menu\n\n' "$GREEN" "$RESET"

  printf '%sQUICK SWITCHING%s\n' "$BOLD" "$RESET"
  printf '  %sCtrl-b%s       Switch to Browse mode (install new tools)\n' "$YELLOW" "$RESET"
  printf '  %sCtrl-l%s       Switch to Launch mode (run installed tools)\n' "$YELLOW" "$RESET"
  printf '  %sCtrl-o%s       Switch to Online mode (run online tools)\n\n' "$YELLOW" "$RESET"

  printf '%sFEATURES%s\n' "$BOLD" "$RESET"
  printf '  • Real-time fuzzy search by name or description.\n'
  printf '  • Auto-detection of package manager (apt, dnf, pacman, brew).\n'
  printf '  • Online tools: auto-detect and offer to install required binaries.\n'
  printf '  • Deduplication of tool entries.\n\n'

  printf '%sPress Enter to return...%s' "$DIM" "$RESET"
  read -r

  NEXT_ACTION="$return_to"
}

# ── SIMPLE LIST (no fzf fallback) ────────
_list_simple() {
  printf '\n%s%s⚡ INSTALLED (%d)%s\n' "$BOLD" "$CYAN" "${#INSTALLED[@]}" "$RESET"
  printf '  %s\n' "──────────────────────────────────────────────"
  if [ "${#INSTALLED[@]}" -eq 0 ]; then
    printf '  %sNone. Run termifun --browse to see what to install.%s\n' "$DIM" "$RESET"
  else
    local i=1
    for line in "${INSTALLED[@]}"; do
      printf '  %s%2d.%s %s\n' "$GREEN" "$i" "$RESET" "$line"
      i=$((i + 1))
    done
  fi

  printf '\n%s%s📦 NOT INSTALLED (%d)%s\n' "$BOLD" "$YELLOW" "${#NOT_INSTALLED[@]}" "$RESET"
  printf '  %s\n' "──────────────────────────────────────────────"
  local i=1
  for j in "${!NOT_INSTALLED[@]}"; do
    local pkg="${NOT_INSTALLED_PKGS[$j]}"
    [ -z "$pkg" ] && pkg="(no package for $PKG_MANAGER)"
    printf '  %s%2d. %-40s  %s install %s%s\n' \
      "$DIM" "$i" "${NOT_INSTALLED[$j]}" "$PKG_MANAGER" "$pkg" "$RESET"
    i=$((i + 1))
  done

  printf '\n  %sInstall fzf for interactive mode: %s install fzf%s\n\n' \
    "$DIM" "$PKG_MANAGER" "$RESET"
}

# ── HELP TEXT ────────────────────────────
_show_help() {
  printf '
%stermifun%s v%s — CLI Fun Tools Launcher

%sUSAGE%s
  termifun              Interactive launcher (requires fzf)
  termifun --list       List all installed and not installed tools
  termifun --browse     Browse and install not installed tools (requires fzf)
  termifun --version    Show version
  termifun --help       Show this help

%sSUPPORTED SHELLS%s
  bash, zsh, fish (and any POSIX sh)

%sDETECTED MANAGER%s
  %s%s%s

%sREPOSITORY%s
  https://github.com/P1ngu-Dev/termifun

' "$BOLD" "$RESET" "$VERSION" \
    "$BOLD" "$RESET" \
    "$BOLD" "$RESET" \
    "$BOLD" "$RESET" "$CYAN" "$PKG_MANAGER" "$RESET" \
    "$BOLD" "$RESET"
}
