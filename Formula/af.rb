class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.49.tar.gz"
  sha256 "b1e5f7006b634933d642ab95c4d75733864c974e90a689ce293ecf226a3d1009"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "4300172f7d9b4b65867c7ae38d15b3618632d9652717858799ffac5ee46c9dde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d47494d8e4edf1da84c4751fdee2cfc186183cda459a9c7e112a9bb3283d1fe5"
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
