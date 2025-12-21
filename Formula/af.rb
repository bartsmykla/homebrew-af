class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.28.tar.gz"
  sha256 "e031f8bf4c13906aae56cf691ab5c030b6eb403b655bda40f06e81022da3f748"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "6d6cb27c24245733683ab0894fb451469028ea87d5a29723b0939caae5322ea2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2db5acc9531e67bc613e1c7bf54a17715242d030c3a394959e7c8836f2d7d295"
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
