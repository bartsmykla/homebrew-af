class Af < Formula
  desc "Afrael's CLI tool"
  homepage "https://github.com/bartsmykla/af"
  url "https://github.com/bartsmykla/af.git",
      tag:      "v0.1.12",
      revision: "90186ebd2d6cc139ab6ba0d93f0478605dbec7d6"
  license "MIT"
  head "https://github.com/bartsmykla/af.git",
       branch: "master"

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
