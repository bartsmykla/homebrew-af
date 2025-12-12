class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.17.tar.gz"
  sha256 "f19d8b009465f82eb48ab3caca6b122ad88adbcd21bab99053b10f4b9a732764"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "9d29f7d5e2b5a71bcb365f2e1735cf69f4dd0c67f869e1dd023da5c6b94a20ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f64e50ec61dfbbd697a2563151571b99dd29d1f23d981b1a2212f6fd3302019"
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
