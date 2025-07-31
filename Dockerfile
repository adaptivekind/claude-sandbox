FROM node:24-alpine

RUN apk add --no-cache zsh

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create non-root user
RUN addgroup -g 1001 -S appuser && \
  adduser -S appuser -u 1001 -G appuser

# Create directories and set permissions
COPY .zshrc /home/appuser/.zshrc
RUN chown -R appuser:appuser /home/appuser

# Create app directory and set ownership
WORKDIR /workspace
RUN chown -R appuser:appuser /workspace

# Switch to non-root user
USER appuser

# Set default command to fish for interactive use
CMD ["/bin/zsh"]
