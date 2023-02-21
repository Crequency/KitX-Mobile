import os
import sys

from os import listdir
from os.path import isfile, join

print("entry args: ", sys.argv)

skipFlutterBuild = False

for arg in sys.argv:
    if (arg.lower() == "--skip-flutter-build"):
        skipFlutterBuild = True

commands = [
    "mkdir .ci_cd",
    "flutter pub get",
    "flutter build apk --split-per-abi",
    "flutter build apk",
    "cp build/app/outputs/flutter-apk/*.apk .ci_cd/",
    "cp build/app/outputs/flutter-apk/*.sha1 .ci_cd/",
]

if not skipFlutterBuild:
    for command in commands:
        print(">>> " + command)
        print(os.system(command))

path = ".ci_cd/"

files = [f for f in listdir(path) if isfile(join(path, f))]

data = "{ \"publish_list\": [%items%] }"
items = ""

index = 0
for file in files:
    newName = file.replace("app", "kitx-mobile")
    os.rename(path + file, path + newName)
    items += "\"" + path + newName + "\"" + \
        ("" if index == len(files) - 1 else ",")
    print(file + " -> " + newName)
    index += 1

data = data.replace("%items%", items)

print(data)

df = open("data.json", "w")
df.write(data)
df.close()
