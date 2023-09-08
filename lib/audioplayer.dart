import 'dart:async';
// import 'dart:convert';
// import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/screens/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:path/path.dart';
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
  double _sliderValue = 0.0;
  bool isFetching = false;
  int currentIndex = 0;

  void init(int index) async {
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
          for (var i = 0; i < songs.length; i++)
            AudioSource.uri(Uri.parse(songs[i].links)),
        ],
      );
      await audioPlayer.setAudioSource(playlist, initialIndex: 0);
      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.setShuffleModeEnabled(true);
      audioPlayer.play();
      setState(() {
        currentIndex = index;
      });
    } on PlayerException catch (e) {
      print("Error code: ${e.code}");

      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection aborted: ${e.message}");
    } catch (e) {
      print("Error loading audio source: $e");
    }

    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // audioPlayer = AudioPlayer();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isFetching = true;
      });
    });
    audioPlayer.positionStream.listen((position) {
      setState(() {
        _sliderValue = position.inMilliseconds.toDouble();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init(currentIndex);
    });
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
    return SafeArea(
      child: isFetching == false
          ? const Loading()
          : Scaffold(
              appBar: AppBar(
                  backgroundColor: appBarColor,
                  // shadowColor: appBarColor,
                  title: _isExpanded ? null : const Text("widget.book.title"),
                  leading: IconButton(
                    icon: iconview,
                    color: _isExpanded ? Colors.white : Colors.black,
                    onPressed: () {
                      if (_isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                          appBarColor = Colors.white;
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
                      color: _isExpanded ? Colors.white : Colors.black,
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
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kDarkBlue,
                              ),
                            ),
                            subtitle: Text(song.title),
                            trailing: const Text("af"),
                            onTap: () async {
                              _selectSong(song);
                              init(index);
                            },
                          );
                        },
                      ),
                    )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = true;
                          appBarColor = kDarkBlue;
                          iconview = const Icon(Icons.view_list);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                        width: double.infinity,
                        height: _isExpanded
                            ? MediaQuery.of(context).size.height - 56
                            : 120,
                        child: Container(
                          color: kDarkBlue,
                          child: Column(children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4.0,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                                rangeThumbShape:
                                    const RoundRangeSliderThumbShape(),
                                rangeValueIndicatorShape:
                                    const PaddleRangeSliderValueIndicatorShape(),
                              ),
                              child: StreamBuilder<Duration>(
                                stream: audioPlayer.positionStream,
                                builder: (context, snapshot) {
                                  final position =
                                      snapshot.data ?? Duration.zero;
                                  final duration =
                                      audioPlayer.duration ?? Duration.zero;
                                  return Expanded(
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            if (_isExpanded)
                                              Column(
                                                children: [
                                                  (SizedBox(
                                                      height: 300,
                                                      child: Container(
                                                        width: 250,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    _currentSong
                                                                            ?.albumCover ??
                                                                        "assets/books/ላስብበት.jpg",
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                      ))),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 35,
                                                        horizontal: 25),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (Text(
                                                                  _currentSong
                                                                          ?.title ??
                                                                      'Chapter 1',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )),
                                                                Text(
                                                                  _currentSong
                                                                          ?.artist ??
                                                                      'Chapter 1',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                color: Colors
                                                                    .white,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite_border))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Slider(
                                              thumbColor: Colors.white,
                                              activeColor: Colors.amber,
                                              inactiveColor:
                                                  const Color.fromARGB(
                                                      31, 206, 198, 198),
                                              value: position.inMilliseconds
                                                  .toDouble(),
                                              min: 0.0,
                                              max: audioPlayer
                                                      .duration?.inMilliseconds
                                                      .toDouble() ??
                                                  0.0,
                                              onChanged: (value) {
                                                final newPosition = Duration(
                                                    milliseconds:
                                                        value.floor());
                                                audioPlayer.seek(newPosition);
                                              },
                                              onChangeEnd: (value) {
                                                final newPosition = Duration(
                                                    milliseconds:
                                                        value.floor());
                                                audioPlayer.seek(newPosition);
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    formatDuration(position),
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    formatDuration(
                                                        duration - position),
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                      size: 25,
                                                      CupertinoIcons
                                                          .gobackward_30),
                                                  onPressed: () {},
                                                  color: Colors.white,
                                                ),
                                                if (_isExpanded)
                                                  (IconButton(
                                                    icon: const Icon(
                                                      Icons.skip_previous,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {},
                                                    color: Colors.white,
                                                  )),
                                                IconButton(
                                                  icon: Icon(
                                                    _isPlaying
                                                        ? Icons.play_arrow
                                                        : Icons.pause,
                                                    size: 35,
                                                  ),
                                                  onPressed: () => _isPlaying
                                                      ? playAudio()
                                                      : pauseAudio(),
                                                  color: Colors.white,
                                                ),
                                                if (_isExpanded)
                                                  (IconButton(
                                                    icon: const Icon(
                                                      Icons.skip_next,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {},
                                                    color: Colors.white,
                                                  )),
                                                IconButton(
                                                  icon: const Icon(
                                                      size: 25,
                                                      CupertinoIcons
                                                          .goforward_15),
                                                  onPressed: () {
                                                    seekAudio();
                                                  },
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ]),
                        ),
                      ))
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _isExpanded = true;
                  //       appBarColor = kDarkBlue;
                  //       iconview = const Icon(Icons.view_list);
                  //     });
                  //   },
                  //   child: AnimatedContainer(
                  //     duration: const Duration(milliseconds: 600),
                  //     curve: Curves.linear,
                  //     width: double.infinity,
                  //     height: _isExpanded
                  //         ? MediaQuery.of(context).size.height - 56
                  //         : 100,
                  //     child: Container(
                  //       color: kDarkBlue,
                  //       padding: const EdgeInsets.all(0),
                  //       child:
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
// ,
//                   Expanded(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [

//                         ],
//                       ),

                  //     // Expanded(
                  //     //   child: Row(
                  //     //     mainAxisAlignment:
                  //     //         MainAxisAlignment.center,
                  //     //     crossAxisAlignment:
                  //     //         CrossAxisAlignment.start,
                  //     //     children: [
                  //     //       IconButton(
                  //     //         icon: const Icon(
                  //     //             CupertinoIcons.gobackward_15),
                  //     //         onPressed: () {},
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //       if (_isExpanded)
                  //     //         (IconButton(
                  //     //           icon: const Icon(
                  //     //               Icons.skip_previous),
                  //     //           onPressed: () {},
                  //     //           color: Colors.white,
                  //     //         )),
                  //     //       IconButton(
                  //     //         icon: Icon(
                  //     //           _isPlaying
                  //     //               ? Icons.play_arrow
                  //     //               : Icons.pause,
                  //     //         ),
                  //     //         onPressed: () => _isPlaying
                  //     //             ? playAudio()
                  //     //             : pauseAudio(),
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //       if (_isExpanded)
                  //     //         (IconButton(
                  //     //           icon: const Icon(Icons.skip_next),
                  //     //           onPressed: () {},
                  //     //           color: Colors.white,
                  //     //         )),
                  //     //       IconButton(
                  //     //         icon: const Icon(
                  //     //             CupertinoIcons.goforward_15),
                  //     //         onPressed: () {
                  //     //           seekAudio();
                  //     //         },
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //     ],
                  //     //   ),
                  //     // ),
                  //   ],
                  // )),
                ],
              ),

              // ),
              // ),
              // ),
              // ],
              // ),
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
    // links: 'assets/audiobooks/1.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_01_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 2',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/3.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_02_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 3',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/4.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_03_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 4',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/5.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_04_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 5',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/6.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_05_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 6',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/6.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_06_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 7',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/2.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_07_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 8',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/2.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_08_fitzgerald_64kb.mp3',
  ),
  Song(
    title: 'ላስብበት',
    artist: 'Chapter 9',
    albumCover: 'assets/books/ላስብበት.jpg',
    // links: 'assets/audiobooks/2.mp3',
    links:
        'https://www.archive.org/download/this_side_paradise_librivox/thissideofparadise_09_fitzgerald_64kb.mp3',
  ),
];
