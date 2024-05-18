# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 安装必要的系统库和工具
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# 创建存储数据的目录
RUN mkdir -p /data/prysm
WORKDIR /data/prysm

# 下载 Prysm beacon chain 二进制文件并将其复制到 /usr/local/bin/beacon-chain
RUN curl -Lo /usr/local/bin/beacon-chain https://github.com/prysmaticlabs/prysm/releases/download/v5.0.3/beacon-chain-v5.0.3-linux-amd64 && \
    chmod +x /usr/local/bin/beacon-chain && \
    ls -l /usr/local/bin/beacon-chain

#拷贝启动脚本并赋予执行权限
COPY beacon-start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/beacon-start.sh

# 设定容器启动时运行的命令
ENTRYPOINT ["/usr/local/bin/beacon-start.sh"]
