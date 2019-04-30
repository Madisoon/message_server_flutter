import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CommonOperation {
  /// 复制操作
  static copyToClipboard(final String text) {
    if (text == null || text == '') return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static SystemUiOverlayStyle uiStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );

  static appUIStyle() {
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
  }

  static Map typeJudge(type) {
    Map contactType = {'name': '', 'color': '', 'icon': ''};
    switch (type) {
      case 'number':
        contactType['name'] = '手机';
        contactType['color'] = Colors.grey;
        contactType['icon'] = 'lib/images/contactType/phone.png';
        break;
      case 'qq':
        contactType['name'] = 'QQ';
        contactType['color'] = Colors.blue;
        contactType['icon'] = 'lib/images/contactType/qq.png';
        break;
      case 'qqGroup':
        contactType['name'] = 'QQ群';
        contactType['color'] = Colors.blue;
        contactType['icon'] = 'lib/images/contactType/qq.png';
        break;
      case 'weixin':
        contactType['name'] = '微信';
        contactType['color'] = Colors.green;
        contactType['icon'] = 'lib/images/contactType/weixin.png';
        break;
      case 'weixinGroup':
        contactType['name'] = '微信群';
        contactType['color'] = Colors.green;
        contactType['icon'] = 'lib/images/contactType/weixin.png';
        break;
      default:
        contactType['name'] = '未知';
        contactType['color'] = Colors.red;
        contactType['icon'] = 'lib/images/contactType/phone.png';
        break;
    }
    return contactType;
  }

  /// 获取信息发送的类型
  static String getInformationType(informationType) {
    String type = "";
    switch (informationType) {
      case "qq":
        type = "QQ";
        break;
      case "qqGroup":
        type = "QQ群";
        break;
      case "weixin":
        type = "微信";
        break;
      case "weixinGroup":
        type = "微信群";
        break;
      default:
        type = "类型错误";
        break;
    }
    return type;
  }
}
