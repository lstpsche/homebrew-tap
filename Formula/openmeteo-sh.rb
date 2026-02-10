# Homebrew formula for openmeteo-sh
# Package: openmeteo-sh  |  Binary: openmeteo
# Tap repo: lstpsche/homebrew-tap  →  brew tap lstpsche/tap
class OpenmeteoSh < Formula
  desc "Fast, lightweight CLI for the entire Open-Meteo API suite"
  homepage "https://github.com/lstpsche/openmeteo-sh"
  url "https://github.com/lstpsche/openmeteo-sh/archive/refs/tags/1.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
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
