class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.31.tar.gz"
  sha256 "a7a05151d8bbb8e61e6a79eae73e64db02e790c3cd0e12f575797c1b20586533"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "82ee3118133dd59ef538425a5a5168c3b67799cb6be06dd10636c1088b72b7d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5ab38378e23aa15ebde5771cb15c5bcca57798e9fafedfb8fc33c93eff2b5e4"
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
