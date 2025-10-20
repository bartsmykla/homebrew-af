class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.54.tar.gz"
  sha256 "c7e942fd171c335476316b263a72c79254f35685b311922f161dbc3ebfbdc931"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "deeaff8aa23161ab1140f9b1cd8ae90cb7c675770f85aa71666d3ff0cd11a6c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b46c23cf01d32013ead7f14ae1de3925420053aa94503efc6408a2dc4f9f78ce"
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
