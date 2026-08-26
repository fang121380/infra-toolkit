# 运维检查清单

## 应用前

- 确认交换机端口的 EAP 方法及后备 VLAN 行为符合预期。
- 确认 RADIUS 服务器使用 EAP-TLS，并核对身份格式。
- 验证证书链和私钥权限。
- 保留本地控制台，以便连接中断时恢复。
- 在接入 PXE 或批量部署前，先在一台非生产主机上验证。

## 应用后

```bash
nmcli connection show --active
nmcli -f GENERAL,802-1X connection show corp-wired-8021x
journalctl -u NetworkManager --since -10m
```

成功获取 DHCP 地址不能单独证明 802.1X 策略正确。应检查交换机和 RADIUS 日志，确认 EAP-TLS 已接受且 VLAN 符合预期。

## 回滚

使用 `nmcli connection show` 列出连接。先重新激活原连接，确认网络恢复后，再删除本工具创建的连接：

```bash
sudo nmcli connection up '<previous-profile>'
sudo nmcli connection delete corp-wired-8021x
```
