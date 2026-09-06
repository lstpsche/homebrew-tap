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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.4.0/telegram-mcp-0.4.0-darwin-arm64.zip"
      sha256 "a96615a3f623e7b8bd9318e29abd18d6d5b8347c5f7340feba67f539d303eda6"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.4.0/telegram-mcp-0.4.0-darwin-amd64.zip"
      sha256 "a6409648cd6094a39445eb33e64cc5f895c114ec48589f5c57ac95345166eafd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.4.0/telegram-mcp-0.4.0-linux-arm64.zip"
      sha256 "d72ebd0e77522c38da2cd81c828700e77bfe78f86051d9ce4e55e24118b65dca"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.4.0/telegram-mcp-0.4.0-linux-amd64.zip"
      sha256 "7379421e442f5364dc750ac02048575eed5fc2b0f91e64daae4360b3be5f1531"
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
