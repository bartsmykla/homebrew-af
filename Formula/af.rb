class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.57.tar.gz"
  sha256 "7512c39f4ad00b4324bf35a8d7e51fecd7bb0f1cea5a260d5a322f12eca8fd1b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "45a3ee548f2b9ab0aaed1cb0c29897b8e85b692b1053986a74d94cecbf83f5f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e24532cdfd64f8c2a42d3a3f23b593cf380ad0451b87974b58782a28cf50bc1d"
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
