class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "d4dd2ac0e2878311b977c7f37f6b4daf22a2ed046c51b0f90bfedde88bdfd5e3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "fe3260d8b4a41c1787fc48596301d9228b4ef81a64d9d204eeacfd194543f29a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45cefde7467d082d843a8db7fcb0e868b19399fa28b56ee79ee9190b1476a470"
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
