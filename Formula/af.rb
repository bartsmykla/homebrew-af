class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "f59c69e4dbd6cd76d4b8875827cb403ffd07fc7a6a934d4bc9f2541cdf046a91"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "42a360f98b7c0659a3f4b9681dd3b6c0333121e1f1824315799c504e2d88004f"
    sha256 cellar: :any,                 ventura:       "fb30cc0989316540b6c55a66243472de946de8c230cc27f0edf233d2e322b63a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1427dc1fb1c4dfbe29056175323d34dbf3b736d74c4102f0a2b95855f0f7339e"
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
