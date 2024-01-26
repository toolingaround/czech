#!/bin/sh
if [ "$(basename $0)" = "p" ]
then
	path="AWKWORD"
	cd "$path"
	git add persist
	git commit -m "persist"; git push;
else
	if ! [ $(id -u) -eq 0 ]
	then
		echo "Run as root tard"
		exit 1
	fi
encryp="-----BEGIN AGE ENCRYPTED FILE-----
YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNjcnlwdCBYK0JOWGVNQjRxamNpa2wx
U1JXUFR3IDE4CkFKc25UdDlzdE1xaUFPRXl1S2s4dlF4NXVSSWNWOEQxaDdmbWor
RzVZTDAKLS0tIDVkL1RYOS93TGFFTFJqSzNIS0N1dWhBQWtNdE4zS3dhTGMweUlO
M2Q5dFkKFZi8N4lzPpeLcDr82DKeMdeWCKUl1jIf5TrYx4SkPnhsXdR/PwbwJXzg
7yR12CcnFZVuwL3U1ASLt8arEJOueeNu6V85EKYOfvl4vKO+3wc6MA/tE21MbUKE
DcJmWY5AQiAsBjkgU36bePJh87Zgp15EQgfDK5QGlYbNNd79ffauIMEYuTVfSEsK
yLXwMh3/Dqs+BY3bMtjbRejoxFFNKQQMcH1qm6R3FMbaiQN6U0+fuDqejf+KXY5c
NZQw1m2GLO7u9ic5BVnG5KxXUlR2KaE=
-----END AGE ENCRYPTED FILE-----"
	apt install age
	cd "$(dirname $0)"
	# adds git remote
	$(echo "$encryp" | age -d)
	[ -d persist ] || mkdir persist
	[ -d persist/bin ] || mkdir persist/bin/
	ln -s ../../persist.sh persist/bin/p
fi
