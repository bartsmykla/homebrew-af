class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.21.tar.gz"
  sha256 "add453eef71428e1db163a15654a9098741dc8f8a02df7b6859b9b83c341708a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "9428abdb7c4a8f1276b11599965695a08e7cc1eeefdeb5e33adb2490feeb2649"
    sha256 cellar: :any,                 ventura:       "a80676c74cb82b8115060094ebf78115316e373c8e3cca46f41a8b1cfd8b7751"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5bd1b3ee2af9d431b8741df390766d1d8d7ee9fcffcc1464912f08a7796e8e68"
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
