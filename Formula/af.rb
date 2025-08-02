class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.26.tar.gz"
  sha256 "516035f885cfd10e72befeabdd86b0301e07f0cfea6f0dc6736613394592d49f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "c2a6629cd54ffe1f60836d2abebfcca6031f6b4432bb8f39b3d778684c0d57c6"
    sha256 cellar: :any,                 ventura:       "f11a97f731b84e4494310f3026b6979008aa98d5ee290aed190c50b4857b1612"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c37b1544f7c1117e3694fd7fe52f2796f08a171479ff4e6ec9f48969ce459bfc"
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
