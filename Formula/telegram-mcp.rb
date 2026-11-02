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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.3.0/telegram-mcp-1.3.0-darwin-arm64.zip"
      sha256 "6c2e7f3422bb5238d5c6f84a57d6499e564a5619a66fa7691aa38d5213931afe"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.3.0/telegram-mcp-1.3.0-darwin-amd64.zip"
      sha256 "aadf2cd00d06786112ce80051a98806cf564707ad9d131c1c9715ae80ed004cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.3.0/telegram-mcp-1.3.0-linux-arm64.zip"
      sha256 "59645c5ae05b2bb48623c6bcc527f8ef44ea8ef73d72b19db677beed57a16bde"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.3.0/telegram-mcp-1.3.0-linux-amd64.zip"
      sha256 "4a9f8967cb45d339ee5491c45d2712bae1a44f3acf65c1ff2ede654240930856"
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
