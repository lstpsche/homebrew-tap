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
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.0.0/telegram-mcp-1.0.0-darwin-arm64.zip"
      sha256 "eef275eb1e18910dea6a8f0809ba922e79f8fd1bb358df5023421f285ab478c0"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.0.0/telegram-mcp-1.0.0-darwin-amd64.zip"
      sha256 "c96621321d0a1d5c6615ba7cfc8ac68b39c95b98e7034252482127d0e5e8bbce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.0.0/telegram-mcp-1.0.0-linux-arm64.zip"
      sha256 "2a33459e3db6cdec8ee71a18dfd1ba2d94fe6e9e0579b5e0346fe7203ba54d8d"
    end
    on_intel do
      url "https://github.com/lstpsche/telegram-mcp/releases/download/v1.0.0/telegram-mcp-1.0.0-linux-amd64.zip"
      sha256 "0559cfd56c8db31844914e5cabe4a5c39ce2d928a8623a7f0a151fef0415126d"
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
