#!/bin/sh

. ./conf
epoch=$(awk 'BEGIN{print srand(srand())}')
log() {
	curl -sH "Accept: application/vnd.github.base64+json" -H "Authorization: Bearer $github_token" \
	https://api.github.com/gists/"$gist" \
	| jq '.files."log.txt".content' | xargs printf | base64 -d
}

if ! [ "$1" = 'log' ]
then
	git checkout trigger || exit
	i="$(cat cunny)"
	echo $(( $i + 1 )) > cunny
	git add cunny; git commit -m $(($i+1)); git pull; git push
	git checkout master
	while(true)
	do
		if [ $(log | awk '!/^ *$/{n=$0}END{sub(/^ */,"",n);print n}') -ge $epoch ]
		then
			log
			break
		fi
		sleep 1;
	done
fi

log

# unused
# base_uri="https://api.github.com/repos/$repo/actions/workflows/$wr/runs?event=push&status="
# api_get() {
# 	curl -s -H "Authorization: token $github_token" "$@"
# }
# find_job() {
# 	api_get "$base_uri"in_progress&
# 	api_get "$base_uri"queued&
# }
# html_url=$(find_job  | grep -m1 jobs_url \
# 	| awk -F'"' '{print $4}' | xargs \
# 	curl -s -H "Authorization: token $github_token" \
# 	| grep -m1 html_url | awk -F'"' '{print $4}')
