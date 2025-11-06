# =========================
# Base Image: Debian + build tools
# =========================
FROM debian:12

# Install base dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# =========================
# Install Node.js 20.x explicitly
# =========================
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    node -v && npm -v

# =========================
# Install React and Nest CLI globally
# =========================
RUN npm install -g create-react-app @nestjs/cli concurrently

# =========================
# Working directory
# =========================
WORKDIR /docker

# =========================
# Copy everything
# =========================
COPY . .

# =========================
# Build React frontend
# =========================
WORKDIR /docker/website
RUN npm install && npm run build

# =========================
# Build NestJS backend
# =========================
WORKDIR /docker/backend
RUN npm install && npm run build

# =========================
# Expose ports (as needed)
# =========================
EXPOSE 80
EXPOSE 8080

# =========================
# Default CMD
# =========================
CMD ["/bin/bash"]

# =========================
# Run Services
# =========================
WORKDIR /docker
CMD bash -c "concurrently \
  \"npm run dev --prefix ./website\" \
  \"npm run start:prod --prefix ./backend\""