FROM node:18-alpine

# Install git (often needed for development work)
RUN apk add --no-cache fish

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

COPY .config/fish /root/.config/fish

# Create app directory
WORKDIR /workspace

# Set default command to bash for interactive use
CMD ["/usr/bin/fish"]
