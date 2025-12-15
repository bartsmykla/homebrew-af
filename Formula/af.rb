class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.22.tar.gz"
  sha256 "fe2dba0216569fbcb2f0e2416b930618e4c63d74354c5d0fd5cf1027eff77a99"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "d14f990dd9124bde63e346c531ac340bef8b6ad05a7aa3eb82f8ba0ab105f350"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac91b5e940c86ae7ff5b89fa3407a10facf64cd42ddd67e9f4ca38a74566754a"
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
