class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "5c3cea5f65a570af1a8322634fa03f2f96cd824fb9272d6fb283e05ddbd935b6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ab74ab7eb6f2fbb440958d975e6e6272580b48de220358705bf7287803b96b5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "666645f8d6beb3d4faa76b850a6c1a710422b2b708c7c2adff94da41d4e759d0"
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
