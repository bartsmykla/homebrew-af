class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.30.tar.gz"
  sha256 "9cfc52b99de47676792cbd212f7a05813fe20cb5726ea87b64ee4ebf389673be"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "bff64bb1dafb60077b225fe255c13acfc9e1b9985fef595c123f10bd471fcc3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a27b5e54a6ef57255a4c80013f31c589634ccc307650eb2b0f33c85b0574e49"
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
