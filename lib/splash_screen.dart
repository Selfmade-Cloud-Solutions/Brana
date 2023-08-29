import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brana_mobile/bookstore.dart';
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
    Future.delayed(const Duration(seconds: 14), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const Bookstore(),
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
            AssetImage("assets/images/logo2.png"),
              size: 150,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
