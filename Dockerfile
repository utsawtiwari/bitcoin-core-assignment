FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*


RUN useradd -m -s /bin/bash bitcoin

RUN wget https://bitcoincore.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz && \
    tar -xzf bitcoin-25.0-x86_64-linux-gnu.tar.gz && \
    cp bitcoin-25.0/bin/* /usr/local/bin/ && \
    rm -rf bitcoin-25.0*


USER bitcoin
WORKDIR /home/bitcoin

# Create .bitcoin directory
RUN mkdir -p /home/bitcoin/.bitcoin

# Expose RPC and P2P ports
EXPOSE 18443 18444

# Default command
CMD ["bitcoind"]

