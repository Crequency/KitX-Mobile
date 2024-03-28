# KitX Mobile

<a href="https://f-droid.org/packages/com.crequency.kitx.mobile">
    <img align="right" src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" alt="Get it on F-Droid" height="80">
</a>

Mobile Client for [KitX Project](https://github.com/Crequency/KitX)

Runs on `Android`, `iOS`

## Development

> **Warning**
>
> Please use physical devices to debug, any emulator may cause problems.
>
> Android emulators are currently known to experience problems; the situation with iOS simulators is currently unknown.

### Prerequisites

- Flutter SDK
- Android SDK (for Android)
- XCode (for iOS)
- Powershell

### Build project

1. Pass `flutter doctor -v`
2. Set system environment varieties `GRADLE_OPTS` to `-Dfile.encoding=UTF-8` (Optional)
3. Use `flutter run` to run the project
   - For `[Android]` You need connect your phone to your computer in `adb` first.
   - For `[iOS]` Open your `simulator` first or connect your iPhone to your `XCode`.

#### Build release version

> **Warning**
>
> You need run `self-sign-local.ps1` below first to generate a self-signed certificate.
>
> Than you are allowed to build in release mode.

- For `[Android]` : Use `flutter build --split-per-abi` to build the project, remove `--split-per-abi` arguments for flat apk which is much bigger but support more platforms.

  The output apk is in `./kitx_mobile/build/app/outputs/flutter-apk/` folder.

- For `[iOS]` : Build app in `XCode`.

## Tools

- `self-sign-local.ps1`
  - This script helps you generate a self-signed certificate for easy local debugging
  - You need to make sure the `keytool` command is available
- `update-version.py` for both `android` and `iOS`
  - This script changes version number in `pubspec.yaml`.
  - Run this script in `XCode` build phases by add custom script:
    ```shell
    cd ..
    py update-version.py
    ```
- `dependencies-analyzer.py`
  - This script analyze `pubspec.yaml` and update thirdparty data in both mobile and kitx docs.
  - Tow arguments:
    - `--export-for-mobile-about`
    - `--export-for-website-docs` (You can use this only when KitX main repo is fully cloned)
