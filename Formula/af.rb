class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.48.tar.gz"
  sha256 "a8c6ba436b81f17c336ef2996c752c3c4bb0f0efdcbc67abb5f79d86d5f9606a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "c2105740f920991d656e0eeb7428f1880a109a58009ebad21c6dc7750a4dd6ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3d7b3abda768eb13534bb9990ca57c8c95649a61424831e830035aa54470708"
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
