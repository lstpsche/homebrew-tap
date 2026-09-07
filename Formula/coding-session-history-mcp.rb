class CodingSessionHistoryMcp < Formula
  desc "Read-only MCP search and retrieval of local Codex session history"
  homepage "https://github.com/lstpsche/coding-session-history-mcp"
  url "https://github.com/lstpsche/coding-session-history-mcp/releases/download/v1.1.0/coding-session-history-mcp-1.1.0.tgz"
  sha256 "9274361155304fab0d537f50966b404616a9cd1c611b346bb4c6f967a1e67913"
  license "MIT"

  depends_on "python@3.14" => :build
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
    (bin/"coding-session-history").write_env_script libexec/"bin/coding-session-history",
                                                   PATH: "#{formula_opt_bin("node")}:$PATH"
  end

  def caveats
    <<~EOS
      Start with the installation and scope instructions:
        https://github.com/lstpsche/coding-session-history-mcp#first-run

      The command is available as:
        coding-session-history setup --repo /absolute/path/to/your/project

      Paste the printed configuration into your MCP client.
      This formula does not index your history or start a background service.
      After Node or formula upgrades, restart your MCP client and regenerate
      any launchd configuration that refers to the previous installed paths.
    EOS
  end

  test do
    assert_match "coding-session-history", shell_output("#{bin}/coding-session-history --help")
    source = testpath/"source"
    (source/"sessions").mkpath
    records = [
      { timestamp: "2026-09-07T10:00:00Z", type: "session_meta",
        payload: { id: "brew-test", cwd: "/example/project" } },
      { timestamp: "2026-09-07T10:00:01Z", type: "response_item",
        payload: { type: "message", role: "user", content: [{ type: "input_text", text: "SQLite evidence" }] } },
    ]
    (source/"sessions/rollout-example.jsonl").write records.map(&:to_json).join("\n") + "\n"
    db = testpath/"index.sqlite"
    result = shell_output("#{bin}/coding-session-history setup --repo /example/project --source #{source} --db #{db}")
    assert JSON.parse(result).fetch("mcpServers").key?("coding-session-history")
    result = shell_output("#{bin}/coding-session-history search SQLite --db #{db}")
    assert_equal "brew-test", JSON.parse(result).fetch("results").first.fetch("session_id")
  end
end
