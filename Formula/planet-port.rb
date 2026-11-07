class PlanetPort < Formula
  desc "Multi-planet ZeroTier client"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.2/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "402492ac973971a7ac88f38d315259e05cd2a903a8f5dfda4caada41fd2bd399"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.2/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "e32619e317862fa6738ed0f6a2fbf30b8edc262903a68ad0543732cbda449848"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.2/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e9793ee6d0718fcf77dc884622dc59f1b67e57d2c903164bd06ae647e138712a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.2/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e6cd0ab57f3d6770177d3b3a3f15ffa2cb9bf980c1f2483717cf8761c609532"
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
