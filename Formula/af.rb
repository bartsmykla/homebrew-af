class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.11.tar.gz"
  sha256 "b632a71df8e7e6b3611934ce467e903d9b0379c7d896c62523fff6d0618faf6f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "7b5f1817261685fed47c30da05d633f9688ea8341c403f235333cf8b188a8008"
    sha256 cellar: :any,                 ventura:       "21ea5df02f74eb158301964c1d1a9cf912b2281f0ff8af6ff217e2c741243a3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2806178266b37c492f5155174027df67802fb56d87d29899fdd045ca72046785"
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
