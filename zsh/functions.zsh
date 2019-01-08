# Open man page in Preview.app
function pman() {
  if [[ -z "$@" ]]; then
    man -t "$@";
    return;
  fi

  man -w "$@" | xargs groff -Tps -mandoc -c -f C | open -f -a Preview;
}