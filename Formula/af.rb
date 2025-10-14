class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.52.tar.gz"
  sha256 "248f2a50b1244c4deac2143c153902fec6bc5f7237de46f467d02cab68ce513e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ea92ccb616d9b976103192b28c3bc1f15fe924128c71dedbbacda2e0900ac098"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f96845e42e148a2f051f5ac76701817af98a6371389f073e60b40e397b5ac76"
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
