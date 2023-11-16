import 'dart:convert';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://borkena.com/wp-content/uploads/2023/07/Bealu-Girma-_-Ethiopian-Writers.jpg",
    firstName: ' ',
    lastName: '',
    email: '',
    phone: '',
    aboutMeDescription: '',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> fetchAndSetUserFromApi() async {
    final String apiUrl =
        'https://app.berana.app/api/method/brana_audiobook.api.user_profile_api.retrieve_profile';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      print(response.body);
      final User user = User.fromJson(userData);
      await setUser(user);
    } else {
      print('Failed to load user data from Api');
    }
  }

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
