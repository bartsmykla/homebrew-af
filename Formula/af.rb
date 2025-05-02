class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "f5e2cc8981beaad981a47071afbaca39cf9757104af340096bcee3950393c2a1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "2db6f35eb733caa53b55f27b64afec6a71c67f07d9bc5f481b3b746007a62f66"
    sha256 cellar: :any,                 ventura:       "605bd18963963b3b50b9a27b89ffbf1acf787b86376334b24c01a32b33edf02c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72230cead2ce1d1faa34f48d95781e2750dc12e59f9e2fe4a2320c06f9015fd7"
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
