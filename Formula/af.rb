class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "eee1d403bdbd986f9ff2eeb5fd290a7768292243296a3b15cfe8d495dbb3c39c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "a7d923f13e671cbe553550b1d53303bd100a6e913674991fe64fccebcd0b1d64"
    sha256 cellar: :any,                 ventura:       "4954bb2c6ae27bc5d5c19f4712626900bcf07554b2a209325b02deea69296d8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "213769308cdd669f0db2a7dc8f81535e7e0205239f93c4e571b45861f89116fd"
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
