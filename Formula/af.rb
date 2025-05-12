class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.3.tar.gz"
  sha256 "71f4e237ab57a28f96fd129ab1c97db44cff56002edeb5f7145f52dabb714f7e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "1a4d05cbeedabfdffab52ffc407be91f97a4923795bcff5dc2803c8f714987bb"
    sha256 cellar: :any,                 ventura:       "c11653a03201933c2f2f8ceecfa501825bddd580d84e066f43fdf9a0ee3be33f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d481f351bcf17d4d7a2abb8d1d2105a67c72ee898188c8901dea72451da3e6fd"
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
