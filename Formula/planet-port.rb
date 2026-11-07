class PlanetPort < Formula
  desc "Multi-planet ZeroTier client"
  homepage "https://github.com/planet-port/planet-port-desktop"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.5/planet-port-aarch64-apple-darwin.tar.xz"
      sha256 "8634be08fdb9a50901fc0c086898b1053477ed23ba60b77d69a268ea664d7c20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.5/planet-port-x86_64-apple-darwin.tar.xz"
      sha256 "868e7e3d3697d1bba6f8ec29d53834981407076cade93155d505935e238cc416"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.5/planet-port-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4905842f3e66bb6f984bac7025cfab680dbe025c1a2af6257b693181e310c3d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/planet-port/planet-port-desktop/releases/download/v0.3.5/planet-port-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f9b1e4c0650c7ababf720528acd2c06bad9c80b5958d5dca442b45b2bb757d7"
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
