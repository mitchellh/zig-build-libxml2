#!/usr/bin/env bash
#
# Update the upstream to a specific commit. If this fails then it may leave
# your working tree in a bad state. You can recover by using Git to reset:
# git reset --hard HEAD.
set -e

ref=${1:-HEAD}
out=${2:-upstream}

rm -rf $out
git clone https://github.com/GNOME/libxml2.git $out
git -C $out checkout $ref
git -C $out rev-parse HEAD > ${out}.txt
rm -rf $out/.git

# Lower file size
rm -rf $out/doc
rm -rf $out/result
rm -rf $out/test
