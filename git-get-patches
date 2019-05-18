#!/usr/bin/env bash
set -o errexit
set -o pipefail

__main() {
	local remote=$(git remote -v | grep -Eo 'origin\s.*\(fetch\)')
	local project=$(echo "$remote" | grep -Eo '(:)(.*\.git)' | sed s/:// | sed s/\.git$// )
	local url="https://api.github.com/repos/$project/pulls"
	local resp=$(curl -L -s -f $url)
	local patch_urls=$(echo $resp |\
		python -m json.tool |\
		grep -Eo '\"patch_url\":\s.*"' |\
		sed s/\"patch_url\":\ // |\
		sed s/\"//g)

	pushd $PWD
	mkdir -p "patches"
	cd "patches"

	local patches=$(echo $patch_urls | tr '\n' ' ')

	OIFS=$IFS
	IFS=' '
	for x in $patches
	do
		curl -L -O "$x"
	done
	IFS=$OIFS

	popd
}

__main $@

