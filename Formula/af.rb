class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.42.tar.gz"
  sha256 "407dc2bc406d8575b3686afe625da17a3f7515e00ee3a0a27843642545895573"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "2df86018e1a48b3fd0a269d826efe039f2850be19e8b633d1f4d65007c7afba0"
    sha256 cellar: :any,                 ventura:       "b9301a9b8ec219a01938525fd1d54dc761a19fc834a0e10cc8eb25ce22c221ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a58814fe6f0d23cf86b461ce2cdfb7c9912286349ad433e2f14ae6c0d663782"
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
