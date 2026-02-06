# Enable aliases to be sudo’ed
alias sudo='sudo '

alias vi="nvim"

# Use ls colors by default
# Need to use gls due to coreutils install from brew
alias ls="gls -v --color=always --group-directories-first --indicator-style=slash"
alias l="ls -Ahl"
alias lc="ls --format=single-column"
alias lt="ls -halt"
alias ltr="ls -haltr"

# navigation
alias ~='cd ~'
alias ..='cd ..'

# this always happens
alias :q='exit'
alias :qa='exit'
alias cp='cp -R'
alias mkdir='mkdir -p'
alias nom='npm'

# Always enable colored `grep` output
alias grep='grep --color'

# use gojq as jq
alias jq='gojq'

# Ignore common "junk" folders
alias tree='tree --dirsfirst -I "node_modules"'

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Suffix aliases
alias -g Y='| pbcopy'

# kitty stuff
if [[ "$TERM" = "xterm-kitty" ]]; then
  alias title='kitty @ set-tab-title'
  alias icat='kitty +kitten icat'
fi

# Reload zshrc
alias reload='clear && exec zsh'

# llms
alias llm-qwen-vl='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  -hf unsloth/Qwen3-VL-30B-A3B-Instruct-GGUF:UD-Q4_K_XL \
  --n-gpu-layers 99 \
  --jinja \
  --top-p 0.8 \
  --top-k 20 \
  --temp 0.7 \
  --min-p 0.0 \
  --flash-attn on \
  --presence-penalty 1.5 \
  --ctx-size 131071'
alias llm-qwen-coder='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  -hf unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL \
  --n-gpu-layers 99 \
  --jinja \
  --top-p 0.8 \
  --top-k 20 \
  --temp 0.7 \
  --min-p 0.0 \
  --repeat-penalty 1.05 \
  --ctx-size 131071'
alias llm-qwen-coder-next='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  -hf unsloth/Qwen3-Coder-Next-GGUF:UD-Q2_K_XL \
  --jinja \
  --top-p 0.95 \
  --top-k 40 \
  --temp 1.0 \
  --min-p 0.01 \
  --fit on'
alias llm-glm='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  -hf unsloth/GLM-4.7-Flash-GGUF:UD-Q4_K_XL \
  --jinja \
  --threads -1 \
  --ctx-size 131071 \
  --temp 0.7 \
  --top-p 1.0 \
  --min-p 0.01 \
  --fit on'
alias llm-devstral='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  -hf unsloth/Devstral-Small-2-24B-Instruct-2512-GGUF:UD-Q4_K_XL \
  --jinja \
  -ngl 99 \
  --threads -1 \
  --ctx-size 131071 \
  --temp 0.15'
