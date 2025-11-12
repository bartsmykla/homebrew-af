class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.64.tar.gz"
  sha256 "6eedb1db7c649b01c69be62a09677891290f37f08db68e500e41393f0147b55c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ead21a44d8f7a2e096e620326513c7e4ed0be1634da9b5fe41b5bdc177c890ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f847c420fda96a5a977a01b539683cf5eed369ac482d620c46c36d53b9a62e3a"
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
