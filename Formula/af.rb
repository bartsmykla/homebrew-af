class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af/archive/refs/tags/v0.7.15.tar.gz"
  sha256 "e77b5c6e99961174246cce28a91b516b8e8169126c4e027c68fc1aa505801974"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "f87dce91d4a6a19aaa4823386762d5568479913610c4c405ec4c928b4f13eb18"
    sha256 cellar: :any,                 ventura:       "c7b98cee0cb737a4a8a07cdd1a8816c65d35e1af8ec7dd5fd67637524394ca89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27b0f586491496493feab9240174f5d9d9ad69fe6d6330bcdf80cd07a77f9981"
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
