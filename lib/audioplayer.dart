import 'package:brana_mobile/data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
// import 'package:rxdart/rxdart.dart';

class AudioPlayerPage extends StatefulWidget {
  final Book book;
  const AudioPlayerPage({super.key, required this.book});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  Song? _currentSong;
  bool _isPlaying = false;

  late AudioPlayer audioPlayer;
  final playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [
      AudioSource.uri(Uri.parse('asset:///assets/audiobooks/4.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/audiobooks/2.mp3')),
      // AudioSource.uri(Uri.parse('asset:///assets/audiobooks/1.mp3')),
      // AudioSource.uri(Uri.parse('asset:///assets/audiobooks/2.mp3')),
      // AudioSource.uri(Uri.parse('asset:///assets/audiobooks/3.mp3')),
      // AudioSource.uri(Uri.parse('asset:///assets/audiobooks/4.mp3')),
      // AudioSource.uri(Uri.parse('asset:///assets/audiobooks/5.mp3')),
    ],
  );
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.setAudioSource(playlist);
    // audioPlayer.setAsset('assets/audiobooks/4.mp3');
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    audioPlayer.positionStream.listen((position) {
      setState(() {
        _sliderValue = position.inMilliseconds.toDouble();
      });
    });

    // _init();
  }

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

    // await audioPlayer.setAudioSource(playlist,
    //     initialIndex: 0, initialPosition: Duration.zero);
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  void seekAudio() async {
    // await audioPlayer.seek(const Duration(seconds: 30));
    await audioPlayer.seekToNext();
  }

  void _selectSong(Song song) {
    setState(() {
      _currentSong = song;
      _isPlaying = true;
    });
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
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

  // Stream<PositionData> get _positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //         audioPlayer.positionStream,
  //         audioPlayer.bufferedPositionStream,
  //         audioPlayer.durationStream,
  //         (position, bufferedPosition, duration) => PositionData(
  //             position, bufferedPosition, duration ?? Duration.zero));

  double _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
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
                    song.artist,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: Text(song.title),
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
                const SizedBox(height: 2.0),
                Text(
                  _currentSong?.artist ?? 'Chapter 1',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      onPressed: () {
                        if (_isPlaying) {
                          pauseAudio();
                        } else {
                          playAudio();
                        }
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.fast_forward_outlined),
                      onPressed: () {
                        seekAudio();
                      },
                      color: Colors.white,
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5.0,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 8.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 16.0),
                      ),
                      child: Slider(
                        thumbColor: Colors.white,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.black12,
                        value: 0.0,
                        min: 0.0,
                        max: 1000,
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value;
                          });
                        },
                        onChangeEnd: (value) {
                          seekTo(value);
                        },
                      ),
                    )
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
    artist: 'Chapter 1',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 2',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 3',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 4',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 5',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 6',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 7',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 8',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 9',
    albumCover: 'assets/books/ላስብበት.jpg',
  ),
];
