# Troubleshooting

## `Permission denied (publickey)`

- Confirm the public key is registered in the gateway account.
- Confirm `IdentityFile` points to the matching private key.
- Run `chmod 600 ~/.ssh/id_ed25519`.
- Use `ssh -vv server-01` and check which key OpenSSH offers. Do not paste a full debug log into a public issue if it contains hostnames or usernames.

## The gateway rejects the username

The compound username format is controlled by the gateway deployment. Verify the order of the domain account, asset account, asset address, and gateway host with the administrator. Do not guess by repeatedly attempting production logins.

## VS Code Remote SSH

Use the same alias (`server-01`) in VS Code. Network devices generally are not suitable for Remote SSH because they do not run an SSH server environment compatible with the VS Code server.
