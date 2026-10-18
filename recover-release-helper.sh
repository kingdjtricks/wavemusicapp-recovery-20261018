#!/usr/bin/env bash
# Repairs only the root-owned Wave immutable-release helper from a pre-staged,
# checksum-verified file on the existing production instance.
set -euo pipefail

source_file=/home/wavedeploy/incoming/wavemusicapp-deploy-release.b5fc02
target_file=/usr/local/sbin/wavemusicapp-deploy-release
expected_sha=8407566c129bedc98c558c1b83bccb2d18710c2076f6668bb437b0b76aceb8ae

actual_sha="$(sha256sum "$source_file" | awk '{print $1}')"
[[ "$actual_sha" == "$expected_sha" ]] || {
  printf 'Staged release helper checksum did not match.\n' >&2
  exit 1
}

install -o root -g root -m 0755 "$source_file" "$target_file"
bash -n "$target_file"
rm -f "$source_file"
printf 'Wave release helper repaired.\n'
