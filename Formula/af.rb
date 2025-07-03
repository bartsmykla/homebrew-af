class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.16.tar.gz"
  sha256 "0bd60541ffeff552225fd9bf8f9f899e7920bce67ee4f286b3bae9c9699ca627"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "0cce95e8602ac17c6a8f8a3497fc535c2b9043bed173459fd75fcfaf4148099a"
    sha256 cellar: :any,                 ventura:       "7e746461691c07279264ace9bcceee41e087bed58fbfd38d87d9de5c050d7657"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "014cd390338328efd6cd22864076dfec2dab2be078ba816a28db015ad745dbed"
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
