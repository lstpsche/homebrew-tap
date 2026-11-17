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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.4.0/telegram-mcp-1.4.0-darwin-arm64.zip"
      sha256 "9e70050b482ec5c18be391b6b76923ef46983aede058165b36a42f293f7309e0"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.4.0/telegram-mcp-1.4.0-darwin-amd64.zip"
      sha256 "aca14228de93e5474abefd5b68f09d1a20a268ca6caa3e082e799c504eddc405"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.4.0/telegram-mcp-1.4.0-linux-arm64.zip"
      sha256 "45ebb79a767c72d8cdabd87e381047d64998a7e29fc977b943ce058ccb21b1c0"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.4.0/telegram-mcp-1.4.0-linux-amd64.zip"
      sha256 "1d93b13e0371727e8287e8c68403d295cba499ac197bd1cfbc058b74730f84cf"
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
