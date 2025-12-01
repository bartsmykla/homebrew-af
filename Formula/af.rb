class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "d4dd2ac0e2878311b977c7f37f6b4daf22a2ed046c51b0f90bfedde88bdfd5e3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "515e0b4995d11555ee162f44072b5865b3fbf4639b6938128cd79624a92380b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f97c7fd792d80ac75c3fb944a5cb0616382ce0bb0cb5701ed663764db649cb59"
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
