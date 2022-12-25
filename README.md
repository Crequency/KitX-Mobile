# KitX Mobile

Mobile Client for KitX  
Runs on `Android`, `iOS`

## Tip:

> **Warning**
> Please use physical devices to debug, any emulator may cause problems.

1. Pass `flutter doctor -v`
2. `[If Live in China Mainland]` Config flutter related SDKs mirror through commands:
   ```SHELL
   set PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
   set FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
   ```
   > Only works in current window. Config system envrionment varieties plz.
3. Set system environment varieties `GRADLE_OPTS` to `-Dfile.encoding=UTF-8`.
4. After changing any files in `/kitx_mobile/assets`, run `/kitx_mobile/cmds.bat` to avoid errors in reading.
5. Any other problems may be solved by running `/kitx_mobile/cmds.bat`.

## 提示:

> **Warning**
> 在为此仓库作出贡献时，请先阅读 [代码开发规范](代码开发规范.md)

> **Warning**
> 请使用实体机调试，任何模拟器都可能出现不可预料的问题

1. ~~请先检查您的 Flutter 版本为 3.3.3 且~~（非必须步骤，但可能出问题） `flutter doctor -v` 通过
2. 使用 Windows 开发时，可以参考以下命令配置临时 flutter 镜像（仅在当前窗口有效）：
   ```
   set PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
   set FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
   ```
   若要配置永久镜像，请修改系统环境变量
3. 在编译时，如出现输出乱码，请修改系统环境变量 `GRADLE_OPTS` 为 `-Dfile.encoding=UTF-8` 即可解决
4. 在更改 assets 文件夹内容以后，必须运行 `kitx_mobile/cmds.bat` 以保证 assets 读取不出错
5. 在遇到任何问题时也可以运行 `kitx_mobile/cmds.bat` 尝试解决
