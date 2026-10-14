import re

from datetime import datetime, timezone

file_pubspec = "./pubspec.yaml"
major_version = "24.10"

# 历史背景：旧版 android/app/build.gradle 会把 versionCode 记为 build * 10 + ABI 码，
# 所以已发布的 arm64 版本 versionCode 达到过 5643（当时 build = 564）。
# Flutter 现在的规则是：通用 APK 直接用 build，split APK 用 build + 1000 * abiIndex
# （armeabi-v7a=1、arm64-v8a=2、x86_64=4）。
# 因此 build 必须整体高于历史值，才能让所有形态的 versionCode 都严格递增、
# 升级路径不回退。这里把基准定为 10000，再按天单调递增；
# 同时不再对天数取模，避免长期运行后 versionCode 回绕。
BUILD_NUMBER_BASE = 10000

def calculateLatestVersionBuildNumber():
    current_utc = datetime.now(timezone.utc)
    specified_time = datetime(2022, 8, 18, tzinfo=timezone.utc)
    delta_days = (current_utc - specified_time).days
    return str(BUILD_NUMBER_BASE + delta_days)

def calculateThirdVersionField():
    now_utc = datetime.now(timezone.utc)
    start_of_year_utc = datetime(now_utc.year, 1, 1, tzinfo=timezone.utc)
    days_passed_this_year = (now_utc - start_of_year_utc).days
    return str(days_passed_this_year)

def updateVersion():
    ver = calculateLatestVersionBuildNumber()
    pattern = re.compile(r"^version: \d+.\d+.\d+\+\d+(-[a-zA-Z0-9-]+)?$")
    temp_lines = []

    # 显式使用 UTF-8：pubspec.yaml 含中文注释，而 Windows 上 open() 默认走系统
    # locale 编码（GBK），不指定会直接解码失败。
    with open(file_pubspec, "r+", encoding="utf-8") as file:
        for line in file:
            match = re.match(pattern, line)
            if match:
                append = match.group(1)

                if match.group(1) == None:
                    append = ""

                new_line = pattern.sub(
                    "version: " + major_version + "." + calculateThirdVersionField() + "+" + ver + append,
                    line
                )

                temp_lines.append(new_line)
            else:
                temp_lines.append(line)

    with open(file_pubspec, "w", encoding="utf-8") as file:
        file.writelines(temp_lines)

if __name__ == "__main__":
    updateVersion()
