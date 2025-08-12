class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.29.tar.gz"
  sha256 "8a609ec082972eef144b0036858636574af59c94da895b575001363c5414d562"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "e46f87c52376b12550c71d4cbc1308de841c5565b3629410d46d374369dc1123"
    sha256 cellar: :any,                 ventura:       "2f24749d3b2a13886075d5952451a91c04f921c4568d2daf2cd30d60da27e45a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2564551ea43bb3c7e49217e13a3fca563d852339c0288f44c111ce455d9cc081"
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
