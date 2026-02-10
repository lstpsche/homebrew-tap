# Homebrew formula for openmeteo-sh
# Package: openmeteo-sh  |  Binary: openmeteo
# Tap repo: lstpsche/homebrew-tap  →  brew tap lstpsche/tap
class OpenmeteoSh < Formula
  desc "Fast, lightweight CLI for the entire Open-Meteo API suite"
  homepage "https://github.com/lstpsche/openmeteo-sh"
  url "https://github.com/lstpsche/openmeteo-sh/archive/refs/tags/1.2.0.tar.gz"
  sha256 "0ed080ea215430e265f4f6dc326fef450a752a59da528cfe7e3d07d2240aec5f"
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
