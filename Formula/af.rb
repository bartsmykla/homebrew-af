class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.14.tar.gz"
  sha256 "eb7ad70f5e477af4820542af876e712f1427bb83f543fd40e6879f6f46ab868d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "088745c26a1831141d445d943756b48e670f340b17341a219a3921c24f1acce0"
    sha256 cellar: :any,                 ventura:       "1d895a615937387a710cd3fb0372b05b412e152763a5dab76013f26a25a67128"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "573b6343d80c4736c9695bc7683738a2e09c4143fb9dee047e8d6711ebc1b05a"
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
