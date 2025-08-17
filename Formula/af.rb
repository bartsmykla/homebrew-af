class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.32.tar.gz"
  sha256 "e47b89cf1309313def85b51967fe8d752ed15746e49584f58601e33bae46e0b6"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "88272cd85e82dafaddc1c5ed42a7cda2ffc8b4de9096083a01e10477465c9b96"
    sha256 cellar: :any,                 ventura:       "fa5dca0ca4553f3653c1a9c270817c2a2a38ec3a2159d9e51482e285c620a51a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72b724ef8273b0cfcda5dec69c464c13eb7a83d518d2b7a4bcb795ef6c275984"
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
