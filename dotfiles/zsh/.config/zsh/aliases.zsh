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
alias qq='container exec -t jeeves mise exec node@26.1.0 -- pi -nt -p --thinking off'
alias jeeves='container exec -it jeeves'
alias killjeeves='container kill jeeves' # sorry mate
alias pi='container exec -it jeeves bash -c "cd $PWD && mise exec node@26.1.0 -- pi"'

alias llm-serve-single='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  --models-preset ~/.config/llama.cpp/single.ini'
alias llm-serve-concurrent='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  --models-preset ~/.config/llama.cpp/concurrent.ini'
alias llm-serve-parallel='llama-server \
  --host 0.0.0.0 \
  --port 8484 \
  --models-preset ~/.config/llama.cpp/parallel.ini'
