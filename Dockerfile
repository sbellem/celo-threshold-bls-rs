FROM rust:1.77.2-bookworm

ARG SOLC_VERSION=v0.8.24

RUN set -eux; \
    downloads="https://github.com/ethereum/solidity/releases/download"; \
    wget -q "${downloads}/${SOLC_VERSION}/solc-static-linux" -O /usr/local/bin/solc; \
    chmod +x /usr/local/bin/solc;

WORKDIR /usr/src/tbls

COPY Cargo.lock Cargo.toml .
COPY crates crates
COPY solidity solidity

RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build
