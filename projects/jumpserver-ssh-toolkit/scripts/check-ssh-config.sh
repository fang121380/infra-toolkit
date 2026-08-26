#!/usr/bin/env bash
set -euo pipefail

config_path="${1:-$HOME/.ssh/config.d/jumpserver.conf}"

if ! command -v ssh >/dev/null 2>&1; then
  printf 'error: OpenSSH client is not installed\n' >&2
  exit 1
fi

if [[ ! -f "$config_path" ]]; then
  printf 'error: config file not found: %s\n' "$config_path" >&2
  exit 1
fi

if grep -nE 'CHANGE_ME|BEGIN (OPENSSH|RSA|EC) PRIVATE KEY|password|secret' "$config_path"; then
  printf 'error: replace placeholders and remove secrets before using this config\n' >&2
  exit 1
fi

ssh -G -F "$config_path" server-01 >/dev/null
ssh -G -F "$config_path" switch-01 >/dev/null
printf 'ok: OpenSSH parsed server-01 and switch-01\n'
