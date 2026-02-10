# Homebrew formula for openmeteo-sh
# Package: openmeteo-sh  |  Binary: openmeteo
# Tap repo: lstpsche/homebrew-tap  →  brew tap lstpsche/tap
class OpenmeteoSh < Formula
  desc "Fast, lightweight CLI for the entire Open-Meteo API suite"
  homepage "https://github.com/lstpsche/openmeteo-sh"
  url "https://github.com/lstpsche/openmeteo-sh/archive/refs/tags/0.2.0.tar.gz"
  sha256 "5ac16b9f052e073341d169852a8a58f1de2f43fba126a6baf582fbc329ae50ce"
  license "MIT"
  head "https://github.com/lstpsche/openmeteo-sh.git", branch: "main"

  depends_on "jq"

  def install
    # The entrypoint script is named "openmeteo" (the CLI command users type).
    # lib/ and commands/ must sit next to it so SCRIPT_DIR resolution works.
    libexec.install "openmeteo"
    libexec.install "lib"
    libexec.install "commands"

    # Symlink into bin/ — users run "openmeteo", not "openmeteo-sh"
    bin.install_symlink libexec/"openmeteo"

    bash_completion.install "completions/openmeteo.bash" => "openmeteo"
    zsh_completion.install  "completions/openmeteo.zsh"  => "_openmeteo"
  end

  test do
    assert_match "openmeteo #{version}", shell_output("#{bin}/openmeteo --version")
  end
end
