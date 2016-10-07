#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_vpn_status() {
  if command_exists "scutil"; then

    if [ -n "$1" ]; then
      VPN_NAME="$1";
    elif [ -n "$DEFAULT_VPN_NAME" ]; then
      VPN_NAME="$DEFAULT_VPN_NAME";
    else
      echo "No VPN name given, and DEFAULT_VPN_NAME is not set.";
      return 1;
    fi

    scutil --nc show "$VPN_NAME" | head -n 1 | awk '{gsub(/[()]/,""); print $2}'
  else
    echo "Not supported on systems without scutil. Sorry!"
  fi
}

main() {
  print_vpn_status
}
main
