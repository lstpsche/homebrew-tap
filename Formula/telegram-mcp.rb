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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.1/telegram-mcp-1.2.1-darwin-arm64.zip"
      sha256 "02932f1ae6d5959f6fc3ee1201260824c2f31dd1573004223aafd2200f3747a9"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.1/telegram-mcp-1.2.1-darwin-amd64.zip"
      sha256 "eabb3c54c602823285659db5435aedad42600b0761c8f6739d2a6bc21386cb75"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.1/telegram-mcp-1.2.1-linux-arm64.zip"
      sha256 "d2e130ceb90d58a9e51df6281c9c112ab7ff0aa582fbf8ae78a1a16d142b6f30"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.2.1/telegram-mcp-1.2.1-linux-amd64.zip"
      sha256 "13e29879323c4640f81fa1f1636d81a164527148cc6e08fdaa334670a0cf14ed"
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
