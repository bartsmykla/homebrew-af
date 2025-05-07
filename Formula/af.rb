class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "0753caa450ed91b17d1d3faec9bc636595d3836bfc0aec9db8b0eaf41c7e3000"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "1052455514bf29e2c41462f91573abc22980bd59cb09842be6b77e966bfe7dc6"
    sha256 cellar: :any,                 ventura:       "982b21e154b2f11a804e66d920b0b130e834c46533e1a4b0237abcdabb71aaf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa1e10642daa53cf25a115ae47f379575395dfa604be221df7f0309d908fa306"
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
