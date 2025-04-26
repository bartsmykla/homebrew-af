class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "7434fc6b1bb4c927fdf7c8412fa8738149e1ee7b054062ca373b5c882629c358"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "c5d7ca8d4fefa14a628b4da25f68cb972980abc2523dc6a52209ec2275bc888a"
    sha256 cellar: :any,                 ventura:       "e8eee733a1f758de0fca87a00166e02be99e5b816b692bf1da1cef8458809f42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6741d0112260d6f8c7f076e7bdf93bf984c4b80bf0b4981a2e013448be4bb0c"
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
