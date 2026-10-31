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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.2/telegram-mcp-1.2.2-darwin-arm64.zip"
      sha256 "d833f788e30dc7e1fa6dc7d89ba51bee1fd768ef51aa0526fdcf08271ca6f3c2"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.2/telegram-mcp-1.2.2-darwin-amd64.zip"
      sha256 "1e3eae27bb1987164eb3b3397b20319dc01c67bcb5de19fa86b2dc52b6a4fe22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.2/telegram-mcp-1.2.2-linux-arm64.zip"
      sha256 "56275bba5a0df373db029b34ddda2a5f8b52d0f77e8efca0b3057e73480caf48"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.2/telegram-mcp-1.2.2-linux-amd64.zip"
      sha256 "111b1e381214b3656440126d8f656c4648c7b0fd37753513590a07d20f6453bc"
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
