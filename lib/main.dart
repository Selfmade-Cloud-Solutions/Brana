import 'package:brana_mobile/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:brana_mobile/login_signup_option.dart';
// import 'package:brana_mobile/navigation.dart';
// import 'package:brana_mobile/bookstore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brana Audiobook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // home: const SignupPage(),
      // home: const LoginSignupOption(),
      // home: const Navigation(),
       home: const Splashscreen(),
      // home: const Bookstore(),

      debugShowCheckedModeBanner: false,
    );
  }
}
