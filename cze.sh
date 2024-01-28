#!/bin/sh

. ./conf
if ! [ "$1" = 'log' ]
then
	i="$(cat cunny)"
	echo $(( $i + 1 )) > cunny
	git add cunny; git commit -m $(($i+1)); git pull; git push
	sleep 2
fi

curl -H 'User-Agent: cuck v2.0' -H "Authorization: Bearer $apikey" \
https://dpaste.com/api/user_items/"$user"/ \
| jq '."Your items"[0]' | xargs -I file curl file.txt

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
