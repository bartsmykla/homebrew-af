class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.65.tar.gz"
  sha256 "48c158984a47f176c1f88acdea3811a5266349300d01715b0ebc9a38e64b0279"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "b2c92e9ef9c6ec69c9c7ad5863aac4107f7224c6c2b5c75a15df3228604728d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c57ef473f11e4099010fc9475286049b95cc300526aa4a0a3425ca71b389811"
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
