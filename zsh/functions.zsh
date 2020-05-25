# Open man page in Preview.app
function manp() {
  if [[ -z "$@" ]]; then
    man -t "$@";
    return;
  fi

  man -w "$@" | xargs groff -Tps -mandoc -c -f C | open -f -a Preview;
}

# cd to dir and ls afterwards
function cl() {
  cd "$1" && ls -Ap;
}

# Create a data URL from a file
function datauri() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

function ddg() {
  if [[ -n $1 ]]; then
    open "https://duckduckgo.com/?q=$1";
  fi;
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}
