# Practical Infrastructure Toolkits

This repository collects small, reviewable tools that came out of real infrastructure work. Each project is self-contained and uses placeholders for organization-specific values.

## Projects

| Project | Purpose | Platform |
| --- | --- | --- |
| [`jumpserver-ssh-toolkit`](projects/jumpserver-ssh-toolkit) | Repeatable SSH profiles and connection checks for JumpServer-style gateways | macOS, Linux |
| [`ubuntu-8021x-bootstrap`](projects/ubuntu-8021x-bootstrap) | Safe, reviewable NetworkManager setup for wired 802.1X/EAP-TLS | Ubuntu 22.04+ |

## Safety and privacy

- These projects contain no production credentials, private keys, certificates, internal hostnames, or company network addresses.
- Replace every value marked `CHANGE_ME` before use.
- Read the project documentation and run the default dry-run/check mode before applying changes.
- Do not commit `.env` files, private keys, client certificates, or challenge passwords.

## License

MIT. See [LICENSE](LICENSE).
