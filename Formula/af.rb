class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.28.tar.gz"
  sha256 "e031f8bf4c13906aae56cf691ab5c030b6eb403b655bda40f06e81022da3f748"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "9071df11af79750b9d927a959a91484afde98d68df9c11424095c6318141fae2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5874cbb4bea746a8305e89e1d871d2b0c7cfbf0a4ab22d1886faa31f3f668e5c"
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
