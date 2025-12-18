class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.25.tar.gz"
  sha256 "1014e35373926b1e9c185951216bd625973949199732f2397d09b4277814b0b5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "1f7ea29cbae08e1bd977949e3adf28f2cd340effa08dac41f03059b4c5639100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28d54e85e9fd749b6ebb91abbf29420d9246880a3a5e4bba846e1ac1adb14cf4"
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
