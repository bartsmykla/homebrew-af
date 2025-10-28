class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.59.tar.gz"
  sha256 "15251afed9cec6bb1da2b1a7ab8490ff4a1471a50e4ec24c85e0c052a8d015e3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "3ae2d976f852c5d2ce2a524333062ecf834e17bb0d129c780eff6aac324bbe99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6eee859bbf5c55a4d55fe230b4c61256c7cee637122a8452efc3c239d467b3f2"
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
