#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: sudo bootstrap-8021x.sh --env-file PATH [--apply]

Without --apply, validate inputs and print the planned NetworkManager changes.
EOF
}

env_file=''
apply=no
while (($#)); do
  case "$1" in
    --env-file)
      [[ $# -ge 2 ]] || { usage >&2; exit 2; }
      env_file=$2
      shift 2
      ;;
    --apply) apply=yes; shift ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'error: unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ -n "$env_file" && -f "$env_file" ]] || { printf 'error: --env-file must point to a file\n' >&2; exit 2; }
# shellcheck disable=SC1090
source "$env_file"

: "${CONNECTION_NAME:?missing CONNECTION_NAME}"
: "${INTERFACE_NAME:?missing INTERFACE_NAME}"
: "${EAP_IDENTITY:?missing EAP_IDENTITY}"
: "${CA_CERT:?missing CA_CERT}"
: "${CLIENT_CERT:?missing CLIENT_CERT}"
: "${CLIENT_KEY:?missing CLIENT_KEY}"
: "${AUTOCONNECT:=yes}"

if [[ "$INTERFACE_NAME" == CHANGE_ME || "$EAP_IDENTITY" == *CHANGE_ME* ]]; then
  printf 'error: replace CHANGE_ME values in %s\n' "$env_file" >&2
  exit 2
fi

if [[ "$apply" != yes ]]; then
  cat <<EOF
Dry run. No changes made.

NetworkManager profile: $CONNECTION_NAME
Interface:              $INTERFACE_NAME
802.1X identity:        $EAP_IDENTITY
CA certificate:         $CA_CERT
Client certificate:     $CLIENT_CERT
Client private key:     $CLIENT_KEY
Autoconnect:            $AUTOCONNECT

Re-run with --apply to create/update the profile.
EOF
  exit 0
fi

if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  printf 'error: --apply requires root; use sudo\n' >&2
  exit 1
fi

command -v nmcli >/dev/null 2>&1 || { printf 'error: required command not found: nmcli\n' >&2; exit 1; }

[[ -r "$CA_CERT" ]] || { printf 'error: CA certificate is not readable: %s\n' "$CA_CERT" >&2; exit 1; }
[[ -r "$CLIENT_CERT" ]] || { printf 'error: client certificate is not readable: %s\n' "$CLIENT_CERT" >&2; exit 1; }
[[ -r "$CLIENT_KEY" ]] || { printf 'error: client private key is not readable: %s\n' "$CLIENT_KEY" >&2; exit 1; }

nmcli connection delete "$CONNECTION_NAME" >/dev/null 2>&1 || true
nmcli connection add type ethernet ifname "$INTERFACE_NAME" con-name "$CONNECTION_NAME"
nmcli connection modify "$CONNECTION_NAME" \
  ipv4.method auto \
  ipv6.method auto \
  connection.autoconnect "$AUTOCONNECT" \
  802-1x.enabled yes \
  802-1x.eap tls \
  802-1x.identity "$EAP_IDENTITY" \
  802-1x.ca-cert "$CA_CERT" \
  802-1x.client-cert "$CLIENT_CERT" \
  802-1x.private-key "$CLIENT_KEY" \
  802-1x.optional no

if [[ -n "${KEY_PASSWORD_FILE:-}" ]]; then
  [[ -r "$KEY_PASSWORD_FILE" ]] || { printf 'error: key password file is not readable\n' >&2; exit 1; }
  nmcli connection modify "$CONNECTION_NAME" 802-1x.private-key-password "$(<"$KEY_PASSWORD_FILE")"
fi

nmcli connection up "$CONNECTION_NAME"
printf 'ok: activated %s on %s\n' "$CONNECTION_NAME" "$INTERFACE_NAME"
