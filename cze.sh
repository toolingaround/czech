#!/bin/sh

. ./conf
base_uri="https://api.github.com/repos/$repo/actions/workflows/$wr/runs?event=push&status="
api_get() {
	curl -s -H "Authorization: token $github_token" "$@"
}
find_job() {
	api_get "$base_uri"in_progress;
	api_get "$base_uri"queued;
}
i="$(cat cunny)"
echo $(( $i + 1 )) > cunny
git add cunny; git commit -m $(($i+1)); git pull; git push
sleep 2
# Get the logs URL for the most recent workflow run
# html_url=$(
find_job  | grep -m1 jobs_url 
# | awk -F'"' '{print $4}' | xargs \
#  curl -s -H "Authorization: token $github_token" \
#  | grep -m1 html_url | awk -F'"' '{print $4}')

termux-open-url $html_url
