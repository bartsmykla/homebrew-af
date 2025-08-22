class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.36.tar.gz"
  sha256 "ad90ebbccda6f86cc54df34a91bfce895cb0fa6d9c2935d58a2c6a3737f31a14"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "3f913cfe63a9ac1ac84c626d13af5b8e82bc1cea963898ad0ac6928067c09f69"
    sha256 cellar: :any,                 ventura:       "09340136a54c2fde2a12eb809930fd5be949ea300336080abf5c1a3dbbbbcfb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2e1162a3810238db2571bf01786b9f287f4adca7ca015b9e8b05f9dbb43e1962"
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
