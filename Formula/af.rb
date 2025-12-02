class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.8.7.tar.gz"
  sha256 "45f27e813aee2f09290bb22b7bf1f87d8c9f7764b2742b0698d1e9d2462e9e3a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "40e5c925142ae846a466122fa2f18715864b3789d53428a129d3d09c2bf3e79f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f14c385681428ce41944f24e357d0876d982827491b20e6beafeb0df4fb2ddc2"
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
