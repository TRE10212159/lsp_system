# 快速命令参考

## 🚀 最简单的方式

```bash
# 启动 Web 服务器
.\dev.bat web
```

然后在浏览器打开: `http://localhost:8080`

---

## 📋 所有可用命令

### 方式 1: 简单批处理 (推荐 Windows 用户)

```cmd
.\dev.bat web       # 启动 Web Server 模式 (http://localhost:8080)
.\dev.bat chrome    # 使用 Chrome 启动
.\dev.bat edge      # 使用 Edge 启动
.\dev.bat clean     # 清理构建缓存
.\dev.bat build     # 构建生产版本
.\dev.bat install   # 安装依赖
.\dev.bat generate  # 生成 Riverpod 代码
.\dev.bat watch     # 监视并自动生成代码
.\dev.bat kill      # 终止 8080 端口的进程
```

### 方式 2: 更简单的版本

```cmd
# 双击运行或在命令行输入
.\run.bat
```

### 方式 3: PowerShell (功能更丰富)

```powershell
.\scripts\dev.ps1 web       # 启动 Web Server 模式
.\scripts\dev.ps1 chrome    # 使用 Chrome 启动
.\scripts\dev.ps1 clean     # 清理构建缓存
.\scripts\dev.ps1 build     # 构建生产版本
```

### 方式 4: Makefile (跨平台)

```bash
make web          # 启动 Web Server 模式
make web-chrome   # 使用 Chrome 启动
make clean        # 清理构建缓存
make build-web    # 构建生产版本
make kill         # 终止 8080 端口的进程
make help         # 显示所有命令
```

### 方式 5: VS Code 任务

1. 按 `Ctrl + Shift + P`
2. 输入 "Tasks: Run Task"
3. 选择 "Flutter: Web Server で起動"

### 方式 6: 原生 Flutter 命令

```bash
flutter run -d web-server --web-port=8080
```

---

## 🎯 常用场景

### 日常开发

```cmd
# 最简单的方式
.\dev.bat web

# 或者双击
run.bat
```

### 首次运行

```cmd
# 1. 安装依赖
.\dev.bat install

# 2. 生成代码 (如果使用 Riverpod)
.\dev.bat generate

# 3. 启动应用
.\dev.bat web
```

### 遇到问题时

```cmd
# 清理并重新安装
.\dev.bat clean

# 重新启动
.\dev.bat web
```

### 准备部署

```cmd
# 运行测试
flutter test

# 构建生产版本
.\dev.bat build
```

---

## 💡 开发提示

### 热重载

应用运行时，在终端按：
- `r` - 热重载 (快速更新)
- `R` - 热重启 (完全重启)
- `q` - 退出

### 审查元素

1. 在浏览器中按 `F12`
2. 点击 Elements 标签
3. 现在可以查看 HTML 和 CSS 了！

### 自动生成代码

如果你在使用 Riverpod:

```cmd
# 在一个终端运行
.\dev.bat watch

# 在另一个终端运行
.\dev.bat web
```

---

## 🔧 配置

### 更改端口

编辑以下文件中的 `8080`:
- `dev.bat`
- `run.bat`
- `Makefile`
- `.vscode/tasks.json`

### 选择渲染器

`web/index.html` 中已配置使用 HTML 渲染器，可以审查样式。

要切换回 CanvasKit (生产环境推荐)，删除以下代码:

```javascript
window.flutterConfiguration = {
  renderer: 'html'
};
```

---

## 🆘 故障排除

### 命令找不到

确保你在项目根目录:

```cmd
cd D:\Code\lsp_system
.\dev.bat web
```

### 端口被占用

**快速解决:**

```cmd
# 终止占用 8080 端口的进程
.\dev.bat kill

# 或使用通用脚本终止任意端口
.\kill-port.bat 8080
```

**或使用不同的端口:**

```cmd
flutter run -d web-server --web-port=3000
```

### PowerShell 脚本无法执行

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📚 更多文档

- [QUICK_START.md](QUICK_START.md) - 快速开始指南
- [document/開発用コマンド一覧.md](document/開発用コマンド一覧.md) - 详细命令文档
- [document/Flutter Web起動問題の解決方法.md](document/Flutter%20Web起動問題の解決方法.md) - 启动问题解决

---

## ⚡ 速查表

| 需求 | 命令 |
|------|------|
| 快速启动 | `.\dev.bat web` 或双击 `run.bat` |
| 使用 Chrome | `.\dev.bat chrome` |
| 清理缓存 | `.\dev.bat clean` |
| 生产构建 | `.\dev.bat build` |
| 代码生成 | `.\dev.bat generate` |
| 终止端口进程 | `.\dev.bat kill` 或 `.\kill-port.bat 8080` |
| 查看帮助 | `.\dev.bat help` |

---

**推荐**: 对于日常开发，使用 `.\dev.bat web` 是最简单和稳定的方式！

