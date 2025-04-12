class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.16.tar.gz"
  sha256 "fa1d19eeb0018a77d568ead548a3f9701755cad0910cb829acbcdbb578501b2e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "31a5ec992b00e5f184966f84716e7e3d7f88625eff46369ecc2c933a79585e61"
    sha256 cellar: :any,                 ventura:       "85508d3e81cf73162c9faa1ce720938c10ec1f3b9c3ea6cfd66442c189e00d21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b0ba9b388b6cf9bd6c0fdae05b44a48b8c5106fe2adc43e6cb28529af620e19"
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
