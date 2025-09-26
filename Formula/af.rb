class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.47.tar.gz"
  sha256 "842256fcc7bbe07b033716dec7fc09605e6b4b9a107d6ac1bac3daa72f9e64bf"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "750d1d9133311b9134f512b850b3b3a9be8130b5d114b0fc981c6618338f3925"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ece391b3e8a575184f2b8adcffc083baf6e792c9564f55ebe09ebb6c2dce33cf"
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
