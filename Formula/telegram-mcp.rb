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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.0/telegram-mcp-1.2.0-darwin-arm64.zip"
      sha256 "e478bffe3e070c933678a6d1b902afc33c1ade1fbf079c6e9a3c7b9a80877207"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.0/telegram-mcp-1.2.0-darwin-amd64.zip"
      sha256 "7c78db90cba7f6a7c374b2ac5fee21e658d99b75ccc6c71b252b618cbf0f0517"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.0/telegram-mcp-1.2.0-linux-arm64.zip"
      sha256 "7c014259492aae7a4b02c837a019cb220f8e83d1652b85e53558c3b1a3c260dc"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.0/telegram-mcp-1.2.0-linux-amd64.zip"
      sha256 "3d3bac1fba7b7f4a6adc60a551d70630ba74c3aeed199669d37dd539d6f09fe9"
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
