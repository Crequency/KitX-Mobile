# KitX Mobile

Mobile Client for KitX

Runs on `Android`, `iOS`

## Build project

> **Warning**
> Please use physical devices to debug, any emulator may cause problems.
> Android emulators are currently known to experience problems; the situation with iOS simulators is currently unknown.

1. Pass `flutter doctor -v`
2. `[China Mainland Developer]` Config flutter related SDKs mirror through commands:

   ```shell
   set PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
   set FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
   ```

   > Only works in current session. Config system envrionment varieties for permanent effect.
3. Set system environment varieties `GRADLE_OPTS` to `-Dfile.encoding=UTF-8`.
4. Run `init_packages.sh/ps1` to fetch packages.
5. Use `flutter run` to run the project
   - `[Android]` You need connect your phone to your computer in `adb` first.
   - `[iOS]` Open your `simulator` first or connect your iPhone to your `XCode`.
6. `[Android]` Use `flutter build --split-per-abi` to build the project, remove `--split-per-abi` arguments for flat apk which is much bigger but support more platforms.
   - We suggest your to run `build.py` instead.
   - `[iOS]` Build app in `XCode`.
7. `[Android]` The output apk is in `/kitx_mobile/build/app/outputs/flutter-apk/` folder.

## Tools

- `update-version.py` for both `android` and `iOS`
  - This script changes version number in `pubspec.yaml`.
  - Run this script in `XCode` build phases by add custom script:
    ```shell
    cd ..
    python3 update-version.py
    ```
- `dependencies-analyzer.py`
  - This script analyze `pubspec.yaml` and update thirdparty data in both mobile and kitx docs.
  - Tow arguments:
    - `--export-for-mobile-about`
    - `--export-for-website-docs`
