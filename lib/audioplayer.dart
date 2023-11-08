import 'dart:async';
// import 'dart:convert';
// import 'package:brana_mobile/data.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:brana_mobile/screens/Loading.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:audio_session/audio_session.dart';
// import 'package:path/path.dart';
import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:http/http.dart' as http;

class AudioPlayerPage extends StatefulWidget {
  // final Book book;
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class AudioPosition {
  const AudioPosition(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class _AudioPlayerPageState extends State<AudioPlayerPage>
    with WidgetsBindingObserver {
  Song? _currentSong;
  bool _isPlaying = false;
  bool _isExpanded = false;
  Color appBarColor = branaWhite;
  late String appBarText;
  Icon iconview = const Icon(Icons.arrow_back);
  // late AudioPlayer audioPlayer;
  final audioPlayer = AudioPlayer();
  var logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  // final double _sliderValue = 0.0;
  bool isFetching = false;
  int currentIndex = 0;
  final playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [
      for (var i = 0; i < songs.length; i++)
        AudioSource.uri(Uri.parse(songs[i].audiolinks),
            tag: MediaItem(id: songs[i].id, title: songs[i].title)),
    ],
  );
  Future<void> init() async {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //         child: CircularProgressIndicator(
    //       color: branaDarkBlue,
    //     ));
    //   },
    // );
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    // audioPlayer.playbackEventStream.listen((event) {},
    //     onError: (Object e, StackTrace stackTrace) {
    //   logger.e('A stream error occurred: $e');
    // });
    // await audioPlayer.setAudioSource(playlist);
    // await audioPlayer.setLoopMode(LoopMode.all);
    // await audioPlayer.setShuffleModeEnabled(true);
    // await audioPlayer.play();

    try {
      await audioPlayer.setAudioSource(playlist);
      await audioPlayer.setLoopMode(LoopMode.all);
      // await audioPlayer.setShuffleModeEnabled(true);
      await audioPlayer.play();
      // setState(() {
      //   currentIndex = index;
      // });
    } on PlayerException catch (e) {
      logger.e("Error code: ${e.code}");
      logger.i("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      logger.e("Connection aborted: ${e.message}");
    } catch (e) {
      logger.e("Error loading audio source: $e");
    }

    // audioPlayer.playbackEventStream.listen((event) {},
    //     onError: (Object e, StackTrace st) {
    //   if (e is PlayerException) {
    //     logger.e('Error code: ${e.code}');
    //     logger.i('Error message: ${e.message}');
    //   } else {
    //     logger.e('An error occurred: $e');
    //   }
    // });

    // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();
  }

  Stream<AudioPosition> get _AudioPositionStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, AudioPosition>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => AudioPosition(
                position,
                bufferedPosition,
                duration ?? Duration.zero,
              ));

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   setState(() {
    //     isFetching = true;
    //   });
    // });
    // audioPlayer.positionStream.listen((position) {
    //   setState(() {
    //     _sliderValue = position.inMilliseconds.toDouble();
    //   });
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // init();
    // });
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
    // await audioPlayer.seekToNext();
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
            color: _isExpanded ? branaWhite : Colors.black,
            onPressed: () {
              if (_isExpanded) {
                setState(() {
                  _isExpanded = !_isExpanded;
                  appBarColor = branaWhite;
                  iconview = const Icon(Icons.arrow_back);
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              color: _isExpanded ? branaWhite : Colors.black,
              onPressed: () {
                // Handle search icon press
              },
            ),
          ]),
      body: Column(
        children: [
          if (!_isExpanded)
            (Expanded(
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
                      style: GoogleFonts.jost(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: branaDarkBlue,
                      ),
                    ),
                    subtitle: Text(song.title),
                    trailing: Text(song.duration),
                    onTap: () async {
                      _selectSong(song);
                      // init(index);
                      audioPlayer.stop();
                    },
                  );
                },
              ),
            )),
          GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = true;
                  appBarColor = branaDarkBlue;
                  iconview = const Icon(Icons.view_list);
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
                width: double.infinity,
                height:
                    _isExpanded ? MediaQuery.of(context).size.height - 56 : 120,
                child: Container(
                  color: branaDarkBlue,
                  child: Column(children: [
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
                        } else if (processingState !=
                            ProcessingState.completed) {
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
                    StreamBuilder<AudioPosition>(
                      stream: _AudioPositionStream,
                      builder: (context, snapshot) {
                        final Audioposition = snapshot.data;
                        return Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: ProgressBar(
                                  barHeight: 6,
                                  baseBarColor: branaWhite,
                                  bufferedBarColor: Colors.grey,
                                  progressBarColor: Colors.yellow,
                                  thumbColor: Colors.yellow,
                                  timeLabelTextStyle: GoogleFonts.jost(
                                    color: branaWhite,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  progress:
                                      Audioposition?.position ?? Duration.zero,
                                  total:
                                      Audioposition?.duration ?? Duration.zero,
                                  buffered: Audioposition?.bufferedPosition ??
                                      Duration.zero,
                                  onSeek: audioPlayer.seek,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
                ),
              ))
        ],
      ),
    );
  }

  // void fetchingAudiobooks() async {
  //   // This example uses the Google Books API to search for books about http.
  //   // https://developers.google.com/books/docs/overview
  //   var url = Uri.https('librivox.org','/api/feed/audiobooks');

  //   // Await the http get response, then decode the json-formatted response.
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     var itemCount = jsonResponse['totalItems'];
  //     print('Number of books about http: $itemCount.');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }
  // void fetchingAudiobooks() async {
  //   print("fatching audiobooks...");
  //   try {
  //     // http://randomuser.me/api/?results=10
  //     const url = 'file:///home/bright/Downloads/55';
  //     // 'https://ia801609.us.archive.org/31/items/count_monte_cristo_0711_librivox/count_of_monte_cristo_001_dumas_64kb.mp3';
  //     final uri = Uri.parse(url);
  //     // print(uri.toString());
  //     final response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       print('working');
  //     } else {
  //       print('Request failed with status: ${response.statusCode}.');
  //     }
  //     // final body = response.body;
  //     // final json = jsonDecode(body);
  //     // setState(() {
  //     //   AudioBooks = json['results'];
  //     // });
  //     print("fatching audiobooks completed...");
  //   } catch (e) {
  //     print("fatching audiobooks error...");
  // }
  // }
}

class Song {
  final String id;
  final String album;
  final String title;
  final String artist;
  final String albumCover;
  final String audiolinks;
  final String duration;

  Song({
    required this.id,
    required this.album,
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.audiolinks,
    required this.duration,
  });
}

final List<Song> songs = [
  Song(
    id: '1',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 1',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/1.mp3',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_01_fitzgerald_64kb.mp3',
    duration: '00:29:24',
  ),
  Song(
    id: '2',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 2',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_02_fitzgerald_64kb.mp3',
    duration: '00:39:24',
  ),
  Song(
    id: '3',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 3',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_03_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '4',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 4',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_04_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '5',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 5',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '6',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 6',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '7',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 7',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '8',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 8',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
  Song(
    id: '9',
    album: 'ላስብበት',
    title: 'ላስብበት',
    artist: 'Chapter 9',
    albumCover: 'assets/books/ላስብበት.jpg',
    audiolinks:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
    duration: '00:35:24',
  ),
];
