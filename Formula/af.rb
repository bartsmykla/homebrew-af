class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.34.tar.gz"
  sha256 "1f70c36908ab6f5b2cba06bf463503274ec1863b6dc2fa0b8cd25582c84d0831"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "7aa53d0aef76c02108af2ace08d37177b7a29941dafa562337b1797bf06e8530"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d8ffd01acb92ae538d7e2ff9645736fe1b378c028bf6688fc14ca5fabeba5aa"
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
