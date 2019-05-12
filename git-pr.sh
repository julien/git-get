#!/usr/bin/env bash
set -o errexit
set -o pipefail

token=

err() {
	echo "$@" >&2
}

get_token() {
	if [[ -f "$HOME/.git-pr-token" ]]; then
		local temp_token=$(cat "$HOME/.git-pr-token")
		if [[ ! -z "$temp_token" ]] ; then
			token=$temp_token
			return 0
		fi
	fi

	local u=
	read -p "Enter your github username:" u
	if [[ -z "$u" ]] ; then
		err "A username is required."
		return 1
	fi

	local out=$(curl \
		-d "{\"note\": \"git-pr\", \"scopes\": [\"repo\"]}" \
		-g \
		--user "$u" \
		https://api.github.com/authorizations)

	token=$(echo "$out" | grep -Po "(?<=\"token\":\s.)([0-9a-z]+)")

	if [[ ! -z "$token" ]] ; then
		cat > "$HOME/.git-pr-token" <(echo $token)
		return 0
	fi

	return 1
}

is_git_dir() {
	local dir=
	if [[ ! -z "$1" ]]; then
		dir="$1"
	else
		dir=$PWD
	fi

	local gitdir=$(find "$dir" -type d -name ".git")
	if [[ -z "$gitdir" ]] ; then
		err "No .git directory found in $dir."
		return 1
	fi

	return 0
}

usage() {
	echo
	echo "Usage: git-pr.sh [command]"
	echo
	echo "Available commands: "
	echo
	echo "-h Print help."
	echo "-l List current pull requests."
	echo
}

main() {
	while getopts ":hl" opt; do
		case ${opt} in
			h)
				usage
				exit 0
				;;
			l)
				# List pull requests
				exit 0
				;;
			\?)
				usage
				exit 1
				;;
		esac
	done
	shift $((OPTIND -1))
}

main $@

