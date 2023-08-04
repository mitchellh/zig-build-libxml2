#!/usr/bin/env bash
#
# Verify the contents of the upstream. This compares to the "upstream.txt"
# file for the upstream ref.
set -e

# Checksum a directory. This ignores timestamps and user/group info.
function checksum {
  tar -C $1 \
    --sort=name \
    --mtime='1970-12-31 16:00:00' \
    --group=0 --owner=0 --numeric-owner \
    -cf - . | shasum -a256
}

out=upstream
ref=$(cat ${out}.txt | tr -d "[:space:]")
tmp=$(mktemp -d)

./update.sh $ref $tmp
rm -f ${tmp}.txt

actual=$(checksum $out)
expected=$(checksum $tmp)
if [ "$actual" != "$expected" ]; then
    echo "Upstream verification failed!"
    echo "Expected: $expected"
    echo "Actual:   $actual"
    exit 1
fi

exit 0
