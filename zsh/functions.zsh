# Open man page in Preview.app
function manp() {
  if [[ -z "$@" ]]; then
    man -t "$@";
    return;
  fi

  man -w "$@" | xargs groff -Tps -mandoc -c -f C | open -f -a Preview;
}

# Create a data URL from a file
function datauri() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}