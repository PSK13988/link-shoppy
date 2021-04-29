import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  static final AppSharedPreference _singleton = AppSharedPreference._internal();

  factory AppSharedPreference() {
    return _singleton;
  }

  AppSharedPreference._internal();

  static Future<bool> setFirstTimeLaunch(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool('first_time', value);
  }

  static Future<bool> isFirstTimeLaunch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('first_time');
  }

  static Future<bool> setShopVerified(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool('shop_verification', value);
  }

  static Future<bool> isShopVerified() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('shop_verification');
  }

  static Future<bool> setJwtToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('jwt_token', value);
  }

  static Future<String> getJwtToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('jwt_token');
  }

  static Future<bool> setRefreshToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('refresh_token', value);
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('refresh_token');
  }

  static Future<bool> setUserData(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('user_data', json.encode(value));
  }

  static Future<String> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return json.decode(preferences.getString('user_data'));
  }

  static Future<bool> setUserId(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('user_id', value);
  }

  static Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('user_id');
  }

  static Future<bool> setUserRole(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('user_role', value);
  }

  static Future<String> getUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('user_role');
  }

  static Future<bool> setCategoryId(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('category_id', value);
  }

  static Future<String> getCategoryId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('category_id');
  }

  static Future<bool> setEmail(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('email_id', value);
  }

  static Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('email_id');
  }

  static Future<bool> setAgreementNo(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('agrno', value);
  }

  static Future<String> getAgreementNo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('agrno');
  }

  static Future<bool> setCurrentTheme(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt('current_theme', value);
  }

  static Future<int> getCurrentTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('current_theme');
  }

  /*static Future<bool> setExternalAppFlag(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool('external_app', value);
  }

  static Future<bool> isExternalAppFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('external_app');
  }*/
}
