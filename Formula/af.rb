class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.36.tar.gz"
  sha256 "ad90ebbccda6f86cc54df34a91bfce895cb0fa6d9c2935d58a2c6a3737f31a14"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "de794c49f94af5bf778e6abaa0ab5cf959e49ccb099a166b493a591559f55b9c"
    sha256 cellar: :any,                 ventura:       "5ca1264bb7e7ba7000c3c3d54ea3866e09eea78fec981306cc32746f6164fa23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5580ca1d22437c7accd1092cd5725fb04e0b8851b5e861edcf02ac379806e4d6"
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
