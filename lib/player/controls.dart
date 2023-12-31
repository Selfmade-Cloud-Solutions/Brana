import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:brana_mobile/constants.dart';

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              audioPlayer.seekToPrevious();
            },
            iconSize: 60,
            color: branaWhite,
            icon: const Icon(Icons.skip_previous_rounded)),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                  onPressed: () {
                    audioPlayer.play();
                  },
                  iconSize: 80,
                  icon: const Icon(Icons.play_arrow_rounded));
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                  onPressed: () {
                    audioPlayer.pause();
                  },
                  iconSize: 80,
                  icon: const Icon(Icons.pause_rounded));
            }
            return const Icon(
              Icons.play_arrow_rounded,
              color: branaWhite,
              size: 80,
            );
          },
        ),
        IconButton(
            onPressed: () {
              audioPlayer.seekToNext();
            },
            iconSize: 60,
            color: branaWhite,
            icon: const Icon(Icons.skip_next_rounded))
      ],
    );
  }
}
