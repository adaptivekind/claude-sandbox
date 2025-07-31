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

Create directory on local machine for persistence of Claude in the container.
When we run the docker image we'll bind the ~/.claude directory in the container
to this local directory.

```sh
mkdir -p ~/.ai-container/.claude
cp .claude.json ~/.ai-container/.claude.json
```

Run the container

```sh
docker run -it \
  -v $(pwd):/workspace/${PWD##*/} \
  -v ~/.ai-container/.claude:/home/appuser/.claude           \
  -v ~/.ai-container/.claude.json:/home/appuser/.claude.json \
  --network="host"                \
  -w /workspace/${PWD##*/}        \
  claude-sandbox
```

This command starts the folder based on the project direct the container was
started in so that you can use the same command for multiple projects and Claude
will maintain separate configuration for each.

Set up alias.

<details>
<summary>bash alias</summary>

Add this to your `~/.bashrc` or `~/.bash_profile`:

```bash
alias claude-box='docker run -it  \
  -v $(pwd):/workspace/${PWD##*/} \
  -v ~/.ai-container/.claude:/home/appuser/.claude \
  -v ~/.ai-container/.claude.json:/home/appuser/.claude.json \
  --network="host"                \
  -w /workspace/${PWD##*/}        \
  claude-sandbox'
```

Then reload your shell configuration:

```bash
source ~/.bashrc
```

</details>

<details>
<summary>fish alias</summary>
```fish
function claude-box
    docker run -it \
        -v $(pwd):/workspace/(path basename $PWD)        \
        -v ~/.ai-container/.claude:/home/appuser/.claude \
        -v ~/.ai-container/.claude.json:/home/appuser/.claude.json \
        -w /workspace/(path basename $PWD)               \
        claude-sandbox $argv
end
```

</details>

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

## Clean up

```
rm -r ~/.ai-container
```
