class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.5.tar.gz"
  sha256 "cac4896ebefb025a5f25f33f87667dac1fa5be7f77f5c4b8e82a1576f5ad5484"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ac99a716afd6606c7db1fe3961991126aa6d183f4011a5c1feedc88cdec4d822"
    sha256 cellar: :any,                 ventura:       "30560caa4cb7af407704937b87ed2d521033b73b79f1e7624164ff2cb505a68a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b03b15f96c2653c4be94f272a10e1fe3ca60ce6057c6877620f621c1ae09ea19"
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
