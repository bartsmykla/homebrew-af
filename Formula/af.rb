class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.5.tar.gz"
  sha256 "301ab98f8815c5b68f07107200144127e25e3ea7b71ddce6457595da86ebd714"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ba8d47a25e387f6d0d7f719a58f3148d48e447e10f3210e3fd7e092a7e3bf1c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "094e66756c9be219f3f2294dc0be094240857333e1ee7a7bfa04a5f351d41c4d"
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
