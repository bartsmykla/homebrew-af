class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/smykla-labs/af"
  url "https://github.com/smykla-labs/af/archive/refs/tags/v0.8.15.tar.gz"
  sha256 "701a9c001a70fddf4e0db5971629a052ba1eefbf7b921144e2bdc64e1f1f8a65"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/smykla-labs/af"
    sha256 cellar: :any,                 arm64_sequoia: "b84bd531c2c3ff445f362c3f6ba7061b0181c3253a43e5a11ba9c004faf1b03d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef4b6435c28b791e988b1cf235aaefd8dc45d6c1745d2a9097fabf1bc5e68405"
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
