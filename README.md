# Claude Sandbox

Docker configuration to run Claude Code in a containerised environment.

### Quick Start

Start container runtime, e.g. [Colima](https://github.com/abiosoft/colima) or [Docker Desktop](https://www.docker.com/products/docker-desktop/)

<details>

<summary>Colima start</summary>

```sh
colima start
```

</details>

Build the image

```sh
docker build -t claude-sandbox .
```

Set up local directories and configuration

```sh
mkdir -p ~/.claude-sandbox/.claude
cp .claude.json ~/.claude-sandbox/.claude.json
```

Run the container

```sh
docker run -it \
  -v $(pwd):/workspace/${PWD##*/} \
  -v ~/.claude-sandbox/.claude:/home/appuser/.claude           \
  -v ~/.claude-sandbox/.claude.json:/home/appuser/.claude.json \
  --network="host"                \
  -w /workspace/${PWD##*/}        \
  claude-sandbox
```

This command starts the folder based on the project direct the container was
started in so that you can use the same command for multiple projects and Claude
will maintain separate configuration for each.

Set up shell alias go `claude-box`

<details>
<summary>bash alias</summary>

Add this to your `~/.bashrc` or `~/.bash_profile`:

```bash
alias claude-box='docker run -it  \
  -v $(pwd):/workspace/${PWD##*/} \
  -v ~/.claude-sandbox/.claude:/home/appuser/.claude \
  -v ~/.claude-sandbox/.claude.json:/home/appuser/.claude.json \
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
        -v ~/.claude-sandbox/.claude:/home/appuser/.claude \
        -v ~/.claude-sandbox/.claude.json:/home/appuser/.claude.json \
        -w /workspace/(path basename $PWD)               \
        claude-sandbox $argv
end
```

</details>

You can register custom commands

```
mkdir ~/.claude-sandbox/.claude/commands
echo "Apply precepts.md from MCP Reader" > ~/.claude-sandbox/.claude/commands/precepts.md
```

Add you can add MCP Servers

```
claude-box mcp add -s user \
  --transport sse markdown-reader http://host.docker.internal:8080/sse
claude-box mcp add -s user \
  --transport http context7 https://mcp.context7.com/mcp
```

## Development

Install pre-commit for local lint and pre-commit checks.

```bash
pip install pre-commit
```

Install the git hook scripts:

```bash
pre-commit install
```

Run against all files if you need to do a full check:

```bash
pre-commit run --all-files
```

## Clean up

Remove the Docker image:

```sh
make clean
```

Remove image and all local directories. This will remove all session context and
memory for Claude from running with this container.

```sh
make clean-all
```
