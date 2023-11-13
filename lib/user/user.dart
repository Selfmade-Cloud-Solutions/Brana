class User {
  String image;
  String firstName;
  String lastName;
  String email;
  String phone;
  String aboutMeDescription;

  // Constructor
  User({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.aboutMeDescription,
  });

  User copy({
    String? imagePath,
    String? fname,
    String? lname,
    String? phone,
    String? email,
    String? about,
  }) =>
      User(
        image: imagePath ?? image,
        firstName: fname ?? firstName,
        lastName: lname ?? lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        aboutMeDescription: about ?? aboutMeDescription,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        firstName: json['fname'],
        lastName: json['lname'],
        email: json['email'],
        aboutMeDescription: json['about'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'fname': firstName,
        'lname': lastName,
        'email': email,
        'about': aboutMeDescription,
        'phone': phone,
      };
}
