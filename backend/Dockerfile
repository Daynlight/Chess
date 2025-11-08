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
# Install Nest CLI globally
# =========================
RUN npm install -g @nestjs/cli

# =========================
# Working directory
# =========================
WORKDIR /docker

# =========================
# Copy everything
# =========================
COPY . .

# =========================
# Build NestJS backend
# =========================
RUN npm install && npm run build

# =========================
# Expose ports (as needed)
# =========================
EXPOSE 80

# =========================
# Run Service
# =========================
CMD bash -c "npm run start:prod ."