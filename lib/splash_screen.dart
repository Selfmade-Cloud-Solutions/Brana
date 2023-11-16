// ignore_for_file: use_build_context_synchronously

import 'package:brana_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brana_mobile/sharedPreference.dart';

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
    checkOnboardingStatus(context);
    checkLoginStatus(context);
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
