class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.61.tar.gz"
  sha256 "38fe69342072b8614493a4d2fca1ec0b89a08e12a2365c503d95f8db452f37ba"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "262f465f8a06fa740f9088d7c33921e82c859fa78dafa63bece2c2a29716b302"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d74294f6fbe981d5a36a68fe82c63ee5691b2b1f0465c27ef5c0d0fa239fa4e2"
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
