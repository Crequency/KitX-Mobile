import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      "Drawer_Title": "KitX",
      "Drawer_Home": "KitX 首页",
      "Drawer_Devices": "设备管理",
      "Drawer_Account": "账户",
      "Drawer_Setting": "设置",
      "IndexPage_Title": "KitX",
      "HomePage_Title": "KitX 首页",
      "HomePage_Text": "你点了这个按钮多少次？",
      "HomePage_Hello": "你好，世界！",
      "DevicePage_Title": "设备管理",
      "DevicePage_PluginsCountText": "在线插件数: "
    },
    'en_US': {
      "Drawer_Title": "KitX",
      "Drawer_Home": "Home",
      "Drawer_Devices": "Devices",
      "Drawer_Account": "Account",
      "Drawer_Setting": "Setting",
      "IndexPage_Title": "KitX",
      "HomePage_Title": "KitX Mobile",
      "HomePage_Text": "You have clicked the button this many times:",
      "HomePage_Hello": "Hello World!",
      "DevicePage_Title": "Devices",
      "DevicePage_PluginsCountText": "Enabled Plugins Count: "
    }
  };
}
