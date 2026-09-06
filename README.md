# Homebrew tap

Install command-line tools from [lstpsche](https://github.com/lstpsche).

| Formula | Project |
| --- | --- |
| `openmeteo-sh` | [Open-Meteo CLI](https://github.com/lstpsche/openmeteo-sh) |
| `telegram-mcp` | [Telegram MCP](https://github.com/lstpsche/telegram-mcp), an unofficial Telegram client for AI agents |

## Telegram MCP

On macOS or Linux, with Apple Silicon/ARM64 or Intel/x86_64:

```sh
brew install lstpsche/tap/telegram-mcp
telegram-mcpctl install --version 0.2.0 --setup
```

No Go installation is required. Homebrew verifies the platform archive's pinned
SHA-256. The second command downloads and verifies the release into private
per-user storage, then guides account login, access, service startup and client
connection. Credentials are entered locally through the console. Login alone
grants no message access.

Use the stable relay path printed by setup or `telegram-mcpctl agent-config`
in your MCP client. The running service uses private copies outside Homebrew's
Cellar, so `brew cleanup` cannot remove its binaries. Use Telegram MCP's own
`service` commands; this formula does not register a `brew services` service.

To update an existing managed installation:

```sh
brew update
brew upgrade lstpsche/tap/telegram-mcp
brew info lstpsche/tap/telegram-mcp
```

Run the `telegram-mcpctl upgrade --version ...` command shown by `brew info`, then
reconnect the MCP client. Upgrading the formula alone does not replace a running
service. Uninstalling the formula leaves the private service and account data
intact; stop/uninstall the service explicitly with its private control program
before removing Homebrew commands if that is your intent. See the project's
[installation guide](https://github.com/lstpsche/telegram-mcp/blob/main/docs/installation.md).

Other taps may contain unrelated projects named `telegram-mcp`. Always use the
fully qualified formula name above. Homebrew cannot keep two formulae with that
same name installed together; inspect an existing installation before choosing
which project to keep. This tap does not remove or replace another project's
installation automatically.

## Open-Meteo CLI

```sh
brew install lstpsche/tap/openmeteo-sh
openmeteo --help
```

## Maintaining Telegram MCP releases

After publishing a Telegram MCP release, update the formula version, all four
archive URLs and their SHA-256 values from the verified release, plus the setup
example above. Update the matching Homebrew instructions in the Telegram MCP
repository. `brew livecheck lstpsche/tap/telegram-mcp` detects the latest release;
it does not publish formula updates automatically.

CI runs Homebrew style/audit, installs the formula and runs its test on macOS and
Linux. Its installation smoke uses a disposable profile without authenticating
or starting a service. No Telegram credentials or content are used.
