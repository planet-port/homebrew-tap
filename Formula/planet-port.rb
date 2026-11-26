# homebrew 公式模板,由 release.yml 的 suite job 渲染后推送
# planet-port/homebrew-tap;dist 公式的 checksum 是套装注入前的,故模板化。
# 渲染规则:sed 注入版本号占位,envsubst 注入 REPO/TAG 与四个 SHA 占位。
# 两个禁忌:注释不能含美元符大括号(envsubst 连注释一起替换)、不能含版本
# 占位字面量(sed 全文替换),否则提交进 tap 的文件头注释失真。
# 套装归档已由 suite job 剥掉 dist 顶层目录平铺,bin.install 直接取根部。
class PlanetPort < Formula
  desc "Multi-planet ZeroTier client (cli + daemon suite)"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "bedd9a82d3360fac16db2864781cb850777cd5c4752bc9e533cf5c9840f29e57"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "acb1557fa63783116524ea6ff71679103799ab47f0155de8d0fd86d6b1e23749"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2deacee417bff38386681e44a7b8e35cf56665c39130be82a22ec2609ea07058"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e040bd6f12588fb4914eaa93270ab68c41be6a464c2a7c8fbd6ba21def11db8"
    end
  end

  def install
    bin.install "planet-port", "planet-portd"
  end

  def caveats
    <<~EOS
      首次使用：sudo planet-port install（安装 daemon 服务与 PATH 入口）
    EOS
  end
end
