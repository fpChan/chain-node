#!/bin/bash
NEW_PORT=24
PUB_KEY=""

install_dep(){
    apt-get update
    apt-get install -y git gcc g++ zsh aria2 make net-tools tmux jq pigz
}


change_zsh(){
    chsh -s /usr/bin/zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}
change_ssh(){
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup

    # 修改 SSH 配置文件中的端口号
    sed -i "s/#Port 22/Port $NEW_PORT/" /etc/ssh/sshd_config

    # 启动 SSH 服务
    systemctl start ssh
}

install_dep
change_zsh
