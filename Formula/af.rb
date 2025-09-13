class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.43.tar.gz"
  sha256 "baf6a7e60553849bb415d7647fa7a2d3af5f84d259dd53ebab861867985bd5dc"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "7a939ff94c33dcb6298ceddd5304fc204ce42a1a6e1b4df9913c1d6875c2c508"
    sha256 cellar: :any,                 ventura:       "b4a5cf88f90ca72f81e89073192ef62f1231734e8bcf5e98b2a1f941ff878434"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61eb1fc60c96c3876be809ad770b9be7990a5943b8210dfac2c0f4476ebcdd41"
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
