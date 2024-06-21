FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl build-essential pkg-config libssl-dev && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    . $HOME/.cargo/env && \
    git clone https://github.com/ordinals/ord.git && \
    cd ord && \
    cargo build --release

COPY entrypoint-ord.sh /entrypoint-ord.sh

RUN chmod +x /entrypoint-ord.sh

ENTRYPOINT ["/entrypoint-ord.sh"]
