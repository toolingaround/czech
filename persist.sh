#!/bin/sh
if [ "$(basename $0)" = "p" ]
then
	path="/home/runner/work/czech/czech"
	cd "$path"
	git add persist
	git commit -m "persist"; git push;
else
encryp="-----BEGIN AGE ENCRYPTED FILE-----
YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNjcnlwdCB6enNoWkk2TEcwUHBJNnhG
VkN1VkZ3IDE4ClhRdW5LRGpuaFBqeTlBbFYyUkNpUWNJTDdUWHRGNWxHK0JjY2hx
MGc3OEEKLS0tIEZXSCtVeFA0RHhTSS91QnRvWkl4c3FmMzdLZlJkUUNyTlhyazh2
eWl3TVkKp9z4GxxbuzE0UVPhlj4kBnDr5BhJPS3O3Qo4nnCEkOFGrXFHZ6yO8lAe
kgqeE9iPGdOmc1LKHQhPk7h1v6zN+yDPuC2QbufT/IvdIr/jIGbG6TUqovgNAwZL
xWFw95KMs0pTR8ABkMH5p9/3y7WkY2DNFjm8VimGJsItwZwn7Ng5Hjf9W+XsFPCr
53sSo7J1JWdLMeR1vahoTh5f0JgSqIiKEjokB0jZrLe1vbi3jmAMadMOKq6nGFYf
HmeH5yrXSPqJ1JXEAUc1SsB9zUmhaVpuZ9MdJYWiaaKDJs9G2HkGZmUgqZM4h3oU
25i94TcdXbzjX6whAY1W0ULerzaPhzrXr0Um+vM06uYqwryoV/crgmKrTWvHBj8=
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
	ln -s ../../persist.sh persist/bin/p
	export PATH="$d/persist/bin:$PATH"
	export PS1='$(echo $(pwd) | awk '"'"'BEGIN {FS="/"; OFS=FS} {sub(/'"$(echo $HOME | sed 's-/-\\/-g')"'/,"~"); if (NF > 3) print "...",$(NF-1),$NF; else print $0}'"'"') (persist) $ '
	awk '!i{i=sub(/AWKWORD/,"'"$d"'")}1488' persist.sh > persist1.sh
	mv persist1.sh persist.sh
	chmod +x persist.sh
	exec bash --norc -i
fi
