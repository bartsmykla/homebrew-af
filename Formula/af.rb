class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.8.tar.gz"
  sha256 "eedd2df90b01c45e54b78c1d03a0283c5f5479f0f0b642748648256e4c9c8bae"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "b933423ef4d35d8a6c83dc414784ccec6d109a84705d217eb9a713fa96f79d79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "092e69bb049e53aa9f121fe73743b0939b59a005fcf5f621ff4b51e4e56504c3"
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
