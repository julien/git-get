#!/usr/bin/env bash
set -o errexit
set -o pipefail

token=

err() {
	echo "$@" >&2
}

get_token () {
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

is_git_dir () {
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

main () {
	# get_token
	# Allow passing these:
	# -t (title or last commit if not specificed)
	# -from (source branch or current branch if not specificed)
	# -to (destination branch or master if not specified)
	# -c (description (optional))
	# -from-remote (source remote (optional))
	# -to-remote (destination remote (optional))


	# 1. Check if we're in a .git directory
	# 2. Parse arguments
	# 3. Set default options
	# 4. Check credentials (this could also be part of step 1.)
	# 5. Send a pull request
	# Next steps: list pull request, get pull request, close pull request (optional)
}

main $@

