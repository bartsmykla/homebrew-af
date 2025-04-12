class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.16.tar.gz"
  sha256 "fa1d19eeb0018a77d568ead548a3f9701755cad0910cb829acbcdbb578501b2e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "66fc0045de298f1af7acd0c97d66298d0985b560be3084556edff4bd58fa5a69"
    sha256 cellar: :any,                 ventura:       "57c9b527db4cc035af059679196440761818768d9de81de932b1909a3f5e92bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fed05c356f6c907b0eb4f12a8928b37c43392ae895e85c42c32658d6e327f7b"
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
