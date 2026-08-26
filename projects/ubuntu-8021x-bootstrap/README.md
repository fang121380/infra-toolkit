# Ubuntu 802.1X Bootstrap

This project is a sanitized reference implementation for preparing an Ubuntu host for wired 802.1X with NetworkManager and EAP-TLS. It is deliberately conservative:

- default execution is a dry run;
- `--apply` is required before changing packages, certificates, or connections;
- credentials and certificates are supplied through environment variables or local files;
- the script never contains production addresses or secrets.

## Prerequisites

- Ubuntu 22.04 or newer
- NetworkManager and `nmcli`
- An organization-approved CA certificate and client certificate/private key
- A certificate identity expected by the RADIUS server
- Administrative approval to change the host network profile

## Usage

```bash
cp config/8021x.env.example /tmp/8021x.env
${EDITOR:-vi} /tmp/8021x.env

# Inspect prerequisites and planned changes
sudo ./scripts/bootstrap-8021x.sh --env-file /tmp/8021x.env

# Apply after reviewing the plan
sudo ./scripts/bootstrap-8021x.sh --env-file /tmp/8021x.env --apply
```

The script creates or updates a NetworkManager profile and activates it. Keep an out-of-band console available: changing an active profile can disconnect the machine.

## Security notes

Do not put a private key, key password, challenge password, AD password, SCEP URL, internal IP address, or certificate in Git. Use a local environment file with mode `600` and a certificate/key directory with mode `700`.

This project does not implement AD enrollment, SCEP enrollment, or RADIUS. Those steps are organization-specific and must be handled by approved enrollment tooling before running the profile configuration.
