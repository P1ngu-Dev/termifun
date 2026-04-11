# ─────────────────────────────────────────────────────────────
# DATA — Version and tool definitions
# Edit this file to add, remove, or update tools.
# Format: "binary|description|command_to_run|pkg:mgr,pkg:mgr,..."
# ─────────────────────────────────────────────────────────────

VERSION="0.1.0"

FUN_TOOLS=(
  "nyancat|Animated Nyan cat in the terminal|nyancat|dnf:nyancat,apt:nyancat,pacman:nyancat,brew:nyancat"
  "cmatrix|Matrix effect in the terminal|cmatrix -ab|dnf:cmatrix,apt:cmatrix,pacman:cmatrix,brew:cmatrix"
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
  "nms|Sneakers decryption effect|echo 'termifun rocks!' | nms -a|dnf:no-more-secrets,apt:no-more-secrets,pacman:no-more-secrets,brew:no-more-secrets"
  "pipes.sh|Animated pipes in the terminal|pipes.sh|dnf:pipes-sh,apt:pipes-sh,pacman:pipes.sh,brew:pipes-sh"
  "unimatrix|Matrix with Unicode characters|unimatrix -n -s 96|dnf:unimatrix,apt:unimatrix,pacman:unimatrix-git,brew:unimatrix"
  "genact|Generate fake hacker activity|genact|dnf:genact,apt:genact,pacman:genact,brew:genact"
  "hollywood|Hacker terminal to the max|hollywood|dnf:hollywood,apt:hollywood,pacman:hollywood,brew:hollywood"
  "tty-clock|Large clock in the terminal|tty-clock -c -C 6 -s|dnf:tty-clock,apt:tty-clock,pacman:tty-clock,brew:tty-clock"
  "bb|ASCII art demo|bb|dnf:bb,apt:bb,pacman:bb,brew:bb"
  "bastet|Tetris that hates you|bastet|dnf:bastet,apt:bastet,pacman:bastet,brew:bastet"
  "ninvaders|Space Invaders in terminal|ninvaders|dnf:ninvaders,apt:ninvaders,pacman:ninvaders,brew:ninvaders"
  "moon-buggy|CLI arcade lunar buggy|moon-buggy|dnf:moon-buggy,apt:moon-buggy,pacman:moon-buggy,brew:moon-buggy"
  "nethack|Classic 1987 roguelike|nethack|dnf:nethack,apt:nethack-console,pacman:nethack,brew:nethack"
  "greed|ASCII game of greed|greed|dnf:greed,apt:greed,pacman:greed,brew:greed"
  "nudoku|Sudoku in the terminal|nudoku|dnf:nudoku,apt:nudoku,pacman:nudoku,brew:nudoku"
  "2048-cli|The 2048 game in terminal|2048-cli|dnf:2048-cli,apt:2048,pacman:2048-cli,brew:2048"
  "termsaver|ASCII screensaver|termsaver|dnf:termsaver,apt:termsaver,pacman:termsaver,brew:termsaver"
  "pv|Visual pipe progress|echo 'Loading...' | pv -qL 30|dnf:pv,apt:pv,pacman:pv,brew:pv"
  "espeak|Text to speech in terminal|espeak 'Hello from termifun'|dnf:espeak,apt:espeak,pacman:espeak,brew:espeak"
  "factor|Visual mathematical factorization|factor 1337|dnf:coreutils,apt:coreutils,pacman:coreutils,brew:coreutils"
  "rev|Reverse text line by line|echo 'termifun' | rev|dnf:util-linux,apt:util-linux,pacman:util-linux,brew:util-linux"
  "rain|ASCII rain in the terminal|rain|dnf:bsdgames,apt:bsdgames,pacman:bsdgames,brew:bsdgames"
  "banner|Large UNIX style banner|banner 'FUN'|dnf:util-linux,apt:sysvbanner,pacman:bsdgames,brew:bsdgames"
)
