import 'package:flutter/material.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key, required String data});

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  Song? _currentSong;
  bool _isPlaying = false;

  void _playPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _selectSong(Song song) {
    setState(() {
      _currentSong = song;
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
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
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(song.albumCover),
                  ),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  onTap: () => _selectSong(song),
                );
              },
            ),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 10.0),
                Text(
                  _currentSong?.title ?? 'No song selected',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  _currentSong?.artist ?? '',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {
                        // Handle previous song logic
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: _playPause,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
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