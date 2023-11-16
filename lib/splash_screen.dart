// ignore_for_file: use_build_context_synchronously

import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/login_page.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:brana_mobile/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:brana_mobile/navigation.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _checkOnboardingStatus();
    _checkLoginStatus();
  }

  Future<void> _checkOnboardingStatus() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    bool isLoggedOut = prefs.getBool('isLoggedOut') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedOut) {
      // User is logged out, navigate to login page
      _navigateToLogin();
    } else if (isLoggedIn) {
      // User is logged in, navigate to homepage
      _navigateToHomePage();
    } else if (hasCompletedOnboarding) {
      // Onboarding has been completed, navigate to LoginPage
      _navigateToLoginPage();
    } else {
      // Onboarding has not been completed, navigate to Onboarding
      _navigateToOnboarding();
    }
  } catch (e) {
    // Handle exceptions if any
    print('Error checking onboarding status: $e');
  }
}



  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // User has logged in before, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    }
  }
  Future<void> _checkLogoutStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // User has logged in before, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    }
  }

  void _navigateToLoginPage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ));
    });
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  void _navigateToHomePage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    });
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Onboarding(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: branaDeepBlack,
      body: Center(
        child: Image(
          image: const AssetImage("assets/images/logo.png"),
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
