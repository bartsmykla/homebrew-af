class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.34.tar.gz"
  sha256 "753ad2a20eb156fde1f988d6043aa2ec5499392a9885056b1ba229de78565965"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "bd95595a96ea94c803556a2ae9b81c49cc48dc9c26906e04757f4019f34f23dd"
    sha256 cellar: :any,                 ventura:       "1b06171cb257283d7c01c8c35112bd2f866f79919218f45e93ef0801e2f4222f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0786275441798fa0d787879e1b214133f0edd0cfef5c449f81f0206db2a21033"
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
