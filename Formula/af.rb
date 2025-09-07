class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.41.tar.gz"
  sha256 "f8e8dac2b3e71a75d3d1373d85fd87f4f4241c1627ba5888cfc1cd7bfafa5f83"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "1a6094ed61b562645017a29b9ab6d82166388030f33576fcbc928b0851866d9f"
    sha256 cellar: :any,                 ventura:       "814b4465b9d300a253e5ebb28ac9a122a26fef7510441cbbc90f20ad1b55e9c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b3e4dcd5b91d3f04d82937d707ecc3b71e54503666053d09390b77e1489c508"
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
