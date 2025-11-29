class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.4.tar.gz"
  sha256 "ced14ab5f8fb85e95a27f2811dce03cade23d648609307663f452efb56f02728"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "80b902f265bde299fc5f3695084c15775328a1832976a00a0e33c7babcf49ef7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f10d940eb7adb3e224c1a6b8167c1759dc9f69ff566c90550bdbf05f55867036"
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
