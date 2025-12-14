class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.19.tar.gz"
  sha256 "a0ef987313034907b1fd8ad8fb9933958eda385aab80d3589340a0eb39c7352f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "86db29cced82187b6105c115534882b7057e8723031e570b7ed6eb4306c34cf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb5a34ec3756dc876f4409c5e1d652fe116fd3223f2919ee1828acee2c6dc694"
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
