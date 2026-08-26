# Ubuntu 802.1X 初始化工具

本项目提供一份脱敏后的参考实现，使用 NetworkManager 和 EAP-TLS 为 Ubuntu 主机配置有线 802.1X。脚本采用保守策略：

- 默认只试运行，不修改系统；
- 必须显式传入 `--apply` 才会修改连接；
- 证书和凭据通过本地配置文件提供；
- 脚本不包含生产地址或敏感信息。

## 前置条件

- Ubuntu 22.04 or newer
- NetworkManager and `nmcli`
- 组织批准的 CA 证书、客户端证书和私钥
- RADIUS 服务器认可的证书身份
- 修改主机网络配置的管理员授权

## 使用方法

```bash
cp config/8021x.env.example /tmp/8021x.env
${EDITOR:-vi} /tmp/8021x.env

# Inspect prerequisites and planned changes
sudo ./scripts/bootstrap-8021x.sh --env-file /tmp/8021x.env

# Apply after reviewing the plan
sudo ./scripts/bootstrap-8021x.sh --env-file /tmp/8021x.env --apply
```

脚本会创建或更新 NetworkManager 连接并激活。修改当前连接可能导致主机断网，执行时应保留带外控制台。

## 安全说明

不要把私钥、私钥密码、质询密码、AD 密码、SCEP 地址、内网 IP 或证书提交到 Git。环境文件权限应为 `600`，证书和私钥目录权限建议为 `700`。

本项目不实现 AD 加域、SCEP 证书申请或 RADIUS 服务。这些流程与组织环境强相关，应先使用已批准的注册工具完成。
