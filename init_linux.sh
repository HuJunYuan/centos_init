#!/bin/bash

# init 
PROJ_DIR=`pwd`

# update system and install basic sofware
yum update -y;
yum install epel-release -y;
yum update -y;
yum install tmux vim git wget -y;

# create .bash_alias
cd ~/
touch .bash_aliases
echo 'source .bash_aliases' >> .bashrc

echo 'alias vi="vim -p"' >> .bash_aliases
echo 'alias fd="find ./ -name"' >> .bash_aliases 
echo 'alias grep="grep --color=auto"'  >> .bash_aliases
source .bashrc

# config tmux and vim
if [ -f "$PROJ_DIR/tmux.conf" ]; then
    echo "配置tmux"
    cp $PROJ_DIR/tmux.conf ~/.tmux.conf
fi

if [ -f "$PROJ_DIR/vimrc" ]; then
    echo "配置vim"
    cp $PROJ_DIR/vimrc ~/.vimrc
fi

# 读取输入，判断是否需要安装前端相关应用： nodejs
echo "需要安装前端开发环境吗, 输入任意字符安装,直接回车跳过？"
read FRONTEN_DEV
if [ $FRONTEN_DEV ];then
    echo "正在安装nodejs，请稍候"
    yum install nodejs -y;
    echo "正在安装n，请稍候"
    npm install -g n;
    echo "正在安装最新版本nodejs，请稍候"
    n lts;
else
    echo "未安装nodejs"
fi
