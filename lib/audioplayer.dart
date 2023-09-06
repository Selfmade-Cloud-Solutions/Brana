import 'package:brana_mobile/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:io';

// import 'package:rxdart/rxdart.dart';

class AudioPlayerPage extends StatefulWidget {
  // final Book book;
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  Song? _currentSong;
  bool _isPlaying = false;
  bool _isExpanded = false;
  Color appBarColor = Colors.white;
  late String appBarText;
  Icon iconview = const Icon(Icons.arrow_back);
  // late AudioPlayer audioPlayer;
  final AudioPlayer audioPlayer = AudioPlayer();
  final double _sliderValue = 0.0;

  void init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: [
          // AudioSource.uri(Uri.parse(
          //     "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac")),
          // AudioSource.uri(Uri.parse(
          //     "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/1.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/2.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/3.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/4.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/5.mp3')),
          AudioSource.uri(Uri.parse('asset:///assets/audiobooks/6.mp3')),
        ],
      );
      await audioPlayer.setAudioSource(playlist, initialIndex: 0);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Future<Uint8List> loadAudioBytes(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  Future<String> createTemporaryFile(Uint8List audioBytes) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final File tempFile = File('$tempPath/3.mp3');
    await tempFile.writeAsBytes(audioBytes);
    return tempFile.path;
  }

  void playAudioFromBytes(Uint8List audioBytes) async {
    final String tempFilePath = await createTemporaryFile(audioBytes);
    final audioSource = AudioSource.uri(Uri.file(tempFilePath));

    await audioPlayer.setAudioSource(audioSource);
    audioPlayer.play();
    _isPlaying = true;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayer = AudioPlayer();
  //   audioPlayer.positionStream.listen((position) {
  //     setState(() {
  //       _sliderValue = position.inMilliseconds.toDouble();
  //     });
  //   });
  //   init();
  //   // audioPlayer.play();
  // }

  void seekTo(double value) async {
    await audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio() async {
    await audioPlayer.play();
    setState(() {
      _isPlaying = false;
    });
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      _isPlaying = true;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  void seekAudio() async {
    await audioPlayer
        .seek(Duration(seconds: audioPlayer.position.inSeconds + 15));
  }

  void _selectSong(Song song) {
    setState(() {
      _currentSong = song;
      _isPlaying = false;
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        // shadowColor: appBarColor,
        title: _isExpanded ? null : const Text("widget.book.title"),
        leading: IconButton(
          icon: iconview,
          onPressed: () {
            _isExpanded ? (_isExpanded = !_isExpanded) : Navigator.pop(context);
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
                      horizontal: 10.0, vertical: 1.0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(song.albumCover),
                  ),
                  title: Text(
                    song.artist,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(song.title),
                  trailing: const Text("af"),
                  onTap: () async {
                    _selectSong(song);
                    final audioBytes = await loadAudioBytes(song.links);
                    playAudioFromBytes(audioBytes);
                  },
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  appBarColor = Colors.teal;
                  iconview = const Icon(Icons.view_list);
                } else {
                  appBarColor = Colors.white;
                  iconview = const Icon(Icons.arrow_back);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height:
                  _isExpanded ? MediaQuery.of(context).size.height - 56 : 130,
              child: Container(
                color: Colors.teal,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 2.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _currentSong?.artist ?? 'Chapter 1',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6.0,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6.0),
                        rangeThumbShape: const RoundRangeSliderThumbShape(),
                        rangeValueIndicatorShape:
                            const PaddleRangeSliderValueIndicatorShape(),
                      ),
                      child: StreamBuilder<Duration>(
                        stream: audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration =
                              audioPlayer.duration ?? Duration.zero;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatDuration(position),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Slider(
                                thumbColor: Colors.white,
                                activeColor: Colors.amber,
                                inactiveColor:
                                    const Color.fromARGB(31, 230, 11, 11),
                                value: position.inMilliseconds.toDouble(),
                                min: 0.0,
                                max: audioPlayer.duration?.inMilliseconds
                                        .toDouble() ??
                                    0.0,
                                onChanged: (value) {
                                  final newPosition =
                                      Duration(milliseconds: value.floor());
                                  audioPlayer.seek(newPosition);
                                },
                                onChangeEnd: (value) {
                                  final newPosition =
                                      Duration(milliseconds: value.floor());
                                  audioPlayer.seek(newPosition);
                                },
                              ),
                              Text(
                                formatDuration(duration - position),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(CupertinoIcons.gobackward_15),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.play_arrow : Icons.pause,
                          ),
                          onPressed: () {
                            if (!_isPlaying) {
                              playAudio();
                            } else {
                              pauseAudio();
                            }
                          },
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: const Icon(CupertinoIcons.goforward_15),
                          onPressed: () {
                            seekAudio();
                          },
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String albumCover;
  final String links;

  Song(
      {required this.title,
      required this.artist,
      required this.albumCover,
      required this.links});
}

final List<Song> songs = [
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 1',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/1.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 2',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/3.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 3',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/4.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 4',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/5.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 5',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/6.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 6',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/6.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 7',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/2.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 8',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/2.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 9',
    albumCover: 'assets/books/ላስብበት.jpg',
    links: 'assets/audiobooks/2.mp3',
  ),
];
