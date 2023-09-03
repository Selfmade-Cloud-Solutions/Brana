import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Test extends StatefulWidget {
  const Test({
    super.key,
  });

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    // init AudioPlayer();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Play'),
              onPressed: () async {
                await audioPlayer.setAsset('assets/audiobooks/GetachewKassa.mp3');
                audioPlayer.play();
              },
            ),
            ElevatedButton(
              child: const Text('Pause'),
              onPressed: () {
                audioPlayer.pause();
              },
            ),
            ElevatedButton(
              child: const Text('Stop'),
              onPressed: () {
                audioPlayer.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}