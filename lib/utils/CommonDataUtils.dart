import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../entity/SysUser.dart';

/// 用户的相关操作
class CommonDataUtils {
  static final String SP_AC_TOKEN = "accessToken";
  static final String SP_RE_TOKEN = "refreshToken";
  static final String SP_UID = "uid";
  static final String SP_IS_LOGIN = "isLogin";
  static final String SP_EXPIRES_IN = "expiresIn";
  static final String SP_TOKEN_TYPE = "tokenType";

  static final String SP_USER_ID = "id";
  static final String SP_USER_ACCOUNT = "account";
  static final String SP_USER_NAME = "nickName";
  static final String SP_USER_PHONE = "phone";
  static final String SP_USER_EMAIL = "email";
  static final String SP_USER_BIRTH = "birth";
  static final String SP_USER_SEX = "sex";
  static final String SP_USER_GMT_CREATE = "gmtCreate";

  static final String SP_COLOR_THEME_INDEX = "colorThemeIndex";

  // 保存用户登录信息，data中包含了token等信息
  static saveLoginInfo(Map data) async {
    if (data != null) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String accessToken = data['access_token'];
      await sp.setString(SP_AC_TOKEN, accessToken);
      String refreshToken = data['refresh_token'];
      await sp.setString(SP_RE_TOKEN, refreshToken);
      num uid = data['uid'];
      await sp.setInt(SP_UID, uid);
      String tokenType = data['tokenType'];
      await sp.setString(SP_TOKEN_TYPE, tokenType);
      num expiresIn = data['expires_in'];
      await sp.setInt(SP_EXPIRES_IN, expiresIn);

      await sp.setBool(SP_IS_LOGIN, true);
    }
  }

  // 清除登录信息
  static clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(SP_AC_TOKEN, "");
    await sp.setString(SP_RE_TOKEN, "");
    await sp.setInt(SP_UID, -1);
    await sp.setString(SP_TOKEN_TYPE, "");
    await sp.setInt(SP_EXPIRES_IN, -1);
    await sp.setBool(SP_IS_LOGIN, false);
  }

  // 保存用户个人信息
  static Future<SysUser> saveSysUser(Map data) async {
    if (data != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
//      num id = data['id'];
      num id = 1;
      String account = data['user_loginname'];
      String nickName = data['user_name'];
      String phone = data['user_phone'];
      String email = data['user_dep'];
      String birth = data['userBirth'];
//      num sex = data['user_status'];
      num sex = 1;
      String gmtCreate = data['user_createtime'];
      preferences
        ..setInt(SP_USER_ID, id)
        ..setString(SP_USER_ACCOUNT, account)
        ..setString(SP_USER_NAME, nickName)
        ..setString(SP_USER_PHONE, phone)
        ..setString(SP_USER_EMAIL, email)
        ..setString(SP_USER_BIRTH, birth)
        ..setInt(SP_USER_SEX, sex)
        ..setString(SP_USER_GMT_CREATE, gmtCreate)
        ..setBool("LOGIN_SUCCESS", true);
      SysUser sysUser = new SysUser();
      sysUser
        ..id = id
        ..account = account
        ..nickName = nickName
        ..phone = phone
        ..email = email
        ..birth = birth
        ..sex = sex
        ..gmtCreate = gmtCreate;
      return sysUser;
    }
    return null;
  }

  // 获取用户信息
  static Future<SysUser> getSysUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    /*bool isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }*/
    SysUser sysUser = new SysUser();
    sysUser
      ..id = sp.getInt(SP_USER_ID)
      ..account = sp.getString(SP_USER_ACCOUNT)
      ..nickName = sp.getString(SP_USER_NAME)
      ..phone = sp.getString(SP_USER_PHONE)
      ..email = sp.getString(SP_USER_EMAIL)
      ..birth = sp.getString(SP_USER_BIRTH)
      ..sex = sp.getInt(SP_USER_SEX)
      ..gmtCreate = sp.getString(SP_USER_GMT_CREATE);
    return sysUser;
  }

  // 是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(SP_IS_LOGIN);
    return b != null && b;
  }

  // 获取accesstoken
  static Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_AC_TOKEN);
  }

  // 设置选择的主题色
  static setColorTheme(int colorThemeIndex) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SP_COLOR_THEME_INDEX, colorThemeIndex);
  }

  static Future<int> getColorThemeIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(SP_COLOR_THEME_INDEX);
  }
}
