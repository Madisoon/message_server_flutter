import 'package:flutter/services.dart';

class CommonOperation {
  /// 复制操作
  static copyToClipboard(final String text) {
    if (text == null || text == '') return;
    Clipboard.setData(new ClipboardData(text: text));
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
