import re

from datetime import datetime, timezone

file_pubspec = "./pubspec.yaml"
major_version = "3.23.04"

def calculateLatestVersionBuildNumber():
    current_utc = datetime.now(timezone.utc)

    specified_time = datetime(2020, 10, 7, tzinfo=timezone.utc)

    delta_days = (current_utc - specified_time).days

    build_version_code = delta_days % 65535 + 5602

    return str(build_version_code)

def updateVersion():
    ver = calculateLatestVersionBuildNumber()
    pattern = re.compile(r"^version: \d.\d.\d\+\d$")
    temp_lines = []
    
    with open(file_pubspec, "r") as file:
        for line in file:
            new_line = pattern.sub(
                "version: " + major_version + "+" + ver,
                line
            )
            temp_lines.append(new_line)
            
    with open(file_pubspec, "w") as file:
        file.writelines(temp_lines)

if __name__ == "__main__":
    updateVersion()
