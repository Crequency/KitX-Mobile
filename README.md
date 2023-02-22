# KitX Mobile

Mobile Client for KitX  
Runs on `Android`, `iOS`

## Build project
> **Warning**
> Please use physical devices to debug, any emulator may cause problems.

1. Pass `flutter doctor -v`
2. `[If Live in China Mainland]` Config flutter related SDKs mirror through commands:

   ```SHELL
   set PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
   set FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
   ```

   > Only works in current window. Config system envrionment varieties for permanent.
3. Set system environment varieties `GRADLE_OPTS` to `-Dfile.encoding=UTF-8`.
4. Use `flutter run` to run the project, but you need connect your phone to your computer in adb first.
5. Use `flutter build --split-per-abi` to build the project, remove `--split-per-abi` arguments for flat apk which is much bigger.
6. The output apk is in `/kitx_mobile/build/app/outputs/flutter-apk/` folder.

## 构建项目

> **Warning**
> 在为此仓库作出贡献时，请先阅读 [代码开发规范](code.style.md)

> **Warning**
> 请使用实体机调试，任何模拟器都可能出现不可预料的问题

1. 请尽可能确保 `flutter doctor -v` 通过并尽可能使用最新稳定版本的 flutter sdk
2. 使用 Windows 开发时，可以参考以下命令配置临时 flutter 镜像（仅在当前窗口有效）：

   ```
   set PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
   set FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
   ```

   若要配置永久镜像，请修改系统环境变量
3. 在编译时，如出现输出乱码，请修改系统环境变量 `GRADLE_OPTS` 为 `-Dfile.encoding=UTF-8` 即可解决
4. 使用 `flutter run` 运行项目，但是需要先将手机通过 adb 连接到电脑上
5. 使用 `flutter build --split-per-abi` 构建项目，移除 `--split-per-abi` 参数可以构建出适应多个 CPU 架构的 apk，但是体积会更大
6. 构建出的 apk 位于 `/kitx_mobile/build/app/outputs/flutter-apk/` 文件夹
