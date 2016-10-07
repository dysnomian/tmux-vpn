#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
vpn_connected_icon=""
vpn_connected_default=" "

# icons are set as script global variables
get_icon_settings() {
	vpn_icon=$(get_tmux_option "@vpn_connected_icon" "$vpn_connected_default")
}

main() {
	get_icon_settings
	printf "$vpn_connected_icon"
}
main
