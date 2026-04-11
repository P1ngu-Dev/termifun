# termifun bash completion
# Install: source this file or copy it to /etc/bash_completion.d/termifun
_termifun_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opts="--help --version --list --browse"
  COMPREPLY=($(compgen -W "$opts" -- "$cur"))
}
complete -F _termifun_completions termifun
