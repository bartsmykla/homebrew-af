class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.32.tar.gz"
  sha256 "953f9547433d1f851f3b56660ec92b8bbb436b3af1b7fe7b6a492e4fff8aa207"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "5a1ca4627161331be62240f5f19c3af5134cc37824dabfeca4968fccd0faa426"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85f6e0e64665cde0ee5bd5937674b43f7a5124e0e9a3bb9e60a01bc5b5582e9c"
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
