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

1. 在命令行中连接您的 serv00 的 ssh 服务器
    ```bash
    ssh sevr00用户名@sevr00用户名.serv00.net
    ```
以上信息注册成功后收到的邮件中查看

2. 克隆仓库并进入项目目录：
   ```bash
   rm -rf serv00_base && git clone https://github.com/aigem/serv00_base.git && cd serv00_base
   bash setup.sh
   ```

3. 按照提示完成配置过程

4. 安装完成后，访问生成的 info.html 页面查看部署详情

## 配置文件说明

安装过程会在 `/usr/home/你的用户名/base/你的用户名.yaml` 生成一个配置文件，包含以下关键信息：

- `project_name`: 项目名称
- `port`: 应用程序运行的端口号
- `your_website`: 绑定的域名
- `python_virtualenv`: Python 虚拟环境路径（如果适用）
- `python_virtualenv_name`: Python 虚拟环境名称（如果适用）
……

## 示例应用

安装过程会部署一个基于 Flask 的示例应用。您可以在 `/usr/home/你的用户名/项目名称(默认为app)/` 目录下找到并修改这个应用。

## 自定义应用部署

要部署您自己的应用：

1. 将可在nodejs、python、rust、go、java等语言编写的程序放在 `/usr/home/你的用户名/项目名称(默认为app)/` 下
2. 安装你程序的依赖（ssh 连接到服务器安装相关依赖。只能部署小项目，大项目免费的serv00部署不了）
```bash
pip install -r requirements.txt
或
npm install
```
3. 使用 pm2 命令启动您的程序
4. 运行的端口必须为一键安装时绑定的端口
5. 访问 绑定的域名 查看您的应用


4. 使用 PM2 重新启动应用：
   ```bash
   pm2 restart 项目名称(默认为app)
   ```

## 常见问题解决

- 应用无法启动：检查 PM2 日志 `pm2 logs`
- 端口冲突：确保您的应用监听的是配置文件中指定的端口
- 依赖问题：检查虚拟环境是否正确激活（对于 Python 应用）

## 故障排除

如果在安装或使用过程中遇到问题,请尝试以下步骤:

1. 检查日志文件：
待完善

2. 确保所有必要的依赖都已正确安装：
   ```bash
   npm list
   pip list
   ```

3. 验证配置文件是否正确：
   ```bash
   cat /usr/home/你的用户名/base/你的用户名.yaml
   ```

4. 检查 PM2 进程状态：
   ```bash
   pm2 list
   pm2 logs
   ```

如果问题仍然存在,请在 GitHub 上提交 issue,并附上相关日志和错误信息。

## 安全注意事项

- 定期更新您的应用程序和依赖项
- 不要在代码中硬编码敏感信息(如密码、API密钥等)
- 使用环境变量来存储敏感信息
- 确保您的应用程序对用户输入进行适当的验证和清理

## 性能优化提示

- 使用 PM2 的集群模式来充分利用多核 CPU
- 对于 Python 应用,考虑使用 Gunicorn 作为 WSGI 服务器
- 实现适当的缓存策略以减少数据库查询
- 优化静态资源(如压缩和缓存 JavaScript 和 CSS 文件)

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
- 邮箱: [fuliai@outlook.com](mailto:fuliai@outlook.com)

感谢您使用 serv00_base！祝您在 serv00 上享受愉快的部署体验！
