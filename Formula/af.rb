class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.46.tar.gz"
  sha256 "317fe4a6832778c4a0e75e781c2d59175bd4cb4074ec0cb4e4043d6c9b5c38cf"
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
