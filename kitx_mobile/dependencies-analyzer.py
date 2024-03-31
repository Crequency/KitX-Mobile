import sys
import yaml # pip install pyyaml
import requests # pip install requests
import json
import re

def max(a, b): return a if a > b else b

def writeIn(writtenPath, writtenTags, data):
    for file in writtenPath:
        with open(file, "r+") as stream:
            lines = stream.readlines()

            writtenIn = ""

            beginIndex = -1
            endIndex = -1
            index = 0

            for line in lines:
                if line.find(writtenTags[0]) != -1:
                    beginIndex = index
                if line.find(writtenTags[1]) != -1:
                    endIndex = index
                index += 1

            for i in range(0, beginIndex + 1):
                writtenIn += lines[i]
            for line in data:
                writtenIn += line + "\n"
            for i in range(endIndex, len(lines)):
                writtenIn += lines[i]

            print(writtenIn)

            if input("Do you want to write this in `{}` ? (y/n) ".format(file)).lower() != "n":
                stream.seek(0)
                stream.write(writtenIn)
                stream.truncate()
                print("Written in `{}` !".format(file))

def main():
    export_for_mobile_about = False
    export_for_website_docs = False
    file_pubspec = "./pubspec.yaml"

    mobile_about_format = """  ThirdPartyData(
        '{}',
        '{}',
        '{}',
        '{}',
        '{}',
    ),"""
    website_docs_format = "        <L n=\"{}\" v=\"{}\" u=\"{}\" />"

    mobile_about_tags = ["// Begin ThirdPartyDataList", "// End ThirdPartyDataList"]
    website_docs_tags = ["<!--Begin PackagesTable-->", "<!--End PackagesTable-->"]

    mobile_about_path = ["./lib/data/third_party_licenses_provider.dart"]
    website_docs_path = [
        "../../../KitX Docs/docs/mobile/guide/packages.md",
        "../../../KitX Docs/docs/en/mobile/guide/packages.md",
    ]

    for arg in sys.argv:
        if arg == "--export-for-mobile-about":
            export_for_mobile_about = True
        if arg == "--export-for-website-docs":
            export_for_website_docs = True

    with open(file_pubspec, "r") as stream:
        data = yaml.load(stream, Loader=yaml.FullLoader)
        dependencies = data["dependencies"]

        result_docs, result_mobile = [], []

        for dependency in dependencies:
            name = dependency
            version = ""

            if type(dependencies[name]) is str:
                version = dependencies[name]
            else:
                version = ""
                if name == "flutter":
                    version = "^" + re.search(">=(\S*) <", data["environment"]["sdk"]).group(1)

            print("({}/{}) Fetching `{}` ...".format(max(len(result_docs), len(result_mobile)), len(dependencies.keys()), name))

            url_pub = "https://pub.dev/packages/" + name
            url_pub_api = "https://pub.dev/api/packages/" + name
            url_github = ""

            author_name = ""
            description = ""

            pub_result = requests.get(url_pub_api)
            pub_result_analyzed = json.loads(pub_result.text)

            pubspec = pub_result_analyzed["latest"]["pubspec"]

            if "repository" in pubspec.keys():
                url_github = pubspec["repository"]
                if url_github.find("github"):
                    author_name = re.search("github.com/(\S*)/", url_github).group(1).split('/')[0]

            if "description" in pubspec.keys():
                description = pubspec["description"]

            if export_for_mobile_about:
                result_mobile.append(mobile_about_format.format(name, version, author_name, url_pub, url_github))
            if export_for_website_docs:
                result_docs.append(website_docs_format.format(name, version, description))

        print("({}/{}) All fetched !".format(max(len(result_docs), len(result_mobile)), len(dependencies.keys())))

        if export_for_mobile_about:
            writeIn(mobile_about_path, mobile_about_tags, result_mobile)

        if export_for_website_docs:
            writeIn(website_docs_path, website_docs_tags, result_docs)

if __name__ == "__main__":
    main()
