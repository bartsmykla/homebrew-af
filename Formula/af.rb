class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "f59c69e4dbd6cd76d4b8875827cb403ffd07fc7a6a934d4bc9f2541cdf046a91"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "0d4fe3312bd8a4241f86239fd18ab2b590446025d7653c1c9a0d82a964a69205"
    sha256 cellar: :any,                 ventura:       "bc15583c6bbe16c77b4dfe826aecc83a0adbd0c3faf2254448e2010ba257e892"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbc98c4e167ba93b4b1d3e0df967e9ac69c9aa57f14e9ccc3b92142e78df9504"
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
