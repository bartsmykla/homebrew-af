class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.64.tar.gz"
  sha256 "6eedb1db7c649b01c69be62a09677891290f37f08db68e500e41393f0147b55c"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "90ffd3ac7281b5e37cd4e419b099d3bc9a0204810a68fbbaa6a509515e9070be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19049e090248fb9587beac28f8c7e019a0fc359e2d73a57d2048b7baa0fb5d27"
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
