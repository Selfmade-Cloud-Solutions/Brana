// import 'package:brana_mobile/splash_screen.dart';
// import 'package:flutter/material.dart';
// // import 'package:brana_mobile/login_signup_option.dart';
// // import 'package:brana_mobile/navigation.dart';
// // import 'package:brana_mobile/bookstore.dart';

// // import 'screens/onboarding/onboarding.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Brana Audiobook',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       // home: const SignupPage(),
//       // home: const LoginSignupOption(),
//       // home: const Navigation(),
//        home: const Splashscreen(),
//       // home: const Bookstore(),

//       debugShowCheckedModeBanner: false,
//       // title: 'Onboarding Concept',
//       // home: Builder(
//       //   builder: (BuildContext context) {
//       //     final screenHeight = MediaQuery.of(context).size.height;

//       //     return Onboarding(screenHeight: screenHeight);
//       //   },
//       // ),
//     );
//   }
// }

// void main() => runApp(const App());

import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SecondPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage("assets/images/logo2.png"),
              size: 250,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Builder(
        builder: (BuildContext context) {
          final screenHeight = MediaQuery.of(context).size.height;

          return Onboarding(screenHeight: screenHeight);
        },
    ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brana Audiobook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() => runApp(const App());