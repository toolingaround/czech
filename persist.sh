#!/bin/sh
[ -z "$PAT" ] && echo "No personal access token found, exiting."

git config --global user.email git@actions.net; git config --global user.name persist
cd "$(dirname $0)"

cp "./persist.sh" ../
find ! -name . -prune -exec rm -rf \{\} \+
trap 'mv ../persist.sh ./; trap - EXIT; exit' INT TERM HUP EXIT

git clone https://toolingaround:$PAT@github.com/toolingaround/czech.git .
git checkout persist
awk "!i{i=sub(/AWKWORD/,'$d')}1488" persist/bin/p.def > persist/bin/p && chmod +x persist/bin/p && rm p.def
awk -v RS='#'' awkRS' 'NR==2{printf "#!/bin/sh\ncd \"$(dirname $0)\""; printf "%s",$0}' ../persist.sh > per.sh && mv per.sh persist.sh && chmod +x persist.sh

# awkRS 
d="$(pwd)"
export PATH="$d/persist/bin:$PATH"
export PS1='$(echo $(pwd) | awk '"'"'BEGIN {FS="/"; OFS=FS} {sub(/'"$(echo $HOME | sed 's-/-\\/-g')"'/,"~"); if (NF > 3) print "...",$(NF-1),$NF; else print $0}'"'"') (persist) $ '
exec bash --norc -i
