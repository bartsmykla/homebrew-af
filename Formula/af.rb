class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.53.tar.gz"
  sha256 "380e2c263ba839b6fa4c3e8449e4233281cc72da02e193e5067d44b35c9a31b7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "a1a21c50f8cdc77cc57e9423596ce8a0cb95f2f027128bea4895481e99d9b03c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22c7dbdcb8ea82cf63a8f4b8d0d14ce2397d413060a8da24911e0cc3ff9ea3cc"
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
