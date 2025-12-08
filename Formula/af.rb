class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.13.tar.gz"
  sha256 "e7fd899b3b7c5a80193fd0cef3ba331e5585da0f659cfcbf4dd2662edaebceb0"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "d3bb7ccb77afb73fa43397e85f6bb5e7e5c2ec9f69a2e3e2aa9758090ffea933"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26c47fad32046d6b45bcdcfac786bbaeb45fc0a3e9f8edf32537618912bf380a"
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
