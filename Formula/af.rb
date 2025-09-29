class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.48.tar.gz"
  sha256 "a8c6ba436b81f17c336ef2996c752c3c4bb0f0efdcbc67abb5f79d86d5f9606a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ae7a79eda4fc3c5f55d52c3f56ed21890e2d1fca8514e96fc674aa471a8b9921"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0bd16e1baf90bf2c4b2533bbbbed7b30f04f0571b18d362f9265129560516122"
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
