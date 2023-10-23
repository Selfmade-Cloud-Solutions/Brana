import 'package:brana_mobile/phone_and_password.dart';
import 'package:brana_mobile/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'screens/onboarding/onboarding.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
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
      // home: const PhoneAndPassword(),
      home: Splashscreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  // Lock the app in portrait orientation
  
  runApp(const App());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
}
