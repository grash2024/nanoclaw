# Stage 1: Build ZeroClaw from source
FROM rust:1.75-slim AS builder
RUN apt-get update && apt-get install -y git build-essential pkg-config libssl-dev curl
WORKDIR /app
RUN git clone https://github.com/zeroclaw-labs/zeroclaw.git .
RUN cargo build --release

# Stage 2: Minimal runtime image
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates curl && rm -rf /var/lib/apt/lists/*
WORKDIR /root/
COPY --from=builder /app/target/release/zeroclaw /usr/local/bin/zeroclaw

# Create standard ZeroClaw configuration folder
RUN mkdir -p /root/.zeroclaw

# Expose port for Render's web service health checks
EXPOSE 8080

# Start the ZeroClaw gateway or channel listener
CMD ["zeroclaw", "--config", "/root/.zeroclaw/config.toml"]
