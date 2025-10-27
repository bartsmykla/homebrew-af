class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.58.tar.gz"
  sha256 "7290caa16334750069d6eba86a0f18ceeafa684a457e90dc2f5857e9cc04a03f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "ea38820335a2193f9a2594bb154e0f316e972c77adca012744180801d13a2a56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cead305051eed41f77020fde9ff9fb3efa6cbfd49c07636bb7efa380c0f05e3c"
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
