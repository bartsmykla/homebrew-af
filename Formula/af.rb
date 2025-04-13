class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "26cc9d2f52853ed7b14269f2e8d20ae3592b1936292aedb841571f4fa49ce6d3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "978e067fc02b3513adda658a8027ff0b59723da21cf53b3f3b802770e1504a5a"
    sha256 cellar: :any,                 ventura:       "bd24e7d0f0c970061a14f8a3383d153e4e642842b51d8c8b2918e635b6fcbc41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c1d40e3bf6df0fb17a038ea8775ef41f04bbfcddf36797c6422d2b5e50a2682"
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
