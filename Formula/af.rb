class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.10.tar.gz"
  sha256 "76b500041a8fe1d5b2f2cfc2350187441ac87c7d6a9458be3fe84a0bece2cc5c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "4c5a48d85318fd34185f1c9d390eb5e721736967f825c8c1907ce30b9a756195"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3926c34acc93e398f24c23e04106a7badcc0aeb103f0cd4792daab3c5e926531"
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
