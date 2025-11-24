class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.68.tar.gz"
  sha256 "7363bc760d78165238da90a78d296b3b58d857a2bbe695745ebb17b4c6273bb3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "299cd61850b68caf1cc97296d0689d0bbb10a74dcb2ac486202a7ce38ff83019"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3a4cc0816932f538ef428e8950521f8992f9abf68a44fd748e9c757d3e2efff"
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
