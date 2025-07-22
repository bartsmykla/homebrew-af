class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.21.tar.gz"
  sha256 "add453eef71428e1db163a15654a9098741dc8f8a02df7b6859b9b83c341708a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "2f3dab515cedc6b2009318050a09c7fb4872e481e9f6209450c037b8c1fc547f"
    sha256 cellar: :any,                 ventura:       "b464f6d228257d7917bb84d75cdbfe4cdc00b8c1439bb5887e94eb8c5a939ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddb9cec94341fcba34e61162798e324bac428b788e64ad65cc669d463fae9836"
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
