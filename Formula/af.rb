class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.67.tar.gz"
  sha256 "2d7f74e0f7f5e89b1804950bb03053dfc52b3dc3edfd29ac182ccb3fe66bc8b3"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "fcd250a8f8cedece2debf3055991ff7890849eeabb3ddda0680932023759758d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e3392fb450b710b45eabeeb5bb7de9f4725ba5a168d03696a69175530368a229"
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
