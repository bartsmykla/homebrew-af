class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "7434fc6b1bb4c927fdf7c8412fa8738149e1ee7b054062ca373b5c882629c358"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "7ca3fdb7cca8c6cb26ba21928a4544f2807e2c139375c61ddd635c9c036767d1"
    sha256 cellar: :any,                 ventura:       "31c087bca3cb845824eadec2c970ee5fa44fcd86d84232d298a20af2a1f2696b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f93708a765e3e10f79483a7081b3146c5a2f3485a003ee1f37befbd94cb327a"
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
