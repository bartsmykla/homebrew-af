class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.17.tar.gz"
  sha256 "35e7ad0ff853ff4cf163e101b395c6baf7e14e37c014832f873a6494e0610390"
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
