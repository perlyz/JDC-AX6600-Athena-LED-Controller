# LuCI App for Athena LED Controller

[English](#english) | [简体中文](#简体中文)



---

<a name="简体中文"></a>
## 🇨🇳 简体中文说明

**京东云无线宝 AX6600 (雅典娜) LED 控制器的 OpenWrt Web (LuCi) 管理界面。**

本项目为 `athena-led` (Rust 版) 提供了可视化的 LuCI 配置界面。

### 📦 快速安装 (推荐)

普通用户**无需**自行编译，直接使用我们提供的安装包即可。

1.  从 **[Releases (发行版)](../../releases)** 下载 `luci-app-athena-led_x.x.x_all.ipk`。
2.  上传文件到路由器。
3.  执行安装：
    ```bash
    opkg install luci-app-athena-led_*.ipk
    ```
4.  进入 **服务 -> Athena LED** 进行配置。

### ✨ 功能特点
* **可视化配置**: 支持拖拽排序、亮度调节。
* **高级监控**: 网络、天气、系统状态一键配置。
* **智能休眠**: 零负载定时休眠。
* **服务控制**: 网页端控制服务启停。

### 🔨 源码编译 (高级)
*仅适用于需要集成到自编译固件的开发者。*

1.  **准备环境**: 使用适用于 `ipq60xx/ax6600` 的 OpenWrt SDK。
2.  **添加插件**: 将仓库根目录克隆到 OpenWrt 的 `package/luci-app-athena-led/`。
3.  **编译**:
    ```bash
    make package/luci-app-athena-led/compile
    ```
    *(注意: 构建时会直接使用仓库内附带的 `athena-led/` Rust 源码本地编译。)*




---

<a name="english"></a>
## 🇬🇧 English Description

**The OpenWrt Web Interface (LuCI) for the JDCloud AX6600 LED Controller.**

This package provides a user-friendly graphical interface to configure the `athena-led` Rust backend.

### 📦 Quick Installation (Recommended)

You do **not** need to compile this manually. We provide ready-to-use packages.

1.  Download `luci-app-athena-led_x.x.x_all.ipk` from **[Releases](../../releases)**.
2.  Upload to your router.
3.  Install:
    ```bash
    opkg install luci-app-athena-led_*.ipk
    ```
4.  Go to **Services -> Athena LED** to configure.

### ✨ Key Features
* **Visual Config**: Drag & drop module sorting.
* **Advanced Monitor**: Configure Network, Weather, and System stats.
* **Smart Sleep**: Zero-load sleep scheduling.
* **Service Control**: Restart/Stop service from UI.

### 🔨 Compilation (Advanced)
*Only for developers building custom firmware.*

1.  **Prepare SDK**: Use OpenWrt SDK for `ipq60xx/ax6600`.
2.  **Add Package**: Clone the repository root into `package/luci-app-athena-led/`.
3.  **Compile**:
    ```bash
    make package/luci-app-athena-led/compile
    ```
    *(Note: The build uses the bundled `athena-led/` Rust sources and compiles them locally.)*

## 依赖说明

* `luci-base`
* `lua`
* `athena-led` (Rust source, built locally during package compilation)

## License

Apache License 2.0
