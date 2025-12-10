class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.15.tar.gz"
  sha256 "701a9c001a70fddf4e0db5971629a052ba1eefbf7b921144e2bdc64e1f1f8a65"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "f50177e68d2818cb93531629bc2e2c4a4cfac3b3867c6dd18f8e5f1932401fbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27e0cebc9693d3d7947a78bd2a219768d60e8d9b18729e43cfb96bfbdbb4bb50"
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
