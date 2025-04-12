class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.14.tar.gz"
  sha256 "067958836e54c21818b67af1ac2b86c354ad0620b24fba38070318e60c1cfbdb"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "74100368d611f5493e7d993687ea479a0d10fe791f3224c6a204e2db51ba1198"
    sha256 cellar: :any,                 ventura:       "32c3ddec580cc1726032f771fcd501548414c338bdb9546d5555bad04acb3ff0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a254369ca9b70c260f4cfaefe539dcfb5411f10100da2f9d32e2548d226d00c8"
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
