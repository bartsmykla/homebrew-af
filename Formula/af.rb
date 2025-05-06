class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "3b5a202366ede3e64672a56cb3841a23d1375dca376bfe103cf27c225caaa064"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "608d10e415e790e9ac11fb922a001067ed9c9b43f4b00e83b1cd4709d64fe09a"
    sha256 cellar: :any,                 ventura:       "7ba748651278938e026fac93144272c5018facddf5bafef2eff0196e91dae1d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "484e0abe05a94297ea76b148c652b9be77307d44bf458d9119dfa7bdbab5d07a"
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
