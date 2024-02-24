#!/bin/sh
encryp="-----BEGIN AGE ENCRYPTED FILE-----
YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNjcnlwdCBGbXpOazNnaTI0MUtVdlc0
U0EyV2lRIDE4Clh1UkFtUndXMWw5QjYyMkdqNDJ0WlVVbW5ZV3F5RmhBYmNDSkQw
ek9lcW8KLS0tIDYyanQ4bDdXemZtMVlKMm43Y2VTc3dTL0JZa1ZHSTNaNllEVzh0
WlhZZGsKQ7jpd47N9hc3J5pmVUVF87RTFRawKCUw9usoBMF5lEHMxxzTZEUGIJEv
xLjyfKprROUijZ4YXZDSyRKe8r4crP2sUnt8tyB8mk+S4JV+2ioPucxi+V27ON6r
f4rsFtdtCMBJmaIzLRcrdxgj1pMpPJTxYeyFy4hQIJNC4DhGaZTuyBkJNvwODMwi
nbr5e2uVjJla70H5s5i0VbECs2DIEucOWcIEJOUiKAYS8xcn2/uz3CwsqGC6FsE0
xaDTY0GfsrHw
-----END AGE ENCRYPTED FILE-----"
git config --global user.email git@actions.net; git config --global user.name persist
sudo apt install age || { echo "Run as root tard"; exit 1; }
cd "$(dirname $0)"
cp "./persist.sh" ../
find ! -name . -prune -exec rm -rf \{\} \+
trap 'mv ../persist.sh ./; trap - EXIT; exit' INT TERM HUP EXIT
d="$(pwd)"
# clones git repo
$(echo "$encryp" | age -d)
git checkout persist
export PATH="$d/persist/bin:$PATH"
export PS1='$(echo $(pwd) | awk '"'"'BEGIN {FS="/"; OFS=FS} {sub(/'"$(echo $HOME | sed 's-/-\\/-g')"'/,"~"); if (NF > 3) print "...",$(NF-1),$NF; else print $0}'"'"') (persist) $ '
awk '!i{i=sub(/AWKWORD/,"'"$d"'")}1488' persist/bin/p.def > persist/bin/p
chmod +x persist/bin/p
exec bash --norc -i
