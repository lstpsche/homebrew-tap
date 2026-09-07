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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.8.0/telegram-mcp-0.8.0-darwin-arm64.zip"
      sha256 "c283df93218c19170cf239e50f66dba0f85dc6586faf6a7646f7d60ae5b168ea"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.8.0/telegram-mcp-0.8.0-darwin-amd64.zip"
      sha256 "110cc048be85845349b643e7512ad076a4c872acadc704ca94c9bbf2ffb4865d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.8.0/telegram-mcp-0.8.0-linux-arm64.zip"
      sha256 "0838db673a825f394424e72c92df3de64292c96d47a5e301e0ea50bcee705b2f"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.8.0/telegram-mcp-0.8.0-linux-amd64.zip"
      sha256 "bc52af98ce9d7216367dd0c923b5a635b12784608e90405682212a711d7adfd7"
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
