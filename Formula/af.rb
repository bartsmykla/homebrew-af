class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.7.tar.gz"
  sha256 "b42f0132e24a9b1b3b3449e0c36e03ee981d439a5afd1156ba53b87d8746d53a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "5a96064b5297d904b87daa2504822dc0f90931d77da34cc49f9346437b6654f5"
    sha256 cellar: :any,                 ventura:       "5ca79421ee92d4b670e3d953c603f2fdda5c89f5648537a3e5177335d12d7bf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1ae943c595ece088e9a288a563de53d871d92205e62aefafb787cbc4ec3bcdd"
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
