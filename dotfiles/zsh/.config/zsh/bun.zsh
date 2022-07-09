export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
