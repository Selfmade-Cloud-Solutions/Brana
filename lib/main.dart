import 'package:brana_mobile/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:brana_mobile/login_signup_option.dart';
// import 'package:brana_mobile/navigation.dart';
// import 'package:brana_mobile/bookstore.dart';

// import 'screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

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
      // title: 'Onboarding Concept',
      // home: Builder(
      //   builder: (BuildContext context) {
      //     final screenHeight = MediaQuery.of(context).size.height;

      //     return Onboarding(screenHeight: screenHeight);
      //   },
      // ),
    );
  }
}

void main() => runApp(const App());




// import 'package:flutter/material.dart';
// // import 'package:brana_mobile/login_signup_option.dart';
// // import 'package:brana_mobile/navigation.dart';
// import 'package:brana_mobile/bookstore.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Brana',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       // home: const SignupPage(),
//       // home: const LoginSignupOption(),
//       // home: const Navigation(),
//       home: const Bookstore(),

//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
