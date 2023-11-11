import 'package:brana_mobile/pages/authors/authors_solo_page.dart';
import 'package:brana_mobile/screens/onboarding/onboarding.dart';
import 'package:brana_mobile/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove DevicePreview usage
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Brana Audiobook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Consider removing or adjusting useMaterial3 based on your needs.
        // useMaterial3: true,
      ),
      home: const Splashscreen(),
      // You can change the home widget here to your desired default screen.
      // home: AuthorsSoloPage(),

      debugShowCheckedModeBanner: false,
    );
  }
}
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
