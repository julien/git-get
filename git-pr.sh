#!/usr/bin/env bash
set -o errexit
set -o pipefail

main() {
	while getopts ":hl" opt; do
		case ${opt} in
			h)
				usage
				;;
			l)
				local r=$(git remote -v | grep -Eo 'origin\s.*\(fetch\)')
				local p=$(echo "$r" | grep -Eo 'github.com:(\w+)(\/)(\.*)')
				echo $p
				exit 0
				;;
			?)
				usage
				exit 1
				;;
		esac
	done
	shift $((OPTIND -1))
}

err() {
	echo "$@" >&2
}

remote() {
	$(git remote -v | grep -Eo 'origin\s.*\(fetch\)')
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

main $@

