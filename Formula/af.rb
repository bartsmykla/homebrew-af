class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "5414bce09a4b6ed358c27274165638367f935f001dc6e761e168156084caf345"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "8193626601e245126fbb3b448ee219a4f7643f76b61c54e2a316b53f5e82c164"
    sha256 cellar: :any,                 ventura:       "38a55474e2d2c3a293d2dd81eeb06ba3bc5bc73a386897ed9943bf0e0bb1c5c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f429a69ddc552b0d9c009a30c4f92dfef067a8accdbd1b3407d30f461a8e56c2"
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
