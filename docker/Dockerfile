FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        dos2unix \
        jq \
        wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    echo "Installing kubectl" && \
    wget -P /usr/bin/ --no-check-certificate https://storage.googleapis.com/kubernetes-release/release/v1.23.3/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

COPY *.sh /scripts/

RUN chmod u+x /scripts/* && \
    dos2unix /scripts/*