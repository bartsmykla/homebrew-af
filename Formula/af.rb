class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.20.tar.gz"
  sha256 "e333412fbc821596f2cc4ef2e89514c42d16cd482e12d426897d21bb94464b69"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "72878d1184a5622e76b0bbbcbe30105ed974f8e0564a3d91fdffcba462e19e21"
    sha256 cellar: :any,                 ventura:       "0b1001b1a86e896566211e07f21bb19099f00fdabbe8c6251b49ee90feb8583b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "755a3a34e2d45ca8272b61b5382657cdd82fb0a21b355f74e441650df7e1efb8"
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
