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

# quick question
alias qq=',llm'

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
alias llm-qwen35-small='llama-server \
  -hf bartowski/Qwen_Qwen3.5-9B-GGUF:Q8_0 \
  --host 0.0.0.0 \
  --port 8484 \
  --batch-size 1024 \
  --ubatch-size 1024 \
  --jinja \
  --min-p 0.00 \
  --presence-penalty 1.25 \
  --repeat-penalty 1.0 \
  --temp 0.6 \
  --top-k 20 \
  --top-p 0.95 \
  --ctx-size 131071'
alias llm-qwen35-dense='llama-server \
  -hf bartowski/Qwen_Qwen3.5-27B-GGUF:Q4_K_M \
  --host 0.0.0.0 \
  --port 8484 \
  --batch-size 1024 \
  --ubatch-size 1024 \
  --jinja \
  --min-p 0.00 \
  --presence-penalty 1.25 \
  --repeat-penalty 1.0 \
  --temp 0.6 \
  --top-k 20 \
  --top-p 0.95 \
  --ctx-size 131071'
alias llm-qwen35-moe='llama-server \
  -hf bartowski/Qwen_Qwen3.5-35B-A3B-GGUF:Q4_K_M \
  --host 0.0.0.0 \
  --port 8484 \
  --batch-size 1024 \
  --ubatch-size 1024 \
  --jinja \
  --min-p 0.00 \
  --presence-penalty 1.25 \
  --repeat-penalty 1.0 \
  --temp 0.6 \
  --top-k 20 \
  --top-p 0.95 \
  --ctx-size 131071'
