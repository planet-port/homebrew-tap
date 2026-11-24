class PlanetPort < Formula
  desc "Multi-planet ZeroTier client"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.5.0-beta.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0-beta.1/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "5df34bd332493e9e02a8d1864c78ddd5976f9eff8ac1eb4ceac5abebf5ba2492"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0-beta.1/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "2426d04eaab1a395c158ff0e299f304a166324ea6fde089677537cb9c5969ae8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0-beta.1/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2086340ecd1a90e4af0077f2797d7c554972a3779f7c17aee62b2ee9484bc7f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.5.0-beta.1/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a12ee5188322109df8703f34cbd9cd6c1b6a702fc13fdbac556e46b54f7b202"
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
