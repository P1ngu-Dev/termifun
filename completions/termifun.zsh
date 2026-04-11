#compdef termifun
# termifun zsh completion
# Install: copy to a directory in $fpath (e.g.: /usr/local/share/zsh/site-functions/_termifun)
_termifun() {
  local -a opts
  opts=(
    '--help:Show help'
    '-h:Show help'
    '--version:Show version'
    '-v:Show version'
    '--list:List all installed and not installed tools'
    '-l:List all tools'
    '--browse:Browse and install not installed tools'
    '-b:Browse and install not installed tools'
  )
  _describe 'termifun options' opts
}
_termifun
