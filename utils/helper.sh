function isHelpFlag() {
  if [[ "$1" == "h" ]]; then
    echo; echo "$2"
    return 0
  fi
  return 1
}

function isUnknownFlag() {
  if [[ "$1" == "?" ]]; then
    echo; echo "unknown flag: -$2"
    return 1
  fi
}        