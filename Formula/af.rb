class Af < Formula
  desc "Afrael's CLI tool - foo"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af.git",
      tag:      "v0.1.12",
      revision: "90186ebd2d6cc139ab6ba0d93f0478605dbec7d6"
  license "MIT"
  head "https://github.com/bartsmykla/af.git",
       branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/bartsmykla/af"
    sha256 cellar: :any,                 arm64_sequoia: "583dc450e8ef08bae070fb056cbb24f0e0e1c8e3f1313108793476923894304d"
    sha256 cellar: :any,                 ventura:       "cc63995197612751320d3a93fee2ffac0938542aca496003fe9eec9fd1e57a34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f111dff305b5cd2e058489e45a47ceac5a83b507588b5fd3d3e5ce3e0eac5373"
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
