class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.15.tar.gz"
  sha256 "24e0f52fc8733085b85c2e47f9894cc709f182674e73e229dbcd79883c9e6123"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "1b29604cc3066132a2c8efb124b07926a9d403b94b1abd2e8073528750ba7e86"
    sha256 cellar: :any,                 ventura:       "9d9ec66c26953ec7213ce163afb51dc59221a1b5f7d4bafbab5413565bf9aac9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15663b24782822326280d4c8d5a82a45f3b99d41bcccb7d0ef5153ce862f80d1"
  end

  depends_on "rust" => :build
  depends_on "openssl"
  depends_on "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin / "af", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/af --version")
  end
end
