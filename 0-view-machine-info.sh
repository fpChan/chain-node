#!/bin/bash

# 获取内存资源
memory_info=$(free -h | awk 'NR==2{print "总内存：" $2 ", 可用内存：" $7 ", 已用内存：" $3}')
echo "$memory_info"

# 统计物理 CPU 数量
physical_cpu=$(cat /proc/cpuinfo | grep 'physical id' | sort | uniq | wc -l)
echo "物理 CPU 数量：$physical_cpu"

# 统计每个 CPU 的核心数量
cores_per_cpu=$(cat /proc/cpuinfo | grep "cores" | uniq | awk '{print $4}')
echo "每个 CPU 的核心数量：$cores_per_cpu"

# 统计逻辑 CPU 总数
total_cpus=$(cat /proc/cpuinfo | grep "processor" | wc -l)
echo "逻辑 CPU 总数：$total_cpus"

# 获取总存储空间
total_storage=$(df -h / | awk 'NR==2{print $2}')
echo "总存储空间：$total_storage"

# 获取可用存储空间
available_storage=$(df -h / | awk 'NR==2{print $4}')
echo "可用存储空间：$available_storage"

# 获取已用存储空间
used_storage=$(df -h / | awk 'NR==2{print $3}')
echo "已用存储空间：$used_storage"

# 使用curl获取外部IP地址
external_ip=$(curl -s ifconfig.me)
echo "机器的外部IP地址：$external_ip"

# 获取机器的 IP 地址
machine_ip=$(hostname -I)
echo "机器的 IP 地址：$machine_ip"