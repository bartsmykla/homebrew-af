class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.4.tar.gz"
  sha256 "0d8d51819611b0713044d954fbd04c4e8006cdeade8d687e1fb17f163ae304b4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "07f5936c584d8bac0ee64c40987c13de3a72c94eda85c9c48b72072611f496bd"
    sha256 cellar: :any,                 ventura:       "eb20646a814faf9b893c59aec5a3bc13a007521a20edf6b308cb20d7d88c4ef4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47a34a163b0c187314f048d5323a277ad87d612d378c39b391a67a7eead93238"
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
