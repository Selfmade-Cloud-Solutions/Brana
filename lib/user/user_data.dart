import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://borkena.com/wp-content/uploads/2023/07/Bealu-Girma-_-Ethiopian-Writers.jpg",
    name: 'Test Test',
    email: 'test.gk@gmail.com',
    phone: '(251) 9206-5039',
    aboutMeDescription:
        '12 Jan 1994',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
