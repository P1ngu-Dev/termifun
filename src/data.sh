# ─────────────────────────────────────────────────────────────
# DATA — Version and tool definitions
# Edit this file to add, remove, or update tools.
#
# FUN_TOOLS format:
#   "binary|description|command_to_run|pkg:mgr,..."
#
# ONLINE_TOOLS format:
#   "name|description|command|required_bin|pkg:mgr,..."
#   • name         — display label (no spaces, used as ID)
#   • required_bin — the binary that must exist to run the command
# ─────────────────────────────────────────────────────────────

VERSION="0.1.0"

# ── Local / installable tools ─────────────────────────────────
FUN_TOOLS=(
  "nyancat|Animated Nyan cat in the terminal|nyancat|dnf:nyancat,apt:nyancat,pacman:nyancat,brew:nyancat"
  "cmatrix|Matrix effect in the terminal|cmatrix|dnf:cmatrix,apt:cmatrix,pacman:cmatrix,brew:cmatrix"
  "cbonsai|Bonsai tree that grows on its own|cbonsai -l|dnf:cbonsai,apt:cbonsai,pacman:cbonsai,brew:cbonsai"
  "lolcat|Colorize output in rainbow|echo 'Hello from termifun' | lolcat|dnf:lolcat,apt:lolcat,pacman:lolcat,brew:lolcat"
  "cowsay|A talking cow|cowsay 'Moo!'|dnf:cowsay,apt:cowsay,pacman:cowsay,brew:cowsay"
  "ponysay|Like cowsay but with ponies|ponysay 'Yay!'|dnf:ponysay,apt:ponysay,pacman:ponysay-git,brew:ponysay"
  "fortune|Random quote from the oracle|fortune|dnf:fortune-mod,apt:fortune-mod,pacman:fortune-mod,brew:fortune"
  "figlet|Large text ASCII art|figlet 'termifun'|dnf:figlet,apt:figlet,pacman:figlet,brew:figlet"
  "toilet|figlet with colors and styles|toilet -f future --gay 'termifun'|dnf:toilet,apt:toilet,pacman:toilet,brew:toilet"
  "sl|Train when you type ls wrong|sl|dnf:sl,apt:sl,pacman:sl,brew:sl"
  "asciiquarium|Animated ASCII aquarium|asciiquarium|dnf:asciiquarium,apt:asciiquarium,pacman:asciiquarium,brew:asciiquarium"
  "aafire|Animated ASCII fire|aafire -driver stdout|dnf:aalib,apt:aalib-bin,pacman:aalib,brew:aalib"
  "cacafire|Colorful fire with libcaca|cacafire|dnf:libcaca,apt:caca-utils,pacman:libcaca,brew:libcaca"
  "pipes.sh|Animated pipes in the terminal|pipes.sh|dnf:pipes-sh,apt:pipes-sh,pacman:pipes.sh,brew:pipes-sh"
  "unimatrix|Matrix with Unicode characters|unimatrix -n -s 96|dnf:unimatrix,apt:unimatrix,pacman:unimatrix-git,brew:unimatrix"
  "genact|Generate fake hacker activity|genact|dnf:genact,apt:genact,pacman:genact,brew:genact"
  "hollywood|Hacker terminal to the max|hollywood|dnf:hollywood,apt:hollywood,pacman:hollywood,brew:hollywood"
  "tty-clock|Large clock in the terminal|tty-clock -c -C 6 -s|dnf:tty-clock,apt:tty-clock,pacman:tty-clock,brew:tty-clock"
  "bastet|Tetris that hates you|bastet|dnf:bastet,apt:bastet,pacman:bastet,brew:bastet"
  "ninvaders|Space Invaders in terminal|ninvaders|dnf:ninvaders,apt:ninvaders,pacman:ninvaders,brew:ninvaders"
  "moon-buggy|CLI arcade lunar buggy|moon-buggy|dnf:moon-buggy,apt:moon-buggy,pacman:moon-buggy,brew:moon-buggy"
  "nethack|Classic 1987 roguelike|nethack|dnf:nethack,apt:nethack-console,pacman:nethack,brew:nethack"
  "nudoku|Sudoku in the terminal|nudoku|dnf:nudoku,apt:nudoku,pacman:nudoku,brew:nudoku"
  "2048-cli|The 2048 game in terminal|2048-cli|dnf:2048-cli,apt:2048,pacman:2048-cli,brew:2048"
  "termsaver|ASCII screensaver|termsaver|dnf:termsaver,apt:termsaver,pacman:termsaver,brew:termsaver"
  "rev|Reverse text line by line|echo 'termifun' | rev|dnf:util-linux,apt:util-linux,pacman:util-linux,brew:util-linux"
  "rain|ASCII rain in the terminal|rain|dnf:bsdgames,apt:bsdgames,pacman:bsdgames,brew:bsdgames"
  "banner|Large UNIX style banner|banner 'FUN'|dnf:util-linux,apt:sysvbanner,pacman:bsdgames,brew:bsdgames"
  "cava|Audio visualizer in the terminal|cava|dnf:cava,apt:cava,pacman:cava,brew:cava"
  "charasay|Modern cowsay with ANSI art (Rust)|chara say 'termifun'|dnf:-,apt:-,pacman:charasay,brew:-"
  "lavat|Lava lamp simulation in terminal|lavat|dnf:-,apt:-,pacman:lavat-git,brew:-"
  "terminal-parrot|Animated party parrot offline|terminal-parrot|dnf:-,apt:-,pacman:terminal-parrot,brew:-"
  "mapscii|ASCII world map in the terminal|mapscii|dnf:mapscii,apt:mapscii,pacman:mapscii,brew:mapscii"
  "snowmachine|Snow falling in the terminal|snowmachine|dnf:snowmachine,apt:snowmachine,pacman:snowmachine,brew:snowmachine"
  "neofetch|System info with ASCII logo|neofetch|dnf:neofetch,apt:neofetch,pacman:neofetch,brew:neofetch"
  "tmatrix|Matrix text effect (C rewrite)|tmatrix|dnf:tmatrix,apt:tmatrix,pacman:tmatrix,brew:tmatrix"
  "oneko|Animated cat following your cursor|oneko|dnf:oneko,apt:oneko,pacman:oneko,brew:oneko"
  "fastfetch|System info tool (neofetch successor)|fastfetch|dnf:fastfetch,apt:fastfetch,pacman:fastfetch,brew:fastfetch"
  "ani-cli|Watch anime in the terminal|ani-cli|dnf:ani-cli,apt:ani-cli,pacman:ani-cli,brew:ani-cli"
  "no-more-secrets|Sneakers movie decryption effect|nms|dnf:no-more-secrets,apt:no-more-secrets,pacman:no-more-secrets,brew:no-more-secrets"
)

