class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.68.tar.gz"
  sha256 "7363bc760d78165238da90a78d296b3b58d857a2bbe695745ebb17b4c6273bb3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "bd345f1fffff299718720f1f2a37c93df66371402f5a4a1686d1e6cf2e0c168c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee4c65483c028d74ce79ebeca57ec7cd838a6a176d8dc0fb12e687b033af13de"
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
