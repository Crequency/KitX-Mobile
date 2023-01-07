# 关于此文件夹

## 介绍

此文件夹为 Json 模型，使用 built_value 创建

API 文档: https://pub.dev/documentation/built_value/latest/

推荐搭配 VSCode 插件: [Built Value Snippets](https://marketplace.visualstudio.com/items?itemName=GiancarloCode.built-value-snippets) 进行快速生成代码 [在 VSCode 中一键安装](vscode:extension/GiancarloCode.built-value-snippets)

IntelliJ 插件: [Built Value Snippets](https://plugins.jetbrains.com/plugin/13786-built-value-snippets)

## 使用

## 编写

使用 Built Value Snippets 插件可快速生成模板

也可以使用官方推荐的工具
- [Json to Dart built_value class converter](https://charafau.github.io/json2builtvalue/)
- [Json or js Object to Dart built_value class converter](https://januwa.github.io/p5_object_2_builtvalue/index.html)

### 生成

运行 `flutter packages pub run build_runner build` 即可。

### 注意

1. `.g.dart` 后缀代码为自动生成，请勿修改
2. 没有 `.g.dart` 文件情况下，编辑器会报错，且无法编译项目，为正常情况
3. 根据[官方文档](https://pub.dev/packages/built_value#should-i-check-in-andor-publish-in-the-generated-gdart-files)，请在 Push 代码时上传  `.g.dart` 代码，但并不会检查
