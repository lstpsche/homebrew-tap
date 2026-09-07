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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.1.0/telegram-mcp-1.1.0-darwin-arm64.zip"
      sha256 "d2d5b7e4dc3ac949e747cd99c8a0e77a2f5f28a523e387124ec6eb377913b34d"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.1.0/telegram-mcp-1.1.0-darwin-amd64.zip"
      sha256 "bf0cba64025242f1c8f81bff14cca0ce475b9482ae4c505d6944aff1ec8b7739"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.1.0/telegram-mcp-1.1.0-linux-arm64.zip"
      sha256 "781f849fb5496f0f497d7fda4f4481a78099d9df52769becb00d38a8ad2e2583"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.1.0/telegram-mcp-1.1.0-linux-amd64.zip"
      sha256 "a323c45ee7edb33ce67ecb7d29223beb87d147608dbbf185188b2afce3f3f5ef"
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
