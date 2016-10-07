#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

vpn_status="#($CURRENT_DIR/scripts/vpn_status.sh)"
vpn_connected_icon="#($CURRENT_DIR/scripts/vpn_icon.sh)"
vpn_status_interpolation="\#{vpn_status}"
vpn_connected_icon_interpolation="\#{vpn_connected_icon}"

set_tmux_option() {
	local option=$1
	local value=$2
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local string=$1
	local vpn_status_interpolated=${string/$vpn_status_interpolation/$vpn_status}
	local all_interpolated=${vpn_status_interpolated/$vpn_connected_icon_interpolation/$vpn_connected_icon}
	echo $all_interpolated
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
