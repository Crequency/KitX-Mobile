import re

from datetime import datetime, timezone

file_pubspec = "./pubspec.yaml"
major_version = "24.10"

def calculateLatestVersionBuildNumber():
    current_utc = datetime.now(timezone.utc)
    specified_time = datetime(2022, 8, 18, tzinfo=timezone.utc)
    delta_days = (current_utc - specified_time).days
    build_version_code = delta_days % 65535
    return str(build_version_code)

def calculateThirdVersionField():
    now_utc = datetime.now(timezone.utc)
    start_of_year_utc = datetime(now_utc.year, 1, 1, tzinfo=timezone.utc)
    days_passed_this_year = (now_utc - start_of_year_utc).days
    return str(days_passed_this_year)

def updateVersion():
    ver = calculateLatestVersionBuildNumber()
    pattern = re.compile(r"^version: \d+.\d+.\d+\+\d+(-[a-zA-Z0-9-]+)?$")
    temp_lines = []

    with open(file_pubspec, "r+") as file:
        for line in file:
            match = re.match(pattern, line);
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

    with open(file_pubspec, "w") as file:
        file.writelines(temp_lines)

if __name__ == "__main__":
    updateVersion()
