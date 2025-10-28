class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.59.tar.gz"
  sha256 "15251afed9cec6bb1da2b1a7ab8490ff4a1471a50e4ec24c85e0c052a8d015e3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "bca80c8c7bd5db5fc035ac78b4cd25d4bb54fda02eff2c479153e44f5bf6ab2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c8ff11d17e0956b7e3bc52b70270fb8496991b000335287aabc803d26bddfcf"
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
