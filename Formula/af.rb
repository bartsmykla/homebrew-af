class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.50.tar.gz"
  sha256 "51c54ac2e8fbb79b3a06148653593cfdf126d439c94d76fe530ddc24ceab4b47"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "8acb11350bc1a040dee3e44bcfd15de23c58d05569604dec648dd891f48e8b3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a9baeff2eb291f51d6c99e5a35e798c11cbee08700d38814372b583d4cecf6d"
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
