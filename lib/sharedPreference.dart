// ignore_for_file: use_build_context_synchronously

import 'package:brana_mobile/login_page.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:brana_mobile/screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<void> checkOnboardingStatus(BuildContext context) async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // User is logged in, navigate to homepage
      _navigateToHomePage(context);
    } else if (hasCompletedOnboarding && !isLoggedIn) {
      // Onboarding has been completed, navigate to LoginPage
      _navigateToLoginPage(context);
    } else {
      // Onboarding has not been completed, navigate to Onboarding
      _navigateToOnboarding(context);
    }
  } 


Future<void> checkLoginStatus(BuildContext context) async {
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

void _navigateToLoginPage(BuildContext context) {
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  });
}

void _navigateToHomePage(BuildContext context) {
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  });
}

void _navigateToOnboarding(BuildContext context) {
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => const Onboarding(),
    ));
  });
}
