# cd to dir and ls afterwards
function cl() {
  cd "$1" && ls -AGghp;
}

function mcd() {
  mkdir -p "$1" && cd "$1"
}

# Create a data URL from a file
function datauri() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Return some request time data from curl
function ttfb() {
  curl -o /dev/null -sL \
    -w "$(cat << EOF
HTTP/%{http_version} %{http_code} %{url_effective}
Downloaded %{size_download}b
DNS %{time_namelookup}s
Connect %{time_connect}s
Handshake %{time_pretransfer}s
TTFB %{time_starttransfer}s
Total %{time_total}s\n
EOF
    )" "$*" | awk '
      NR==1 { print }
      /b$/ { sub(/b$/, ""); printf "%-12s %8.3fKB\n", $1, $2 / 1000 }
      /s$/ { sub(/s$/, ""); printf "%-12s %8.3fms\n", $1, $2 * 1000 }'
}

# diff url responses
function curldiff() {
  local args=()
  local curlopts=""

  while [[ "$#" -ne 0 ]]; do
    if [[ "$1" =~ "^-" ]]; then
      curlopts+="$1"
    else
      args+=("$1")
    fi
    shift
  done

  if [[ "${#args}" -ne 2 ]]; then
    printf "%s\n" "Invalid number of arguments." >&2
    printf "%s\n" 'Usage: `curldiff [OPTIONS] urlA urlB`'
    return 1
  fi

  diff --left-column --side-by-side \
    <(curl -s -L $curlopts ${args[1]}) \
    <(curl -s -L $curlopts ${args[2]})
}

function svg-sprite() {
  if [[ -z "$@" ]]; then
    cat <<EOF
svg-sprite - convert svg's to a symbol sprite

Usage:
  svg-sprite <path|glob>
EOF
    echo "\nERR: no arguments given." >&2;
    return 1;
  fi;

  local head='<svg xmlns="http://www.w3.org/2000/svg" style="display:none">';
  local tail='</svg>';
  local body='';

  # Use shell's glob expansion
  for file in "$@"; do
    local mimeType=$(file -b --mime-type "$file");
    if [[ "$mimeType" =~ "^image/svg(\+xml)?$" ]]; then
      local base="${file##*/}";
      local id="${base%.*}";
      local viewBox=$(grep -oE 'viewBox="[^"]+"' < "$file");
      local symbol=$(cat "$file" \
        | tr '\n' ' ' \
        | sed -E 's#<(\?xml|!)[^>]+>##g' \
        | sed -E "s#<svg[^>]+>#<symbol id=\"$id\" $viewBox>#g" \
        | sed -E 's#</svg>#</symbol>#g'
      );

      body+="$symbol";
    else
      echo "Skipping $file ($mimeType)" >&2;
    fi;
  done;

  if [[ -z "$body" ]]; then
    echo "SVG body empty." >&2;
    return 1;
  fi;

  echo "$head$body$tail";
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
