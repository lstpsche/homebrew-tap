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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.7.0/telegram-mcp-0.7.0-darwin-arm64.zip"
      sha256 "2219902c809755dbbdef64da7e0290b1fd614f30b0f991d43744bac350987218"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.7.0/telegram-mcp-0.7.0-darwin-amd64.zip"
      sha256 "db677bad24de6c6d97bcb3d8cda29a4df6517603c1a5053d1ef846ee2d0b8df7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.7.0/telegram-mcp-0.7.0-linux-arm64.zip"
      sha256 "3b9ade01aa00711bd180653c945acbab0b13806194c9ae32e9ea64a2e7a0c564"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v0.7.0/telegram-mcp-0.7.0-linux-amd64.zip"
      sha256 "94bc33be761ee32f060b781b4c70f3f29d5319a36b0746bcb8518ecb18075cbf"
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
