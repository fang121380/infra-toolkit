# 实用基础设施工具集

本仓库收录从实际基础设施工作中沉淀出来的小型工具。每个项目均可独立使用，并以占位符替代组织内部配置。

## 项目

| 项目 | 用途 | 平台 |
| --- | --- | --- |
| [`jumpserver-ssh-toolkit`](projects/jumpserver-ssh-toolkit) | JumpServer 类网关的 SSH 配置模板与连接检查 | macOS、Linux |
| [`ubuntu-8021x-bootstrap`](projects/ubuntu-8021x-bootstrap) | 基于 NetworkManager 的有线 802.1X/EAP-TLS 安全配置 | Ubuntu 22.04+ |

Android 应用单独维护在 [`hamster-pet-android`](https://github.com/fang121380/hamster-pet-android)，避免把移动端工程、音频和精灵图资源混入运维工具集合。

## 安全与隐私

- 项目不包含生产凭据、私钥、证书、内部主机名或公司内网地址。
- 使用前必须替换所有标记为 `CHANGE_ME` 的值。
- 应用变更前先阅读项目文档，并运行默认的检查或试运行模式。
- 不要提交 `.env`、私钥、客户端证书或质询密码。

## 许可证

采用 MIT 许可证，详见 [LICENSE](LICENSE)。
