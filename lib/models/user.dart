class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      imagePath: json['imagePath'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      about: json['about'] ?? '',
      isDarkMode: json['isDarkMode'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'name': name,
      'email': email,
      'about': about,
      'isDarkMode': isDarkMode,
    };
  }

  User copyWith({
    String? imagePath,
    String? name,
    String? email,
    String? about,
    bool? isDarkMode,
  }) {
    return User(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}