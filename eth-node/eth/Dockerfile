# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 安装必要的系统库和工具
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# 创建存储数据的目录
RUN mkdir -p /data/ethdata
WORKDIR /data/ethdata

# 下载 eth 二进制文件并将其解压到 /usr/local/bin/geth
RUN curl -Lo /tmp/geth.tar.gz https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.14.3-ab48ba42.tar.gz && \
    tar -xzf /tmp/geth.tar.gz -C /tmp/ && \
    mv /tmp/geth-linux-amd64-1.14.3-ab48ba42/geth /usr/local/bin/ && \
    chmod +x /usr/local/bin/geth && \
    rm /tmp/geth.tar.gz

# 设定容器启动时运行的命令
ENTRYPOINT ["/usr/local/bin/geth"]
