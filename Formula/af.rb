class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.44.tar.gz"
  sha256 "8bed5003025bcd2d22e8269776233ad6865577dab9c6588b9c85388013e9bb96"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "24b1818f9be4c184e0d8e35bd72e56843f98b02f2e87e294117accc8f44b3dd2"
    sha256 cellar: :any,                 ventura:       "8613bbc157756677268092f31c7baaf5324a7771410507b0f29a4d4aeead4f14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f0b8f16b20a6ffc8406b6c6403ce0ff1689e05c3a3a85c6bcbce570508738d3"
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
