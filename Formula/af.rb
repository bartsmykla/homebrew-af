class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.1.13.tar.gz"
  sha256 "1e64105986178fc72305a7da03339f9c8cb673393d5d49ed18b968d395b3e15d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "7788cf87fff3b38daa5931bae81fa51ce57d170da579a98b95e16de60919b48f"
    sha256 cellar: :any,                 ventura:       "56d4bbd37ee7795f60c8e2a6611037675a8e07b5d98d5d50ae6151399241d1ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "843c93d1bffeb24106c0da0d02215d0a70b9f840356e796efe895dc7ff7a9b1b"
  end

  depends_on "rust" => :build
  depends_on "openssl"
  depends_on "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    generate_completions_from_executable(bin / "af", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/af --version")
  end
end
