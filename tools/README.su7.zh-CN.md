# SU7 Ultra 工作环境与换电脑恢复

本仓库现在同时保存开发代码、原始两车、生成的空悬/绞牙两车、CSP 观测包、原型解包数据、公开依据和模拟输出。二进制资源通过 Git LFS 保存；物理与已校验源码按原字节保留，避免 CRLF 转换破坏 SHA256。Python 运行库和缓存不提交，在新电脑重建本地环境。

- `tools/car/msk_stw_xiaomi_su7_ultra - 2.0`：原量产车完整目录，包括原备份文件。
- `tools/car/negi_su7_ultra_prototype`：原型车完整目录。
- `tools/su7-mod/dist/content/cars`：生成的新空悬和绞牙两车。
- `tools/su7-sim/csp-shadow`：现有观测包；`prototype-data`、references 和 outputs 保留当前分析进度。

两套原始车与两套新车、观测/解包数据合计约 2.58 GB，内容去重约 1.12 GB；完整清单与哈希见 `su7-mod/asset-manifest.json`。大文件机制参考 [GitHub Git LFS 说明](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)。需要正常 clone 和 Git LFS 下载，不能把 GitHub 普通源码 ZIP 或 LFS 指针当成完整车型。

## 新电脑首次恢复

1. 安装 Git、Git LFS 和带 Tkinter 的 Python。需要 Python 3.11 以上，当前验证使用 3.12。
2. 克隆现有仓库，然后执行恢复入口：

```powershell
git lfs install
git clone https://github.com/elmagnificogi/ACRecord2AILine.git
cd ACRecord2AILine
py -3.12 tools/su7-mod/restore_workspace.py
```

也可双击 `tools/su7-mod/Restore_SU7.cmd`。恢复脚本会初始化仓库 LFS、下载真实资源、核对每个文件的 SHA256，在仓库根目录建立 `.venv` 并安装 requirements，最后运行核心、接口和生成包核查。网络下载或校验失败会停止，不会把指针当成成功恢复。

3. 双击 `tools/su7-mod/Configure_SU7.cmd`。它优先使用仓库 `.venv`，不再依赖原电脑的 E 盘项目路径或 D 盘 Python。
4. 继续开发或按 `su7-mod/README.zh-CN.md` 将两辆新车复制进 AC。

只检查本地资源，不下载或安装环境：

```powershell
py -3.12 tools/su7-mod/restore_workspace.py --verify-only
```

这套恢复不安装 Assetto Corsa、CSP 或游戏字体。车辆配置引用 `xiaomievsans`，当前原车目录未包含该外部字体，新电脑的游戏安装仍需补齐原 mod 的字体依赖。资源哈希通过也不代表游戏加载和主动电控已验证。

## 后续改动的保存

正常修改代码和车型参数后，重新生成所需车包。若更新模型、轮胎、观测包或模拟输出，应有意刷新资产清单并一起提交：

```powershell
.\.venv\Scripts\python.exe -X utf8 tools/su7-mod/verify_assets.py --refresh
git add .
git commit -m "Update SU7 development workspace"
git push origin main
```

`git push` 会通过 LFS pre-push hook 上传资源对象。只有 Git 提交和 LFS 对象都已同步远端，另一台电脑才可完整拉取；本地 commit 本身不会把文件传过去。另一台电脑更新使用 `git pull` 和 `git lfs pull`，随后运行 `verify_assets.py` 检查资源。

`.venv`、`.runtime`、`__pycache__` 和下载缓存继续忽略，不跨机复制 ABI 绑定的运行库。`csp-active-bench` 未生成且仍排除；只有真实执行器标定后才能进入该实验分支。

当前开发版的 TC 接入原生实验映射；ESC/TVC 只预测。30 项核心、13 项模拟接口、412 项默认包检查已通过，尚未进入 AC 实测。
