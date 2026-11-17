class TelegramMcp < Formula
  desc "Unofficial, access-controlled Telegram context for AI agents over MCP"
  homepage "https://github.com/lstpsche/telegram-mcp"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.0/telegram-mcp-1.5.0-darwin-arm64.zip"
      sha256 "c64ffd8a2206985f043c34f183dcdcd72d58e580f3744a7ba2968be43aae5ee7"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.0/telegram-mcp-1.5.0-darwin-amd64.zip"
      sha256 "176b593c9f80b1d74b0b823ffbfc3e5886993a45387fa5234d941deb398eb7ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.0/telegram-mcp-1.5.0-linux-arm64.zip"
      sha256 "a67ed149a15de23f1a7247664100f567f93a69bf9534381e0ea9ac0811da93ef"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.0/telegram-mcp-1.5.0-linux-amd64.zip"
      sha256 "aed916c1918a0fe26f9d51aab807308644c20799d04bba3486458955f92383dc"
    end
  end

  def install
    bin.install "telegram-mcp", "telegram-mcpd"
    doc.install "docs"
    prefix.install "THIRD_PARTY_NOTICES.txt"
  end

  def caveats
    <<~EOS
      Create your private installation and start interactive setup:
        telegram-mcp install --version #{version} --setup

      Use the relay path printed by setup or `telegram-mcp agent-config`
      in your MCP client. The service uses private copies outside the Cellar.

      After upgrading this formula, update the managed service explicitly:
        "#{opt_bin}/telegram-mcp" upgrade --version #{version}
      Reconnect your MCP client afterward. Homebrew does not manage the service
      or remove your account data when this formula is uninstalled.
    EOS
  end

  test do
    %w[telegram-mcp telegram-mcpd].each do |program|
      assert_match "#{program} version=#{version}", shell_output("#{bin}/#{program} --version")
    end
    output = shell_output("#{bin}/telegram-mcp install --version invalid 2>&1", 2)
    assert_match "use install --version X.Y.Z", output
  end
end
