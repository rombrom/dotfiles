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

function svg-sprite() {
  if [[ -z "$@" ]]; then
    echo "No arguments given." >&2
    return 1
  fi

  local head='<svg xmlns="http://www.w3.org/2000/svg" style="display:none">'
  local tail='</svg>'
  local body=''

  # Use shell's glob expansion
  for file in "$@"; do
    local mimeType=$(file -b --mime-type "$file");
    if [[ "$mimeType" == "image/svg" ]]; then
      local base="${file##*/}"
      local name="${base%.*}"

      local viewBox=$(grep -oE 'viewBox="[^"]+"' < "$file")
      local symbol=$(cat "$file" \
        | sed -E 's/#000(000)?/currentColor/g' \
        | sed -E "s#<svg[^>]+>#<symbol id=\"$name\" $viewBox>#g" \
        | sed -E 's#</svg>#</symbol>#g'
      )

      body+="$symbol"
    else
      echo "Skipping $file ($mimeType)" >&2
    fi
  done;

  if [[ -z "$body" ]]; then
    echo "SVG body empty." >&2
    return 1
  fi

  echo "$head$body$tail"
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
