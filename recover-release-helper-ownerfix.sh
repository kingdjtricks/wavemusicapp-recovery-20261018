#!/usr/bin/env bash
# Repairs only the root-owned Wave immutable-release helper from a pre-staged,
# checksum-verified file on the existing production instance.
set -euo pipefail

source_file=/home/wavedeploy/incoming/wavemusicapp-deploy-release.bb7f0e0.ownerfix
target_file=/usr/local/sbin/wavemusicapp-deploy-release
expected_sha=db44e044df7c52e3098d950222ebd0625d2c10c5878d24341c144dc590168274

actual_sha="$(sha256sum "$source_file" | awk '{print $1}')"
[[ "$actual_sha" == "$expected_sha" ]] || {
  printf 'Staged release helper checksum did not match.\n' >&2
  exit 1
}
install -o root -g root -m 0755 "$source_file" "$target_file"
bash -n "$target_file"
rm -f "$source_file"
printf 'Wave release helper ownership repair installed.\n'
