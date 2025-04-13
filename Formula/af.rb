class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "26cc9d2f52853ed7b14269f2e8d20ae3592b1936292aedb841571f4fa49ce6d3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "d737febf6ba1db114788a88b7f39ddfe4cd71a2c0140338474d870d3a87a10bf"
    sha256 cellar: :any,                 ventura:       "79098cfe4f9042082ae99ba344ddbcf5bb09a6c4a16bae876b4ef49f8523d829"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7153ab1cf7c6ff27cc6ea81c5d991da8912e9080be68502dfd35455503de156"
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
