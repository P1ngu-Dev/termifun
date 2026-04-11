# ─────────────────────────────────────────
# MAIN — UI event loop and argument parsing
# ─────────────────────────────────────────

NEXT_ACTION=""

_ui_loop() {
  NEXT_ACTION="$1"
  while [ -n "$NEXT_ACTION" ]; do
    local current_action="$NEXT_ACTION"
    NEXT_ACTION=""
    case "$current_action" in
      launch)       _fzf_launch ;;
      browse)       _fzf_browse ;;
      online)       _fzf_online ;;
      help_launch)  _show_fzf_help "launch" ;;
      help_browse)  _show_fzf_help "browse" ;;
      help_online)  _show_fzf_help "online" ;;
    esac
  done
}

main() {
  _setup_colors
  _detect_pkg_manager
  _scan_tools
  _scan_online_tools

  case "${1:-}" in
    --help|-h)
      _show_help
      ;;
    --version|-v)
      printf 'termifun v%s\n' "$VERSION"
      ;;
    --list|-l)
      _list_simple
      ;;
    --browse|-b)
      if command -v fzf >/dev/null 2>&1; then
        _ui_loop "browse"
      else
        # Fallback without fzf: list with installation commands
        printf '\n%s%s📦 NOT INSTALLED TOOLS%s\n' "$BOLD" "$YELLOW" "$RESET"
        printf '  %s\n' "──────────────────────────────────────────────"
        local i=0
        for line in "${NOT_INSTALLED[@]}"; do
          local pkg="${NOT_INSTALLED_PKGS[$i]}"
          [ -z "$pkg" ] && pkg="(no package for $PKG_MANAGER)"
          printf '  %s%-40s%s  %s%s install %s%s\n' \
            "$DIM" "$line" "$RESET" "$CYAN" "$PKG_MANAGER" "$pkg" "$RESET"
          i=$((i + 1))
        done
        printf '\n'
      fi
      ;;
    "")
      if [ "${#INSTALLED[@]}" -eq 0 ]; then
        if command -v fzf >/dev/null 2>&1; then
          printf '\n%sNo fun tools installed found.%s Launching browse mode...\n' "$YELLOW" "$RESET"
          sleep 1.5
          _ui_loop "browse"
          exit 0
        else
          printf '\n%sNo fun tools installed found.%s\n' "$YELLOW" "$RESET"
          printf 'Run %stermifun --browse%s to see what you can install.\n\n' "$CYAN" "$RESET"
          exit 0
        fi
      fi
      if command -v fzf >/dev/null 2>&1; then
        _ui_loop "launch"
      else
        _list_simple
      fi
      ;;
    *)
      printf '%sUnknown option: %s%s\n' "$RED" "$1" "$RESET"
      printf "Use 'termifun --help' to see options.\n"
      exit 1
      ;;
  esac
}

main "$@"
