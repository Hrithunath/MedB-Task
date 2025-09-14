import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:med_b/domain/models/user_menu_model/modeule_model.dart';
import 'package:med_b/domain/models/user_menu_model/user_model.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _loginKeyKey = 'login_key';
  static const String _userDetailsKey = 'user_details';
  static const String _menuDataKey = 'menu_data';

  // ---------------- ACCESS TOKEN ----------------
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  static Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  // ---------------- REFRESH TOKEN ----------------
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  // ---------------- LOGIN KEY ----------------
  static Future<void> saveLoginKey(String loginKey) async {
    await _storage.write(key: _loginKeyKey, value: loginKey);
  }

  static Future<String?> getLoginKey() async {
    return _storage.read(key: _loginKeyKey);
  }

  static Future<void> deleteLoginKey() async {
    await _storage.delete(key: _loginKeyKey);
  }

  // ---------------- USER DETAILS ----------------
  static Future<void> saveUserDetails(UserModel user) async {
    await _storage.write(
      key: _userDetailsKey,
      value: jsonEncode(user.toJson()),
    );
  }

  static Future<UserModel?> getUserDetails() async {
    final userJson = await _storage.read(key: _userDetailsKey);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> deleteUserDetails() async {
    await _storage.delete(key: _userDetailsKey);
  }

  // ---------------- MENU DATA ----------------
  static Future<void> saveMenuData(List<ModuleModel> modules) async {
    final menuJson = jsonEncode(modules.map((e) => e.toJson()).toList());
    await _storage.write(key: _menuDataKey, value: menuJson);
  }

  static Future<List<ModuleModel>?> getMenuData() async {
    final menuJson = await _storage.read(key: _menuDataKey);
    if (menuJson != null) {
      final List<dynamic> list = jsonDecode(menuJson);
      return list.map((e) => ModuleModel.fromJson(e)).toList();
    }
    return null;
  }

  static Future<void> deleteMenuData() async {
    await _storage.delete(key: _menuDataKey);
  }

  // ---------------- CLEAR ALL ----------------
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
