import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:brana_mobile/audioplayer.dart';
import 'package:brana_mobile/data.dart';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AudioPlayerScreen extends StatefulWidget {
  final Book book;
  const AudioPlayerScreen({super.key, required this.book});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _AudioPlayerScreenState(book);
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

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with WidgetsBindingObserver {
  var logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  bool _isExpanded = true;
  final _audioPlayer = AudioPlayer();
  Book book;
  _AudioPlayerScreenState(this.book);
  final _playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [
      // ClippingAudioSource(
      //   start: const Duration(seconds: 60),
      //   end: const Duration(seconds: 90),
      //   child:
      AudioSource.uri(
        Uri.parse(
            // 'asset:/assets/audiobooks/6.mp3'
            "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.play_audiobook_chapter?audiobook_chapter=ሚፈልግ ሰው"),
        tag: MediaItem(
          id: '1',
          album: "ላስብበት",
          title: 'Chapter 1',
          artist: 'ሮማን አፈወርቅ',
          artUri: Uri.parse(
              'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9'),
        ),
      ),
      // ),
      AudioSource.uri(
        Uri.parse(
            // 'asset:/assets/audiobooks/4.mp3'
            "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
        tag: MediaItem(
          id: '2',
          album: "ላስብበት",
          title: "Chapter 2",
          artist: 'ሮማን አፈወርቅ',
          artUri: Uri.parse(
              "https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9"),
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            // 'asset:/assets/audiobooks/3.mp3'
            "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
        tag: MediaItem(
          id: '3',
          album: "ላስብበት",
          title: "Chapter 3",
          artist: 'ሮማን አፈወርቅ',
          artUri: Uri.parse(
              // 'asset:/assets/books/ላስብበት.jpg'
              "https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9"),
        ),
      ),
    ],
  );

  Future<void> _init() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    Navigator.of(context).pop();
    // await DefaultCacheManager().emptyCache();
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      logger.e('A stream error occurred: $e');
    });
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _audioPlayer.setAudioSource(_playlist);
      await _audioPlayer.setLoopMode(LoopMode.all);
    } catch (e, stackTrace) {
      logger.e("Error loading audio source: $e");
      logger.e(stackTrace);
    }
    // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();
  }

  Stream<AudioPosition> get _audioPositionStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, AudioPosition>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => AudioPosition(
                position,
                bufferedPosition,
                duration ?? Duration.zero,
              ));
  void fetchData() async {
    var url =
        'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobooks';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: _isExpanded ? Colors.transparent : branaWhite,
          elevation: 0,
          // leadingWidth: 600,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: _isExpanded
                  ? branaWhite
                  : const Color.fromARGB(255, 2, 22, 41),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(book.title,
                  style: GoogleFonts.jost(
                    color: _isExpanded
                        ? branaWhite
                        : const Color.fromARGB(255, 2, 22, 41),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  )),
              Text(book.author.fullname,
                  style: GoogleFonts.jost(
                    color: _isExpanded
                        ? branaWhite
                        : const Color.fromARGB(255, 2, 22, 41),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ))
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  size: 30,
                  Icons.view_comfortable_rounded,
                  color: _isExpanded
                      ? branaWhite
                      : const Color.fromARGB(255, 2, 22, 41),
                ))
          ],
        ),
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
                        backgroundImage: AssetImage(book.image),
                      ),
                      title: Text(
                        song.artist,
                        style: GoogleFonts.jost(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 2, 22, 41),
                        ),
                      ),
                      subtitle: Text(book.title),
                      trailing: Text(song.duration),
                      onTap: () async {
                        // _selectSong(song);
                        // // init(index);
                        // audioPlayer.stop();
                      },
                    );
                  },
                ),
              )),
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.linearToEaseOut,
              width: double.infinity,
              height: _isExpanded ? MediaQuery.of(context).size.height : 132,
              child: Container(
                // alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 12, 53, 88),
                        Color.fromARGB(255, 2, 22, 41)
                      ]),
                  image: DecorationImage(
                    opacity: 0.06,
                    image: AssetImage(book.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isExpanded) const SizedBox(height: 25),
                    if (_isExpanded)
                      StreamBuilder<SequenceState?>(
                          stream: _audioPlayer.sequenceStateStream,
                          builder: (context, snapshot) {
                            final state = snapshot.data;
                            if (state?.sequence.isEmpty ?? true) {
                              return const SizedBox();
                            }
                            final metadata =
                                state!.currentSource!.tag as MediaItem;
                            // return const SizedBox(height: 10);
                            return MediaMetadata(
                              imageurl: metadata.artUri.toString(),
                              artist: metadata.artist ?? '',
                              title: metadata.title,
                            );
                          }),
                    StreamBuilder<AudioPosition>(
                      stream: _audioPositionStream,
                      builder: (context, snapshot) {
                        final Audioposition = snapshot.data;
                        return Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ProgressBar(
                                  barHeight: 6,
                                  baseBarColor: Colors.grey[300],
                                  bufferedBarColor: Colors.grey,
                                  progressBarColor: Colors.yellow,
                                  thumbColor: Colors.yellow,
                                  timeLabelTextStyle: GoogleFonts.jost(
                                    color: branaWhite,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  timeLabelType: TimeLabelType.remainingTime,
                                  progress:
                                      Audioposition?.position ?? Duration.zero,
                                  total:
                                      Audioposition?.duration ?? Duration.zero,
                                  buffered: Audioposition?.bufferedPosition ??
                                      Duration.zero,
                                  onSeek: _audioPlayer.seek,
                                ),
                              ),
                              if (_isExpanded) const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isExpanded)
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.seekToPrevious();
                                        },
                                        iconSize: 30,
                                        color: branaWhite,
                                        icon: const Icon(
                                            Icons.skip_previous_rounded)),
                                  IconButton(
                                      onPressed: () async {
                                        await _audioPlayer.seek(Duration(
                                            seconds: _audioPlayer
                                                    .position.inSeconds -
                                                15));
                                      },
                                      iconSize: _isExpanded ? 35 : 30,
                                      color: branaWhite,
                                      icon: const Icon(
                                          CupertinoIcons.gobackward_15)),
                                  StreamBuilder<PlayerState>(
                                    stream: _audioPlayer.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final processingState =
                                          playerState?.processingState;
                                      final playing = playerState?.playing;
                                      if (!(playing ?? false)) {
                                        return IconButton(
                                            onPressed: () {
                                              _audioPlayer.play();
                                            },
                                            iconSize: _isExpanded ? 80 : 40,
                                            color: Colors.yellow,
                                            icon: const Icon(
                                                Icons.play_arrow_sharp));
                                      } else if (processingState !=
                                          ProcessingState.completed) {
                                        return IconButton(
                                            onPressed: () {
                                              _audioPlayer.pause();
                                            },
                                            iconSize: _isExpanded ? 80 : 40,
                                            color: Colors.yellow,
                                            icon:
                                                const Icon(Icons.pause_sharp));
                                      }
                                      return Icon(
                                        Icons.play_arrow_sharp,
                                        color: Colors.yellow,
                                        size: _isExpanded ? 80 : 40,
                                      );
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await _audioPlayer.seek(Duration(
                                            seconds: _audioPlayer
                                                    .position.inSeconds +
                                                15));
                                      },
                                      iconSize: _isExpanded ? 35 : 30,
                                      color: branaWhite,
                                      icon: const Icon(
                                          CupertinoIcons.goforward_15)),
                                  if (_isExpanded)
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.seekToNext();
                                        },
                                        iconSize: 30,
                                        color: branaWhite,
                                        icon:
                                            const Icon(Icons.skip_next_rounded))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class MediaMetadata extends StatelessWidget {
  const MediaMetadata({
    super.key,
    required this.imageurl,
    required this.title,
    // required this.subtitle,
    required this.artist,
    // required this.album,
    // required this.albumart,
  });
  final String imageurl;
  final String title;
  final String artist;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        DecoratedBox(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(2, 4), blurRadius: 4)
          ], borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: imageurl,
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                // width: 300,
                child: SizedBox(
                  // flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.jost(
                            color: branaWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.left,
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        artist,
                        style: GoogleFonts.jost(
                            color: branaWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  color: Colors.yellow,
                  icon: const Icon(Icons.bookmark_add_outlined))
            ],
          ),
        )
      ],
    );
  }
}

