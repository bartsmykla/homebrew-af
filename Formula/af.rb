class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.55.tar.gz"
  sha256 "b387028742bab34d1c89c70fc22d4b9ac565d278a6d281620ef2bfe6c5f542d7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "61e2b449cf87c78358508343a9bce65e1dfcd23285a89143d6f44c9892f55b0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a871efba4e72a546d2d5ca815254866002ad307349d049ce6d26004cd7382fa"
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
