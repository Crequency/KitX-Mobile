import sys
import yaml # pip install pyyaml
import requests # pip install requests
import json
import re

export_for_mobile_about = False
export_for_website_docs = False
file_pubspec = "./pubspec.yaml"

for arg in sys.argv:
    if arg == "--export-for-mobile-about":
        export_for_mobile_about = True
        export_for_website_docs = False
    if arg == "--export-for-website-docs":
        export_for_website_docs = True
        export_for_mobile_about = False

with open (file_pubspec, "r") as stream:
    data = yaml.load(stream, Loader=yaml.FullLoader)
    dependencies = data["dependencies"]
    for dependency in dependencies:
        name = dependency
        version = dependencies[name]
        url_pub = "https://pub.dev/packages/" + name
        url_pub_api = "https://pub.dev/api/packages/" + name
        url_github = ""
        author_name = ""
        description = ""
        pub_result = requests.get(url_pub_api)
        pub_result_analyzed = json.loads(pub_result.text)
        if "repository" in pub_result_analyzed["latest"]["pubspec"].keys():
            url_github = pub_result_analyzed["latest"]["pubspec"]["repository"]
            author_name = re.search("github.com/(\S*)/", url_github).group(1).split('/')[0]
        if "description" in pub_result_analyzed["latest"]["pubspec"].keys():
            description = pub_result_analyzed["latest"]["pubspec"]["description"]
        if export_for_mobile_about:
            print("ThirdPartyData('{}','{}','{}','{}','{}',),".format(name, version, author_name, url_pub, url_github))
        if export_for_website_docs:
            print("<L n=\"{}\" v=\"{}\" u=\"{}\" />".format(name, version, description))
