# Stage 1: Build ZeroClaw from source
FROM rust:1.85-slim AS builder

RUN apt-get update && \
    apt-get install -y \
        git \
        build-essential \
        pkg-config \
        libssl-dev \
        curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/zeroclaw-labs/zeroclaw.git .

RUN cargo build --release


# Stage 2: Minimal runtime image
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root/

COPY --from=builder /app/target/release/zeroclaw /usr/local/bin/zeroclaw

# ZeroClaw configuration directory
RUN mkdir -p /root/.zeroclaw

EXPOSE 8080

CMD ["zeroclaw", "--config", "/root/.zeroclaw/config.toml"]
