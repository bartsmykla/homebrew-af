class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.14.tar.gz"
  sha256 "eb7ad70f5e477af4820542af876e712f1427bb83f543fd40e6879f6f46ab868d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "1d30d69386f328271f29f8bc4ba76a5bd2adc18181dc42043500bf14ef820cae"
    sha256 cellar: :any,                 ventura:       "0baa7561af41be67bbb3c9f3bf543bfecb0cb59697fd86bc36a4d8174faba9b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f234610dd19d9684a683bce0d1a0038f47eee31c186813c31ac3eb4b530e8813"
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
