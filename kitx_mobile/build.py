import os

from os import listdir
from os.path import isfile, join

commands = [
    "mkdir .ci_cd",
    "flutter pub get",
    "flutter build apk --split-per-abi",
    "flutter build apk",
    "cp build/app/outputs/flutter-apk/*.apk .ci_cd/",
    "cp build/app/outputs/flutter-apk/*.sha1 .ci_cd/",
]

for command in commands:
    print(">>> " + command)
    print(os.system(command))

path = ".ci_cd/"

files = [f for f in listdir(path) if isfile(join(path, f))]

for file in files:
    newName = file.replace("app", "kitx-mobile")
    os.rename(path + file, path + newName)
    print(file + " -> " + newName)
