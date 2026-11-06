# planet-port/homebrew-tap

Planet Port 的 Homebrew tap。formula 由 cargo-dist 在每次发版时自动提交，请勿手工修改 `Formula/`。

## 安装

```bash
brew install planet-port/tap/planet-port
sudo planet-port install   # 安装 launchd(macOS)/systemd(Linux) 服务并启动
```

## 升级

```bash
brew upgrade planet-port
sudo planet-port install   # 服务不变，daemon 重启后按期望状态自动恢复 planet
```

## 说明

- Planet Port 是社区驱动的非官方 ZeroTier 客户端，与 ZeroTier, Inc. 无隶属关系。
- 上游仓库：https://github.com/planet-port/planet-port-desktop
