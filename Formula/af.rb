class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "f5e2cc8981beaad981a47071afbaca39cf9757104af340096bcee3950393c2a1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "91ccb04348bf1565804cd0d271d6354564e13fedfabda6ac1dd958718fad30d5"
    sha256 cellar: :any,                 ventura:       "6565eb4939503da08f4bc1b3e75c7de1efa8ad6dbffe7c088c2132a4149fdb8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fda95cf4dd477957418cfcf49b422fc12b9dbb5928c0b415c9dd8c650d167ac"
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
