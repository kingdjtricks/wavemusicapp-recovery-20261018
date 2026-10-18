#!/usr/bin/env bash
# Installs only the checksum-pinned Wave release helper staged by the deploy account.
set -euo pipefail
source_file=/home/wavedeploy/incoming/wavemusicapp-deploy-release.aef1a4b.tsx
target_file=/usr/local/sbin/wavemusicapp-deploy-release
expected_sha=253dba1bb1820e3bb3fd1790c04086dfd7fff736947c63a9bb229331d2e689fe
actual_sha="$(sha256sum "$source_file" | awk '{print $1}')"
[[ "$actual_sha" == "$expected_sha" ]] || {
  printf 'Staged release helper checksum did not match.\n' >&2
  exit 1
}
install -o root -g root -m 0755 "$source_file" "$target_file"
bash -n "$target_file"
rm -f "$source_file"
printf 'Wave Node 20 migration helper installed.\n'
