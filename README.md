# Komuta 免费节点部署包（VLESS + WebSocket）

文件只有两个，缺一不可：
- `Dockerfile`
- `entrypoint.sh`

## 参数（已定好，不用改文件）
- 协议：VLESS + WebSocket，路径 `/ws`
- UUID（你的节点密钥，在 Komuta 里作为环境变量填，不要写进仓库）：
  `f3655275-e9a1-4275-b9d8-0f4eccc16cfc`
- 端口：Komuta 会注入 `PORT` 环境变量，程序自动监听，不要手动改。

## 步骤
1. 打开 https://console.komuta.io ，选「用 GitHub 登录」注册（注册和绑 GitHub 一步完成，不用绑卡）。
2. 在 GitHub 新建一个仓库（如 `my-node`，选 Public，仓库里不要放 UUID），
   把 `Dockerfile` 和 `entrypoint.sh` 两个文件上传到仓库根目录。
3. 回 Komuta 控制台：Apps → New App → 选这个仓库和 main 分支 → 区域选 de-east（德国）。
4. 配置页确认端口是 8080；套餐选免费档 dz-nano（Free）。
5. 环境变量加一条：名称 `UUID`，值填上面的 UUID，标记为 Secret。
6. 点 Deploy，等构建完成，把 Komuta 分配给服务的域名（如 `xxx.komuta.io` 之类）发给奶蛙，
   由奶蛙生成 Clash Verge 配置并验收。

## 注意
- 免费档闲置 30 分钟会休眠，下一次连接约 1 分钟唤醒，属正常现象。
- 这个 UUID 只你自己用，不要发给别人；泄露了就在 Komuta 里换一个新的并重新部署。
