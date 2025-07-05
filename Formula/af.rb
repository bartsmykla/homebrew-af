class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.17.tar.gz"
  sha256 "d25cfd95e4dfd575df3c25b60fd820b4d2b2fb4c8fa8306fa274a11f24d8633e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "865f7b92d638c37be34d69ddf4948929fbeda95ca4e7e1fe1ce019a939b54e82"
    sha256 cellar: :any,                 ventura:       "9131ad903ebc99f3a09144d03f457c663b49ce28f15b602aed2e6f428b744341"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4282aa1f62bde875054f98e65885f420fa0e5a56d31eecd192445d1f7fef2e5d"
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
