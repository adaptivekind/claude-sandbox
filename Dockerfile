FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
  nodejs \
  npm \
  zsh

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create non-root user
RUN adduser appuser

# Create directories and set permissions
COPY .zshrc /home/appuser/.zshrc
RUN chown -R appuser:appuser /home/appuser

# Create app directory and set ownership
WORKDIR /workspace
RUN chown -R appuser:appuser /workspace

# Switch to non-root user
USER appuser

ENTRYPOINT ["/usr/local/bin/claude"]
