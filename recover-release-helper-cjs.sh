#!/usr/bin/env bash
# Installs only the checksum-pinned Wave helper staged by the deploy account.
set -euo pipefail
source_file=/home/wavedeploy/incoming/wavemusicapp-deploy-release.791d15c.cjs
target_file=/usr/local/sbin/wavemusicapp-deploy-release
expected_sha=96b8e62ce102f2e6874692c3d60fcd9c2bd43b9ab0dcf4da957c6a56496ed651
actual_sha="$(sha256sum "$source_file" | awk '{print $1}')"
[[ "$actual_sha" == "$expected_sha" ]] || {
  printf 'Staged release helper checksum did not match.\n' >&2
  exit 1
}
install -o root -g root -m 0755 "$source_file" "$target_file"
bash -n "$target_file"
rm -f "$source_file"
printf 'Wave prebuilt migration helper installed.\n'
