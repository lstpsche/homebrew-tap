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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.2.0/telegram-mcp-0.2.0-darwin-arm64.zip"
      sha256 "4af976c4aba3bd4f747a4d0f06fd240d2ad5f7795e82f8f190f6b3cb7e7e9c2e"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.2.0/telegram-mcp-0.2.0-darwin-amd64.zip"
      sha256 "232ac218bb4d38a54127a210561c5167ec9dbd717fd75e351095c0bdd153f220"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.2.0/telegram-mcp-0.2.0-linux-arm64.zip"
      sha256 "12d69d437d4a8635d8c84cdd955304bd7a683ebe740f3b4bd4559fda1c6a220d"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.2.0/telegram-mcp-0.2.0-linux-amd64.zip"
      sha256 "9a42676b1f442eea74ec4a16523d3f02835c6b05308ccc8dcffec2c3fa7b07d6"
    end
  end

  def install
    bin.install "telegram-mcp", "telegram-mcpctl", "telegram-mcpd"
    doc.install "docs"
    prefix.install "THIRD_PARTY_NOTICES.txt"
  end

  def caveats
    <<~EOS
      Create your private installation and start interactive setup:
        telegram-mcpctl install --version #{version} --setup

      Use the relay path printed by setup or `telegram-mcpctl agent-config`
      in your MCP client. The service uses private copies outside the Cellar.

      After upgrading this formula, update the managed service explicitly:
        telegram-mcpctl upgrade --version #{version}
      Reconnect your MCP client afterward. Homebrew does not manage the service
      or remove your account data when this formula is uninstalled.
    EOS
  end

  test do
    %w[telegram-mcp telegram-mcpctl telegram-mcpd].each do |program|
      assert_match "#{program} version=#{version}", shell_output("#{bin}/#{program} --version")
    end
    output = shell_output("#{bin}/telegram-mcpctl install --version invalid 2>&1", 2)
    assert_match "use install --version X.Y.Z", output
  end
end
