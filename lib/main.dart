import 'package:brana_mobile/pages/authors/authors_solo_page.dart';
import 'package:brana_mobile/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path/path.dart';
import 'screens/onboarding/onboarding.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';

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
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Brana Audiobook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Splashscreen(),
      // home: AuthorsSoloPage(),

      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> main() async {
  // Lock the app in portrait orientation

  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => App()));
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
