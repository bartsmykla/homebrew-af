class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.38.tar.gz"
  sha256 "27bb317c3d440363fa64f35bf907036e14d200d790c0027f5ef57fa7814bfa59"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "fb24a5e31cba6f72d4cab71535f4ee4e360f6693f71570c1d25b0968f46d1ffb"
    sha256 cellar: :any,                 ventura:       "17c03beb3c68e6b307d731edd3ab28ce960d390b7113e054e222be7db68c4103"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "abf51f4234b671cf041958c711c5322492d8841b6ab4ca6743034660d5c38dab"
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
