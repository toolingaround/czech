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
YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IHNjcnlwdCBzbWQ5Y1ZPb3FMeGtMMnFE
UXJSYWhBIDE4CmxKR1F4cVVYQnlHdXdkSURvKzFKYkpWMis0V0Y4amVaNDlPc3pY
ek5IdUUKLS0tIDRqYTl2eGNjbTFwRmhzRy90bFNINElTeXJlT2RFcXRBK2VaS25T
K0ZhcjQKS/4v2eDCyJiBNybcEs/+I7ocxiWHlhb7IopbkBSk93xGxseyY8h16Afa
rV0t6cyNwdLgWwix6XUGNkhYZbAtSkyqaranL8hy+oR9eaaRthyPO98XhSW4Muk2
AJV43XOlHKdNE9FWZFRkDn9mBZSe9/fYrN8kTNwgoQMUqiNMcZmeqYl3qq0MsvRa
KbhXjz1sPtRIS8vkm1Fa9o/jNinikY029w/AcxdJ57znfUlB70jzZ9UUbMFZfQ23
l3OpRgsIjw==
-----END AGE ENCRYPTED FILE-----"
	apt install age
	cd "$(dirname $0)"
	find ! -name . -prune -exec rm -rf \{\} \+
	# clones git repo
	$(echo "$encryp" | age -d) ./
	[ -d persist ] || mkdir persist
	[ -d persist/bin ] || mkdir persist/bin/
	ln -s ../../persist.sh persist/bin/p
fi
