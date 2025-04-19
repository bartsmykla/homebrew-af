class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "b605ef118c18f825bb5d794e14c91b47ca5f0bc8e479b97cd5b3b0624335869e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "eda2a77f95c2b022cde3c87e9e1557b6b8bbef36a84ce85d7dcaa62868fef43e"
    sha256 cellar: :any,                 ventura:       "ff3e3c12187b5d03d54521119592e4cc78b236cedc9881cc42f651a4a1b1e3b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2805c7a38ee6f248e9d13ac0b64f48018f1394591209c178da4b730ffce16ce"
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
