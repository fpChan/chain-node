zsh_config(){
    # 0. download zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

    # 2. set bira theme
    #  > ~/.zshrc.tmp
    sed -i "s/ZSH_THEME=.*/ZSH_THEME=\"bira\"/" $HOME/.zshrc
    sed -i "s/^plugins=(.*)$/plugins=( \n git z copypath copyfile copybuffer jsontools history \n zsh-autosuggestions \n zsh-syntax-highlighting \n zsh-history-substring-search \n)/" $HOME/.zshrc
    echo 'export PATH=$PATH:/usr/local/bin/' >> $HOME/.zshrc
}

install_docker(){
    apt update
    apt upgrade -y
    apt install -y ca-certificates curl gnupg lsb-release
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

# 检查并安装Node.js和npm
install_nodejs_npm() {
    if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
        echo "Node.js或npm未安装，正在安装..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install node # 安装最新版本的Node.js和npm
        nvm use node
        echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc
        echo "Node.js和npm安装完毕。"
    else
        echo "Node.js和npm已安装。"
    fi
}

install_go(){
    gotar="go1.22.2.linux-amd64.tar.gz"
    wget https://go.dev/dl/$gotar
    rm -rf /usr/local/go && tar -C /usr/local -xzf $gotar
    sed -i '1 a export PATH=$PATH:/usr/local/go/bin' $HOME/.zshrc
}

change_docker_dir(){
    newpath=/data/docker
    docker info | grep "Docker Root Dir"
    service docker stop
    mkdir -p $newpath
    mv /var/lib/docker $newpath
    ln -sf $newpath /var/lib/docker
    service docker start
}

install_docker
change_docker_dir
install_nodejs_npm
install_go
zsh_config