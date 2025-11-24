# Setup fzf
if [[ ! "$PATH" == */$HOMEBREW_PREFIX/opt/fzf/bin* ]]; then
  export PATH="$PATH:$HOMEBREW_PREFIX/opt/fzf/bin"
fi

# Make fzf use ripgrep by default
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="\
  --color 16 \
  --color 'bg+:-1,fg+:4,hl:3,hl+:3,header:2,info:7,prompt:6' \
  --color 'border:0,gutter:0,marker:5,pointer:4,scrollbar:8,spinner:1' \
  --layout=reverse \
  --preview='bat {}' \
  --tiebreak=length,end \
"

export FZF_CTRL_T_COMMAND="fd"

# Auto-completion
if [[ $- == *i* ]] then;
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
