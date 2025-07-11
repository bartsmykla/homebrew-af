class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.19.tar.gz"
  sha256 "7f833705b9349d5553abd6477000420e3a7b186053222f56bb7f72f2e158223c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "64a638ccbf1ab11327dfca177866772f7786d59eea4b0ccce66d9d9e8a76092e"
    sha256 cellar: :any,                 ventura:       "e68c02c33cc16e7a4e5a17709d7bde714f1c42308da40d7c38ed8ab957d789fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fddb871a203c95c818054cfb8bcf1002ef8c417485a28eb71b89b5f3aea7242"
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
