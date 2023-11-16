import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static const _keyHeader = 'authHeaders';

  static User myUser = User(
    image: "",
    firstName: '',
    lastName: '',
    email: '',
  );

  static String? getSavedHeader() => _preferences.getString(_keyHeader);

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> fetchAndSetUserFromApi() async {
    const String apiUrl =
        'https://app.berana.app/api/method/brana_audiobook.api.user_profile_api.retrieve_profile';

    final savedHeader = getSavedHeader();

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: savedHeader != null ? {'Cookie': savedHeader} : null,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> userData = responseData['message'];
        final User user = User.fromJson(userData);

        // Update myUser instance with API data
        myUser = User(
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          image: user.image,
        );

        await setUser(myUser);
      } else {
        // Handle API request error if needed
      }
    } catch (e) {
      // Handle exceptions
      print('Error during fetchAndSetUserFromApi: $e');
      // Add any additional error handling as needed
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

class User {
  String image;
  String firstName;
  String lastName;
  String email;

  User({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  User copy({
    String? imagePath,
    String? fname,
    String? lname,
    String? email,
  }) =>
      User(
        image: imagePath ?? image,
        firstName: fname ?? firstName,
        lastName: lname ?? lastName,
        email: email ?? this.email,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['profile_url'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'profile_url': image,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}
