class PlanetPort < Formula
  desc "Multi-planet ZeroTier client"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "c42fd943aac55a7fd165c01b4dea2f1180eff6522e91f73f3220fe43f822669b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "2d5fced04bb44f5ad30223aeb9b7cc0d22c5f4a5c757a91620b8730a99d8b98c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "510869721b94403e3c7e8eceba656b298b88c5b241280f9cd9f5ebbc1421a3ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f9080e454e953c466de0eabcc08641943c23dff8d5fa93143faa575ec9a5e153"
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
