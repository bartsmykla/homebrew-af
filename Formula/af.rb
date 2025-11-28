class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "5de8c46bf477e104dc271f51c1ecbbada1e3693ac63d3a86d8720893ebd8f130"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "c673d27299fa531aa6f4d9858c9970022595677159aeba23592a26a83e6f8bbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a26fdc1d3329be5f4b67ab5b1f880124318a65a38ea50635949f46ecc73888a"
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
