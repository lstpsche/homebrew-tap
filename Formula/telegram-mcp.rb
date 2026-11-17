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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.1/telegram-mcp-1.5.1-darwin-arm64.zip"
      sha256 "6615f9fe93e25ccbedd3e99f57aeb656203f7637aa503784efc0de8baab5bd66"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.1/telegram-mcp-1.5.1-darwin-amd64.zip"
      sha256 "7532590aafc1c29a158b7c0f6e79d0f65d4577ffd46cae54ec0c96f3846a596d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.1/telegram-mcp-1.5.1-linux-arm64.zip"
      sha256 "1ac2da1a5a3c56c7c1d50d88333d61e96816854b50256a6fb30bc75caa41f862"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.5.1/telegram-mcp-1.5.1-linux-amd64.zip"
      sha256 "c23c0956c3ab9f6967af0ba28f68aee522a48fec5ea4a449adf953acdc827f0d"
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
