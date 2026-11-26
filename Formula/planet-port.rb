# homebrew 公式模板,由 release.yml 的 suite job 渲染后推送
# planet-port/homebrew-tap;dist 公式的 checksum 是套装注入前的,故模板化。
# 渲染规则:sed 注入版本号占位,envsubst 注入 REPO/TAG 与四个 SHA 占位。
# 两个禁忌:注释不能含美元符大括号(envsubst 连注释一起替换)、不能含版本
# 占位字面量(sed 全文替换),否则提交进 tap 的文件头注释失真。
# 套装归档已由 suite job 剥掉 dist 顶层目录平铺,bin.install 直接取根部。
class PlanetPort < Formula
  desc "Multi-planet ZeroTier client (cli + daemon suite)"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.6.0-beta.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0-beta.1/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "28fff6fcf850a73c74dadc0aa1a87329f39e2a3c7f0e1cc87d0a0f8372362f1e"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0-beta.1/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "4760af370efb5aed8f5f8640c367d4d07a90ce74d9144bbd40f6f26b28e142e5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0-beta.1/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b390064d87da7937bc953de9f03a133d31cce7727c64c263af8e2ddc0f11aea"
    else
      url "https://github.com/planet-port/planet-port-desktop/releases/download/planet-port/v0.6.0-beta.1/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28ee6787c3b9f29f49b9d0031b1c7be5dbcb5bd30f927116115af18d6deef351"
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
