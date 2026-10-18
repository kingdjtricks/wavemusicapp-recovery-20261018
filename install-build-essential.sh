#!/usr/bin/env bash
# Installs only the standard native-build toolchain required by better-sqlite3
# on the existing Wave production instance; no app data or secrets are read.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
command -v apt-get >/dev/null 2>&1 || {
  printf 'apt-get is required on this host.\n' >&2
  exit 1
}
if ! command -v make >/dev/null 2>&1 || ! command -v g++ >/dev/null 2>&1; then
  apt-get update
  apt-get install -y --no-install-recommends build-essential
fi
command -v make
command -v g++
command -v gcc
