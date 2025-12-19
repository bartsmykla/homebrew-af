class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.26.tar.gz"
  sha256 "3056ad8765a5f38e161e2cd0a171ed256d3522dbae951778c58de19caa7d1e00"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "84141ec37c0c496e8aa770ae13e84b5e4e7ef7cf9aace516313243a600055665"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a4b22a7a7cc81d33fc5b70aabc4c57f3ae1b86207ed6b7ceb3d110c80b3bfbe"
  end

  depends_on "rust" => :build
  depends_on "openssl"
  depends_on "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin / "af", "completions")

    system "cargo", "genman"
    man1.install Dir["docs/man/man1/*.1"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/af --version")
  end
end
