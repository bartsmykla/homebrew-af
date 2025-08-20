class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.34.tar.gz"
  sha256 "753ad2a20eb156fde1f988d6043aa2ec5499392a9885056b1ba229de78565965"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "d00622b97103d14019f7aa81a3109431934fec3e0b32cff5080235ce74bc2589"
    sha256 cellar: :any,                 ventura:       "908a54edfa45a547094fddc4e3ff9a7fb3729df31708fbc22ae4c5edfaa40bb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18c49ac77fb38e61aa810ffec52c52e0f720084d6a7dff883a06e258e384f661"
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
