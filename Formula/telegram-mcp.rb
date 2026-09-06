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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.5.0/telegram-mcp-0.5.0-darwin-arm64.zip"
      sha256 "0f460d149f8396bd176891846de9f2211f4bf4a824f77d27de9164b280a2ead4"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.5.0/telegram-mcp-0.5.0-darwin-amd64.zip"
      sha256 "1fe7dffafb6bd10724dd1ee17640c7c9e4f82fe89624ddd1486f6fa62620586a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.5.0/telegram-mcp-0.5.0-linux-arm64.zip"
      sha256 "c1147092d8484086975a65af7a99806105b90a97481f80cb97c16dd31cf8d563"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.5.0/telegram-mcp-0.5.0-linux-amd64.zip"
      sha256 "6d1541d52a305bbae1b41cde2821816bf4557939c4e9b8bcd2abc6d539c56bdd"
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
