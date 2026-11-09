class PlanetPort < Formula
  desc "Multi-planet ZeroTier client"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.4.0-beta.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.4.0-beta.1/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "0ae9033e0bbb9cddc1106ea92a91e6adaf339677d071cba151f5c600d5851f72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.4.0-beta.1/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "7f19c45fac45977dd45136b86ce96d4efd7c2fc2be34ebc5fb20d50fad453148"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.4.0-beta.1/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2e482bf2fa90f77085a6d643c51e218cca8a0953919b75c05237f1488f53b1e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.4.0-beta.1/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "901bef904884526a6f843c605f2f44747ee1d42b4dea283e07bd095622656189"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "planet-port", "planet-portd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "planet-port", "planet-portd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "planet-port", "planet-portd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "planet-port", "planet-portd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
