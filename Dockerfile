# See https://hub.docker.com/_/debian/tags?name=bookworm for latest version
FROM debian:bookworm-20250721-slim

# Install dependencies
# see latest versions with make list-apt-versions
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  nodejs=18.19.0+dfsg-6~deb12u2 \
  npm=9.2.0~ds1-1 \
  zsh=5.9-4+b6 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN adduser appuser && \
  #Install Claude Code globally
  # See latest version at https://www.npmjs.com/package/@anthropic-ai/claude-code
  npm install -g @anthropic-ai/claude-code@1.0.64


# Create directories and set permissions
COPY .zshrc /home/appuser/.zshrc
RUN chown -R appuser:appuser /home/appuser

# Create app directory and set ownership
WORKDIR /workspace
RUN chown -R appuser:appuser /workspace

# Switch to non-root user
USER appuser

ENTRYPOINT ["/usr/local/bin/claude"]