# ── Online tools ──────────────────────────────────────────────
# Format: "name|description|command|required_bin|pkg:mgr,..."
ONLINE_TOOLS=(
  # ── curl-based ───────────────────────────────────────────────
  "parrot|Party parrot animated|curl parrot.live|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "wttr|Weather forecast in the terminal|curl wttr.in|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "nyan-online|Nyan Cat animation|curl ascii.live/nyan|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "donut|Spinning donut animation|curl ascii.live/donut|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "rick|Rickroll in ASCII art|curl ascii.live/rick|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "forrest|Run Forrest run!|curl ascii.live/forrest|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "batman|Batman animation|curl ascii.live/batman|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "dvd|Bouncing DVD logo|curl ascii.live/dvd|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "coin|Spinning coin animation|curl ascii.live/coin|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "knot|Animated ASCII knot|curl ascii.live/knot|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "spiderman|Spider-Man swinging|curl ascii.live/spidyswing|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  "playstation|PlayStation intro sequence|curl ascii.live/playstation|curl|dnf:curl,apt:curl,pacman:curl,brew:curl"
  # ── telnet-based ─────────────────────────────────────────────
  "star-wars|Star Wars Episode IV in ASCII|telnet towel.blinkenlights.nl|telnet|dnf:telnet,apt:telnet,pacman:inetutils,brew:telnet"
)
