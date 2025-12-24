class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.31.tar.gz"
  sha256 "a7a05151d8bbb8e61e6a79eae73e64db02e790c3cd0e12f575797c1b20586533"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "1d20cf751526490f7c8e0a7293741d9f222e40ee0c8daae7a09174eaeefcef47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cc1af1abe6f0552564c42de9fadcb4c19c895d30da14d846efd394e1714b5f7"
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
