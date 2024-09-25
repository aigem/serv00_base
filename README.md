# serv00_base

serv00_base 是一个专为 serv00 免费主机设计的强大自动化部署工具。它能帮助用户在 serv00 上快速部署各种应用程序，包括 Node.js、Python、Go 和 Rust 等。

## 主要特性

- 一键式自动化部署流程，大幅简化 serv00 上的应用程序安装
- 广泛支持多种主流编程语言和框架
- 智能配置端口和域名绑定，无需手动操作
- 深度集成 PM2 进程管理器，确保应用程序 24/7 稳定运行
- 自动生成详细的部署信息页面，便于用户实时监控和管理
- 内置 Python 虚拟环境支持，有效隔离项目依赖
- 自动配置重启任务，保证服务器重启后应用程序自动恢复运行

## 使用前提

- 拥有 serv00 免费主机账号
- 具备基本的命令行操作能力

## 快速开始

1. 登录您的 serv00 账户

2. 克隆仓库并进入项目目录：
   ```bash
   git clone https://github.com/aigem/serv00_base.git
   cd serv00_base
   ```

3. 安装依赖：
   ```bash
   npm install
   ```

4. 运行安装脚本：
   ```bash
   bash setup.sh
   ```

5. 按照提示完成配置过程

6. 安装完成后，访问生成的 info.html 页面查看部署详情

## 配置文件说明

安装过程会在 `/usr/home/你的用户名/base/你的用户名.yaml` 生成一个配置文件，包含以下关键信息：

- `project_name`: 项目名称
- `port`: 应用程序运行的端口号
- `your_website`: 绑定的域名
- `python_virtualenv`: Python 虚拟环境路径（如果适用）

## 示例应用

安装过程会部署一个基于 Flask 的示例应用。您可以在 `/usr/home/你的用户名/app/` 目录下找到并修改这个应用。

## 自定义应用部署

要部署您自己的应用：

1. 将您的应用文件放在 `/usr/home/你的用户名/app/` 目录下
2. 修改 `app.py`（对于 Python 应用）或创建您的主应用文件
3. 更新 `requirements.txt`（对于 Python 应用）或安装所需的依赖
4. 使用 PM2 重新启动应用：
   ```bash
   pm2 restart app
   ```

## 常见问题解决

- 应用无法启动：检查 PM2 日志 `pm2 logs`
- 端口冲突：确保您的应用监听的是配置文件中指定的端口
- 依赖问题：检查虚拟环境是否正确激活（对于 Python 应用）

## 注意事项

- 请勿修改 `reboot_run.sh` 文件，它确保服务器重启后您的应用能自动启动
- 定期备份您的应用程序和数据
- 遵守 serv00 的使用条款和政策

## 文件结构

```
serv00_base/
├── README.md           # 项目说明文档
├── setup.sh            # 主安装脚本
├── make_info.sh        # 生成信息页面的脚本
├── reboot_run.sh       # 重启任务脚本
├── sample_app/         # 示例应用目录
│   ├── app.py          # 示例 Flask 应用
│   └── requirements.txt # Python 依赖列表
└── package.json        # Node.js 项目配置文件
```

## 贡献指南

我们欢迎并感谢任何形式的贡献！如果您想为项目做出贡献，请遵循以下步骤：

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 许可证

本项目采用 MIT 许可证。详情请见 [LICENSE](LICENSE) 文件。

## 联系方式

如有任何问题或建议，请通过以下方式联系我们：

- 项目 Issues: [https://github.com/aigem/serv00_base/issues](https://github.com/aigem/serv00_base/issues)
- 邮箱: [your-email@example.com](mailto:your-email@example.com)

感谢您使用 serv00_base！祝您在 serv00 上享受愉快的部署体验！
