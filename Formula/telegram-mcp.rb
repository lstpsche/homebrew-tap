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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.3.0/telegram-mcp-0.3.0-darwin-arm64.zip"
      sha256 "f3c16885a334825c57d28f879915db18f43678e1ec194d66a7b464d107a6981b"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.3.0/telegram-mcp-0.3.0-darwin-amd64.zip"
      sha256 "ef88b71b846d39d94631f3e09add318f4784649ae1690031c7c56b76c2e652bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.3.0/telegram-mcp-0.3.0-linux-arm64.zip"
      sha256 "0e3b58e2624856b3bebbcde1e71703be3ee4d6a0d4a3c5f687fbe1dfe81634f7"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.3.0/telegram-mcp-0.3.0-linux-amd64.zip"
      sha256 "f488803dfd925fea335d42fd451f41b0c5ffce4c2ae39b516370cb99934d21b7"
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
        telegram-mcp upgrade --version #{version}
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
