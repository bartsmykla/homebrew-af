class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.27.tar.gz"
  sha256 "ce3a27247efae97a05ce44d65ea7ca3d406fd7dd4736e8f53f3a3460b4935131"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "547726c52094558c611404819d6e5d6b7ab4c80e22e258bb25f712dd11d144fa"
    sha256 cellar: :any,                 ventura:       "360323d6ea519df9cae2a554e6bc9649e4a9ff5cccb514ad7c9065ddf3fdfb99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6118ae659e6e431aa8638343625578d2274f427023335b900c60b3c2b9b06d8"
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
