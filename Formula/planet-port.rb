# homebrew 公式模板,由 release.yml 的 suite job 渲染后推送
# planet-port/homebrew-tap;dist 公式的 checksum 是套装注入前的,故模板化。
# 渲染规则:sed 注入版本号占位,envsubst 注入 REPO/TAG 与四个 SHA 占位。
# 两个禁忌:注释不能含美元符大括号(envsubst 连注释一起替换)、不能含版本
# 占位字面量(sed 全文替换),否则提交进 tap 的文件头注释失真。
# 套装归档已由 suite job 剥掉 dist 顶层目录平铺,bin.install 直接取根部。
class PlanetPort < Formula
  desc "Multi-planet ZeroTier client (cli + daemon suite)"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.7.0/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "e1f5975d4a92b4c8f4177b6347cb02cbcb7cdc84f8d892a5a3992c2f38e32f57"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.7.0/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "429e76b11a888d6aea19adaf59e8df6faa4be5d67178f91a24c8a4561a0420c1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.7.0/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6e8ed9e2a2aa47786d51a3f0fc38afb5e8a98756d5e96cb8da3fda2b95a41346"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.7.0/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "568695bacebd140f63bbdf661078fa47036f45a962187bc668648301c7f94bd2"
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
