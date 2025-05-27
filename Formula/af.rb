class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.6.tar.gz"
  sha256 "325520086ca7f03f82c51fe3bd525d37f84c6806cc4691491b43f2317c3f0af2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "d63090f28ffc724de1d11f2e737f0947960d61b11c71260ad25674d976cc8cd9"
    sha256 cellar: :any,                 ventura:       "8c1d7fc94c26804ddbeff38fa8afa990743f95e593853aa5c293dff6467b42f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4510622f2eca64d8498a589103c1c5cbf1d431c6ebfb5e1e3e2896c2a7c5ade3"
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
