class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.11.tar.gz"
  sha256 "6cbf374626ea6d82724be615ae98665419e972be3683716a20a71383388ca110"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "e74fa798b0a265347eb0b23cf4b5cad15b990a7601858f61189cbbd8920aa7c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82b282497de00d8cb4d05f5b552f4e969db0b2d086bd2d9ec7a2be786e9a3ad2"
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
