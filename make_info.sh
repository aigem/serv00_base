#!/bin/bash

# 获取用户名
USERNAME=$(whoami)

# 定义配置文件路径
CONFIG_FILE="/usr/home/$USERNAME/base/$USERNAME.yaml"

# 检查配置文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
    echo "错误：配置文件不存在。"
    exit 1
fi

# 检查是否安装了 yq，如果没有则提示安装
if ! command -v yq &> /dev/null; then
    echo "错误：未找到 yq 命令。请安装 yq 以解析 YAML 文件。"
    echo "可以使用 'npm install -g yq' 来安装。"
    exit 1
fi

# 使用 yq 读取配置文件内容
APP_PORT=$(yq e '.port' "$CONFIG_FILE")
WEBSITE_NAME=$(yq e '.your_website' "$CONFIG_FILE")
PROJECT_NAME=$(yq e '.project_name' "$CONFIG_FILE")

# 在生成 HTML 内容前添加检查
if [ -z "$APP_PORT" ] || [ -z "$WEBSITE_NAME" ] || [ -z "$PROJECT_NAME" ]; then
    echo "错误：无法从配置文件中读取所需信息。"
    exit 1
fi

# 生成 HTML 内容
cat << EOF > info.html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>部署信息</title>
    <style>
        /* ... 保持原有样式 ... */
    </style>
</head>
<body>
    <h1>部署成功！</h1>
    <p>您的应用已成功部署。以下是关键配置信息：</p>
    <ul>
        <li>项目名称：<span class="highlight">$PROJECT_NAME</span></li>
        <li>端口号：<span class="highlight">$APP_PORT</span></li>
        <li>网站域名：<span class="highlight">$WEBSITE_NAME</span></li>
    </ul>
    
    <h2>注意事项</h2>
    <ul>
        <li>请将您的程序文件放置在目录：<span class="highlight">/usr/home/$USERNAME/$PROJECT_NAME</span> 下。</li>
        <li>使用 <code>pm2</code> 命令来启动您的程序，例如：
            <pre>pm2 start your_app.js --name $PROJECT_NAME --port $APP_PORT</pre>
        </li>
        <li>您的后台程序运行的端口号为：<span class="highlight">$APP_PORT</span></li>
        <li>PM2运行程序成功后，访问程序域名为：<span class="highlight">$WEBSITE_NAME</span></li>
    </ul>
    
    <h2>下一步操作</h2>
    <ol>
        <li>修改配置文件中的 Project name (可不修改)</li>
        <li>将您的程序文件放置在指定目录：/usr/home/$USERNAME/$PROJECT_NAME 下</li>
        <li>使用 pm2 命令启动您的程序</li>
        <li>访问 $WEBSITE_NAME 查看您的应用</li>
    </ol>
    
    <p>如需更多帮助，请参考文档或联系管理员。</p>
</body>
</html>
EOF

# 在 HTML 内容中添加更多有用信息
cat << EOF >> info.html
    <h2>常用命令</h2>
    <ul>
        <li>查看应用日志：<code>pm2 logs $PROJECT_NAME</code></li>
        <li>重启应用：<code>pm2 restart $PROJECT_NAME</code></li>
        <li>停止应用：<code>pm2 stop $PROJECT_NAME</code></li>
        <li>查看应用状态：<code>pm2 status</code></li>
        <li>查看所有应用：<code>pm2 list</code></li>
    </ul>
    <h2>查看详细信息，请访问我的Github: <a href="https://github.com/aigem/serv00_base">Github</a></h2>
    
EOF

# 在文件末尾添加
echo "info.html 文件已生成。"