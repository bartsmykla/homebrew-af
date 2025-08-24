class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.37.tar.gz"
  sha256 "052b1c6a2c0af79864d53e44dad28b27261ba4741cf61cefaf002db81dab37df"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "fc2983ab2063dcb02a0e1b906e79f141a15a9849e5dd98da002bb136ca1ac90f"
    sha256 cellar: :any,                 ventura:       "97d05585f42b732877d395d2f0ebf07e8722305a34ff23db34ee7e5e9112a6b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb9c9a27e2056400f7226de4dde2835cdd8d2b22a90f7386c2150cc7c78825ea"
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
