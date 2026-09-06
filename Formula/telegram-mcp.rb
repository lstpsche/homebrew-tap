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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.6.0/telegram-mcp-0.6.0-darwin-arm64.zip"
      sha256 "3d6cbe01945cd3b204f6354189b6ce35f8665acf9fe005599479fb4f94853843"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.6.0/telegram-mcp-0.6.0-darwin-amd64.zip"
      sha256 "5aa2fa09969e61b58c85156571d75788ebcdbc38b1a372d1dc960701b118e03d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.6.0/telegram-mcp-0.6.0-linux-arm64.zip"
      sha256 "c97e9c049efae1aa3fab08685c28227fc90a0b3d971c81ee708f2844fbea46c3"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.6.0/telegram-mcp-0.6.0-linux-amd64.zip"
      sha256 "a26524fde63307402a7464768c7c74281fba0a62ed3f7576e00042507d0a9483"
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