// class Controls extends StatelessWidget {
//   const Controls({super.key, required this.audioPlayer});
//   final AudioPlayer audioPlayer;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//             onPressed: () async {
//               await audioPlayer.seekToPrevious();
//             },
//             iconSize: 30,
//             color: branaWhite,
//             icon: const Icon(Icons.skip_previous_rounded)),
//         IconButton(
//             onPressed: () async {
//               await audioPlayer
//                   .seek(Duration(seconds: audioPlayer.position.inSeconds - 15));
//             },
//             iconSize: 35,
//             color: branaWhite,
//             icon: const Icon(CupertinoIcons.gobackward_15)),
//         StreamBuilder<PlayerState>(
//           stream: audioPlayer.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (!(playing ?? false)) {
//               return IconButton(
//                   onPressed: () {
//                     audioPlayer.play();
//                   },
//                   iconSize: 80,
//                   color: Colors.yellow,
//                   icon: const Icon(Icons.play_arrow_sharp));
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                   onPressed: () {
//                     audioPlayer.pause();
//                   },
//                   iconSize: 80,
//                   color: Colors.yellow,
//                   icon: const Icon(Icons.pause_sharp));
//             }
//             return const Icon(
//               Icons.play_arrow_sharp,
//               color: Colors.yellow,
//               size: 80,
//             );
//           },
//         ),
//         IconButton(
//             onPressed: () async {
//               await audioPlayer
//                   .seek(Duration(seconds: audioPlayer.position.inSeconds + 15));
//             },
//             iconSize: 35,
//             color: branaWhite,
//             icon: const Icon(CupertinoIcons.goforward_15)),
//         IconButton(
//             onPressed: () async {
//               await audioPlayer.seekToNext();
//             },
//             iconSize: 30,
//             color: branaWhite,
//             icon: const Icon(Icons.skip_next_rounded))
//       ],
//     );
//   }
// }

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
