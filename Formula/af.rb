class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.19.tar.gz"
  sha256 "a0ef987313034907b1fd8ad8fb9933958eda385aab80d3589340a0eb39c7352f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "e8405c937446ea64062aade5d1f54a0f6a6e1a22b12f65162ad32e29ab928b4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8beefeb74161c7f1063e1bed932b39abf832271050fb5d05349045e99d6245ac"
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
