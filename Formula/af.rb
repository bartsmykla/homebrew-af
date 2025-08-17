class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.32.tar.gz"
  sha256 "e47b89cf1309313def85b51967fe8d752ed15746e49584f58601e33bae46e0b6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "7635325d2d03432a4730120c6dc9b1f7d7392e1ecc2a0efd5bc8b3b0b8eafa00"
    sha256 cellar: :any,                 ventura:       "b9751023896818a5fcfbe63bb4c34d1dc343bbd9592be427662d073078d04ca9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0bdbd4a281de83f9c03b55c658e9789a0c4b68a3774f9fd373078618b6c954f"
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
