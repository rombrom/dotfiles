# Setup fzf
if [[ ! "$PATH" == */$HOMEBREW_PREFIX/opt/fzf/bin* ]]; then
  export PATH="$PATH:$HOMEBREW_PREFIX/opt/fzf/bin"
fi

# Make fzf use ripgrep by default
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="\
  --color='16,bg+:-1,fg+:4,gutter:-1,hl:3,hl+:3,pointer:4,prompt:6' \
  --height 40% \
  --layout=reverse \
  --preview='bat {}' \
  --scrollbar='█'
  --tiebreak=length,end \
"

export FZF_CTRL_T_COMMAND="fd"

# Auto-completion
if [[ $- == *i* ]] then;
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
