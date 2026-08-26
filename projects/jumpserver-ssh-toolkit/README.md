# JumpServer SSH 工具集

通过 JumpServer 类 SSH 网关连接服务器和网络设备的可复用配置。工具使用标准 OpenSSH，适用于 macOS 终端、iTerm2、Linux Shell、VS Code Remote SSH，以及支持 `ssh` 的自动化工具。

## 快速开始

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

## 身份认证

使用已登记到 JumpServer 账户的 SSH 公钥。不要把私钥、密码、动态验证码或质询值放入仓库。`IdentityFile` 应指向本机私钥，文件权限应为 `600`。

## 网关用户名格式

部分部署会把资产身份编码到 SSH 用户名中：

```text
<domain-user>@<asset-user>@<asset-address>@<gateway-host>
```

具体格式因部署而异。使用示例前，应向管理员确认字段顺序和 SSH 端口。
