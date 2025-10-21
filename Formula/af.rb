class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.55.tar.gz"
  sha256 "b387028742bab34d1c89c70fc22d4b9ac565d278a6d281620ef2bfe6c5f542d7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "eed0cdbdec216569e5ae497942d20b067e973542cc115bc4aada06ec39d6e863"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "888b09282a6400a3572d26d68aefb3928516d6c94af20b175680ecdf5c2b5ae8"
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
