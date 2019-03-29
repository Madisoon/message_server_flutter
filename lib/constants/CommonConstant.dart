import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

/// 常用常量
class CommonConstant {
  static EventBus eventBus = new EventBus();

  static const APP_BAR_TITLE = ['信息', '监控', '信息', '配置'];

  /// 信息来源常量（名称，值，颜色，图标）
  static final List source = [
    {'name': '新闻', 'value': '1', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '论坛', 'value': '2', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '微博', 'value': '3', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '博客', 'value': '4', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '视频', 'value': '5', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '微信', 'value': '6', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '移动端', 'value': '7', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '海外', 'value': '8', 'color': Color(0xFFf8f6f2), 'icon': '1'},
    {'name': '其它', 'value': '9', 'color': Color(0xFFf8f6f2), 'icon': '1'},
  ];

  /// 信息类型常量
  static final List positiveOrNegative = [
    {'name': '敏感', 'value': '1'},
    {'name': '非敏感', 'value': '2'},
  ];

  /// 信息等级常量
  static final List informationGrade = [
    {'name': '1级', 'value': '1'},
    {'name': '2级', 'value': '2'},
    {'name': '3级', 'value': '2'},
  ];

  /// 信息等级常量
  static final List menu = [
    {'name': '推送', 'icon': '1', 'color': ''},
    {'name': '2级', 'icon': '2', 'color': ''},
    {'name': '3级', 'icon': '2', 'color': ''},
    {'name': '3级', 'icon': '2', 'color': ''},
  ];

  /// 我的里面相关功能
  static final List<Map> listOperation = [
    {
      'icon': Icons.person,
      'name': '个人中心',
      'color': Colors.white,
      'callBack': ''
    },
    {
      'icon': Icons.palette,
      'name': '个性皮肤',
      'color': Colors.white,
      'callBack': ''
    },
    {
      'icon': Icons.settings,
      'name': '设置',
      'color': Colors.white,
      'callBack': ''
    },
    {
      'icon': Icons.insert_chart,
      'name': '统计',
      'color': Colors.white,
      'callBack': ''
    },
    {'icon': Icons.message, 'name': '通知', 'color': Colors.white, 'callBack': ''}
  ];

  /// 主菜单相关的功能
  static final List<Map> mainMenu = [
    {
      'icon': Icons.settings_ethernet,
      'name': '信息',
      'flex': 1,
      'color': Colors.white,
      'activeStatus': true
    },
    {
      'icon': Icons.monochrome_photos,
      'name': '测试',
      'flex': 2,
      'color': Colors.white,
      'activeStatus': false
    },
    {
      'icon': Icons.message,
      'name': '测试',
      'flex': 2,
      'color': Colors.white,
      'activeStatus': false
    },
    {
      'icon': Icons.settings,
      'name': '配置',
      'flex': 1,
      'color': Colors.white,
      'activeStatus': false
    }
  ];

  /// 设置相关的功能
  static final List<Map> settingMenu = [
    {
      'icon': Icons.settings_ethernet,
      'name': '安全设置',
      'color': Colors.white,
      'margin': 18
    },
    {
      'icon': Icons.monochrome_photos,
      'name': '生物识别',
      'color': Colors.white,
      'margin': 18
    },
    {'icon': Icons.message, 'name': '通用', 'color': Colors.white, 'margin': 18},
    {'icon': Icons.settings, 'name': '隐私', 'color': Colors.white, 'margin': 18},
    {'icon': Icons.settings, 'name': '关于', 'color': Colors.white, 'margin': 18},
    {
      'icon': Icons.settings,
      'name': '退出登陆',
      'color': Colors.white,
      'margin': 18
    }
  ];
}
