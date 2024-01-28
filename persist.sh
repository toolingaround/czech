#!/bin/sh
if [ "$(basename $0)" = "p" ]
then
	path="/home/runner/work/czech/czech"
	cd "$path"
	git add persist
	git commit -m "persist"; git push;
else
encryp="-----BEGIN AGE ENCRYPTED FILE-----
YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNjcnlwdCBaNWFlQlE1QjNMTEJVeE5j
aUZzMjV3IDE4CmdRK25kWSt5OWd1ZUFxdklYVDBLdUZTalVTK0dIdUpnZytXSU5x
NU9heFEKLS0tIFdOVTNhNEI4TjNicVZTU2J2MVYxY1dsdjZEam4zSENsR1hMbXpJ
OGxoWlUKZe2KCwJSKx42BxgBLXVDfS1qqKq05QtBhhJm0AyICpLCGk+5L7Uz7nfG
XJUxZnJAVT1k9uU6qY6hOdiPHKJPWcocxrr2GagZtl6Qqv6MSx/wbJ/NoKFaP8Fd
FomvwpwBoyRixg4c10czN0f8z4SXof0qDJW+hCBVKVbEZWA1tBLqWQ8yH9eZOB7q
A9kUmST0s91iOk7UyqbpI22JvH168Xmqrru9RpvTZ1r3UUNLsQm6U11uvRcYK7PQ
N93jmZvalLsMPozvoHm5lrXxtSc9To5HO//wrRBU2nOF589nDAcPeOC/aJhbYxfC
dod3GVt/LCD5PUnTnnrmwMsYe+ruTGaP0c3jjPfMkT5db0Xe/BYi+O1TrATsxSl8
-----END AGE ENCRYPTED FILE-----"
	sudo apt install age || { echo "Run as root tard"; exit 1; }
	cd "$(dirname $0)"
	cp "$0" ../ 
	find ! -name . -prune -exec rm -rf \{\} \+
	trap 'mv ../persist.sh ./' INT TERM HUP EXIT
	d="$(pwd)"
	# clones git repo
	$(echo "$encryp" | age -d) ./
	[ -d persist ] || mkdir persist
	[ -d persist/bin ] || mkdir persist/bin/
	[ -L persist/bin/p ] || ln -s ../../persist.sh persist/bin/p
	export PATH="$d/persist/bin:$PATH"
	export PS1='$(echo $(pwd) | awk '"'"'BEGIN {FS="/"; OFS=FS} {sub(/'"$(echo $HOME | sed 's-/-\\/-g')"'/,"~"); if (NF > 3) print "...",$(NF-1),$NF; else print $0}'"'"') (persist) $ '
	awk '!i{i=sub(/AWKWORD/,"'"$d"'")}1488' persist.sh > persist1.sh
	mv persist1.sh persist.sh
	chmod +x persist.sh
	exec bash --norc -i
fi
