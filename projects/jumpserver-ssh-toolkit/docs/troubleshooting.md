# 故障排查

## `Permission denied (publickey)`

- 确认公钥已登记到网关账户。
- 确认 `IdentityFile` 指向匹配的私钥。
- 执行 `chmod 600 ~/.ssh/id_ed25519`。
- 使用 `ssh -vv server-01` 检查 OpenSSH 提交了哪把密钥。若日志包含主机名或用户名，不要将完整日志粘贴到公开议题。

## 网关拒绝用户名

复合用户名格式由网关部署决定。请向管理员确认域账户、资产账户、资产地址和网关主机的顺序，不要在生产环境中反复猜测登录格式。

## VS Code Remote SSH

在 VS Code 中使用同一个别名（`server-01`）。交换机和路由器通常无法运行 VS Code Server，因此不适合使用 Remote SSH。
