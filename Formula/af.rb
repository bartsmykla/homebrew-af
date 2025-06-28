class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.13.tar.gz"
  sha256 "cf6c22ac659bf84f60f69bb16fe5fc7cd4cda5268096fdb3cf3ccfe372296531"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "420b79805e29de91851e159d9d0170b7aee012f8aa53a832d4adbd2be8a351f8"
    sha256 cellar: :any,                 ventura:       "521c0442352924e21b97f2681c83cc4fcd6ac1b345972c3b7af6bdcae516c9c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4fc90248d0f9142fdce08edf5c5e81157fd366c32480958bf83878ee88b00e5"
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
