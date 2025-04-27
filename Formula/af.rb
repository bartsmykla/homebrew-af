class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "fd803ed4c813baaddd14a9b973da66932d9b47a7f20674e22aab650fbbf42770"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "36a1c62d27c82e01ab6619dd74bc05f582c3f0f58b3779baa6b08de3460ecad9"
    sha256 cellar: :any,                 ventura:       "1d4a4569a573ab8891d7d13e7267b88bafc03f615afe90e3405ed53c564f4f94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9d2f6739b558f4149773a6943774c7185f19edde700eaa16aa91c5e2ceeb075"
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
