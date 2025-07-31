# Claude Sandbox

Docker configuration to run Claude Code in a containerised environment.

### Quick Start

Start container runtime, e.g. [Colima](https://github.com/abiosoft/colima)

```sh
colima start
```

Build the image

```sh
docker build -t claude-sandbox .
```

Create local file store for persistence of Claude containerised configuration
between restarts:

```sh
mkdir -p ~/.ai-container/.claude
cp .claude.json ~/.ai-container/.claude.json
```

Run the container

```sh
docker run -it \
  -v $(pwd):/workspace \
  -v ~/.ai-container/.claude:/root/.claude \
  -v ~/.ai-container/.claude.json:/root/.claude.json \
  --network="host" \
  claude-sandbox -- /usr/local/bin/claude
```

Set up alias, e.g. in fish

```fish
function cclaude
    docker run -it \
        -v $(pwd):/workspace \
        -v ~/.ai-container/.claude:/root/.claude \
        -v ~/.ai-container/.claude.json:/root/.claude.json \
        claude-sandbox -- /usr/local/bin/claude $argv
end

```

Add commands

```
mkdir ~/.ai-container/.claude/commands
echo "Apply precepts.md from MCP Reader" > ~/.ai-container/.claude/commands/precepts.md
```

Add MCP Servers

```
cclaude mcp add -s user \
  --transport sse markdown-reader http://host.docker.internal:8080/sse
cclaude mcp add -s user \
  --transport http context7 https://mcp.context7.com/mcp
```
