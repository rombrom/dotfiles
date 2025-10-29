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

function qq() (
  local opt_url="http://localhost:8080/v1/chat/completions"
  local opt_max_tokens=150
  local opt_temperature=0.5
  local opt_top_p=0.8
  local input=""

  while [[ $# -gt 0 ]]; do
    case $1 in
      -u|--url)
        opt_url="$2"
        shift 2
        ;;
      -m|--max-tokens)
        opt_max_tokens="$2"
        shift 2
        ;;
      -t|--temperature)
        opt_temperature="$2"
        shift 2
        ;;
      -p|--top-p)
        opt_top_p="$2"
        shift 2
        ;;
      *)
        if [[ -n $input ]]; then
          input="$input $1"
        else
          input="$1"
        fi
        shift
        ;;
    esac
  done

  if [[ -z "$input" ]]; then
    echo "Please provide input for the oracle."
    return 1
  fi

  local response=$(mktemp)
  trap 'rm -f "$response"' EXIT

  local http_code=$(curl -s "${opt_url}" \
    -o "$response" \
    -w "%{http_code}" \
    -d "{
      \"max_completion_tokens\": ${opt_max_tokens},
      \"messages\": [
        { \"role\": \"system\", \"content\": \"YOU ARE A HELPFUL ASSISTANT WITH ENCYCLOPEDIC KNOWLEDGE. YOU MUST NOT RESPOND WITH QUESTIONS. YOU MUST RESPOND DIRECTLY, CONCISELY, AND ON-TOPIC. OUTPUT FORMAT ONLY SUPPORTS TEXT AND LITERAL ANSI ESCAPE SEQUENCES.\" },
        { \"role\": \"user\", \"content\": $(jq -R @json <<< $input) }
      ],
      \"temperature\": ${opt_temperature},
      \"top_p\": ${opt_top_p}
    }")

  if [[ $http_code -lt 200 || $http_code -ge 300 ]]; then
    cat "$response" >&2
  else
    cat "$response" | jq -r '.choices[0].message.content' | less -ERX
  fi

  rm "$response"
)

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
