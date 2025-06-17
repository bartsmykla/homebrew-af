class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.10.tar.gz"
  sha256 "4e4e823297d687865e7605efac3b9f81853d1215f158f7dd9a3ac18ce96b4448"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ab13cba4aaccb13901ee0f2139433cca596ac6d943c34601343626190669abe6"
    sha256 cellar: :any,                 ventura:       "4e98627f3321e3e90459ab91a0902246f9fcb33f993395d5ebc5980e6b8b7900"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27ed99cb71e38c5b94e3e78da0eab5133641f480c03dc09cd6e84330de867228"
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
