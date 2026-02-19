import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper {
  static const String userIdKey = "USERIDKEY";
  static const String userNameKey = "USERNAMEKEY";
  static const String userEmailKey = "USEREMAILKEY";
  static const String userWalletKey = "USERWALLETKEY";

  // Save Methods

  Future<bool> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, userId);
  }

  Future<bool> saveUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName);
  }

  Future<bool> saveUserEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, userEmail);
  }

  Future<bool> saveUserWallet(String userWallet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userWalletKey, userWallet);
  }

  // Methods

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletKey);
  }

  // CLEAR ALL (logout use)

  Future<bool> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
