import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({
    super.key,
  });

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  Song? _currentSong;
  bool _isPlaying = false;

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

  void playAudio() {
    _isPlaying = !_isPlaying;
    audioPlayer.setAsset('assets/audiobooks/1.mp3');
    // audioPlayer.play();
  }

  void pauseAudio() {
    _isPlaying = !_isPlaying;
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  // void _playPause() {
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //     audioPlayer.setAsset('assets/audiobooks/GetachewKassa.mp3');
  //     // audioPlayer.play();
  //   });
  // }

  void _selectSong(Song song) {
    setState(() {
      _currentSong = song;
      _isPlaying = true;
    });
  }

  double _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ላስብበት'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  // tileColor: Colors.grey[200],
                  leading: CircleAvatar(
                    // backgroundColor: Colors.black,
                    backgroundImage: AssetImage(song.albumCover),
                  ),
                  // contentPadding: const EdgeInsets.all(6.0),
                  title: Text(
                    song.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: Text(song.artist),
                  onTap: () => _selectSong(song),
                );
              },
            ),
          ),
          Container(
            color: Colors.teal,
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                const Text(
                  'Currently Playing',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // const SizedBox(height: 1.0),
                Text(
                  _currentSong?.title ?? 'No song selected',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  _currentSong?.artist ?? '',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                Slider(
                  thumbColor: Colors.white,
                  activeColor: Colors.amber,
                  inactiveColor: Colors.black12,
                  value: _sliderValue,
                  min: 0.0, // The minimum value of the slider
                  max: 100.0, // The maximum value of the slider
                  onChanged: (value) {
                    // Update the slider value when the user interacts with it
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.fast_rewind_outlined),
                      onPressed: () {
                        // Handle previous song logic
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: _isPlaying ? pauseAudio : playAudio,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.fast_forward_outlined),
                      onPressed: () {
                        // Handle next song logic
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String albumCover;

  Song({required this.title, required this.artist, required this.albumCover});
}

final List<Song> songs = [
  Song(
    title: 'ላስብበት',
    artist: 'Artist 1',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Artist 2',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Artist 2',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Artist 2',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Artist 2',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  // Add more songs as needed
];
