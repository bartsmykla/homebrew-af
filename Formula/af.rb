class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.8.tar.gz"
  sha256 "11c0f900996890a4c8c8d3b47cc0132c7031d8388971b8ada4650a49deef052a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "d31c96e4a0d2331124a89fc16f320d3211c4bbe0e95b76f518e733f24ff2aafe"
    sha256 cellar: :any,                 ventura:       "4c5ea26391cea73c475728fbad00e83e849fd00a21d9503523f2ffc535708c76"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba41f46d80b1376cae59427806a5e8bdc5772976a126b98c7a61759a726f66a8"
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
