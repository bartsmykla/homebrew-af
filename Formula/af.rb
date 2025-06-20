class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.11.tar.gz"
  sha256 "b632a71df8e7e6b3611934ce467e903d9b0379c7d896c62523fff6d0618faf6f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "a50421be8c0e3c727a39c2c90b305faffa45034ec956df56dafb43d4640ab4cb"
    sha256 cellar: :any,                 ventura:       "8037e20500e998ccace47563fff90b42c858d72935b8b6f37c604b544c5256c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b636dc56c78d3bac0d247286cefddc3d1db6fc348b37f63ba00938563733fa7"
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
