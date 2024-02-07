#!/bin/sh

. ./conf
if ! [ "$1" = 'log' ]
then
	git checkout trigger
	i="$(cat cunny)"
	echo $(( $i + 1 )) > cunny
	git add cunny; git commit -m $(($i+1)); git pull; git push
	sleep 2
fi

curl -sH "Accept: application/vnd.github.base64+json" -H "Authorization: Bearer $github_token" \
https://api.github.com/gists/"$gist" \
| jq '.files."log.txt".content' | xargs printf | base64 -d

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
