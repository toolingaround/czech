#!/bin/sh
cd "$(dirname $0)"
git checkout persist
exec ./persist.def.sh
