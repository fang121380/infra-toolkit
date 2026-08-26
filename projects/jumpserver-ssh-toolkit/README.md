# JumpServer SSH Toolkit

Reusable SSH profiles for connecting to servers and network devices through a JumpServer-style SSH gateway. The toolkit uses standard OpenSSH, so it works with macOS Terminal, iTerm2, Linux shells, VS Code Remote SSH, and automation that already supports `ssh`.

## Quick start

1. Copy [`config/ssh_config.example`](config/ssh_config.example) to `~/.ssh/config.d/jumpserver.conf`.
2. Replace the example gateway, account, asset username, and asset address values.
3. Restrict the file permissions:

   ```bash
   chmod 600 ~/.ssh/config.d/jumpserver.conf
   ```

4. Validate the profile without connecting:

   ```bash
   ./scripts/check-ssh-config.sh ~/.ssh/config.d/jumpserver.conf
   ```

5. Connect with an alias:

   ```bash
   ssh server-01
   ssh switch-01
   ```

## Authentication

Use an SSH key that has been registered in your JumpServer account. Never place a private key, password, one-time code, or challenge value in this repository. `IdentityFile` should point to a local private key with permissions `600`.

## Gateway username model

Some deployments encode asset identity in the SSH username:

```text
<domain-user>@<asset-user>@<asset-address>@<gateway-host>
```

This is deployment-specific. Confirm the exact syntax and port with your administrator before using the example.
