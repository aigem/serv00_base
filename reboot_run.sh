#!/bin/bash

# 系统重启后运行本脚本。

# 定义用户目录
USER_HOME="/usr/home/$(whoami)"
BASH_PROFILE="$USER_HOME/.bash_profile"
CONFIG_FILE="$USER_HOME/base/$(whoami).yaml"

# 检查是否安装了 yq，如果没有则提示安装
if ! command -v yq &> /dev/null; then
    echo "错误：未找到 yq 命令。请安装 yq 以解析 YAML 文件。"
    echo "可以使用 'npm install -g yq' 来安装。"
    exit 1
fi

# 使用 yq 读取配置文件内容
APP_PORT=$(yq e '.port' "$CONFIG_FILE")
PROJECT_NAME=$(yq e '.project_name' "$CONFIG_FILE")
PYTHON_VIRTUALENV=$(yq e '.python_virtualenv' "$CONFIG_FILE")

# 添加新的环境变量条目到 .bash_profile
if ! grep -q 'export PATH="$USER_HOME/node_modules/pm2/bin:$PATH"' "$BASH_PROFILE"; then
    echo "export PATH=\"$USER_HOME/node_modules/pm2/bin:\$PATH\"" >> "$BASH_PROFILE"
fi

if ! grep -q 'export CFLAGS="-I/usr/local/include"' "$BASH_PROFILE"; then
    echo 'export CFLAGS="-I/usr/local/include"' >> "$BASH_PROFILE"
fi

if ! grep -q 'export CXXFLAGS="-I/usr/local/include"' "$BASH_PROFILE"; then
    echo 'export CXXFLAGS="-I/usr/local/include"' >> "$BASH_PROFILE"
fi

# 重新加载 .bash_profile
source "$BASH_PROFILE"

# 激活虚拟环境,先检查是否存在。如果不存在则创建并安装requirements.txt中的依赖。
if [ -d "$PYTHON_VIRTUALENV" ]; then
    source "$PYTHON_VIRTUALENV/bin/activate"
else
    echo "虚拟环境不存在，正在创建..."
    virtualenv "$PYTHON_VIRTUALENV"
    source "$PYTHON_VIRTUALENV/bin/activate"
    pip install -r "$USER_HOME/$PROJECT_NAME/requirements.txt"
fi

# 安装 pm2
if ! command -v pm2 &> /dev/null; then
    npm install -g pm2
    if [ $? -ne 0 ]; then
        echo "PM2安装失败，请检查npm是否正确安装"
        exit 1
    fi
fi

# 重启 pm2
pm2 resurrect

sleep 5

# resurrect后检查指定项目是否启动
if ! pm2 list | grep -q "$PROJECT_NAME"; then
    echo "项目 $PROJECT_NAME 未启动，正在尝试启动..."
    # 假设项目在 $USER_HOME/$PROJECT_NAME 目录下
    cd "$USER_HOME/$PROJECT_NAME"
    pm2 restart $PROJECT_NAME --interpreter python -- --port $APP_PORT
    
    if [ $? -ne 0 ]; then
        echo "项目启动失败，请检查配置和代码"
        exit 1
    fi
fi

# 一段时间后检查项目是否仍然运行
sleep 10

# 如果项目仍然没有启动，则尝试运动通知流程
if ! pm2 list | grep -q "$PROJECT_NAME"; then
    # 这里需要根据实际情况修改通知命令  
fi