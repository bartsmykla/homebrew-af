class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.33.tar.gz"
  sha256 "1d244320ca050334ca81b80b2d451b7066b6d8c41ec23e72f8cb94e347576445"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "77d9e5b626c9fce8ee7c78d6a3749d897f4f30ef8f073033c9d7d6fea5eb59b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ef70e3efb238f3f602aa2f2b7e20c949ab5700fa7856129c47c826a41808d93"
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
