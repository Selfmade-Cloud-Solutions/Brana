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
import 'dart:convert';

class AudioPlayerScreen extends StatefulWidget {
  // final Book book;
  // required this.book
  const AudioPlayerScreen({super.key});

  @override
  // ignore: no_logic_in_create_state
  // book as argument
  State<StatefulWidget> createState() => _AudioPlayerScreenState();
}

Audiobook? audiobook;

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

class Audiobook {
  final String booktitle;
  final String author;
  final String thumbnail;
  final String sampletitle;
  final String duration;
  final List<Chapter> chapters;

  Audiobook(
      {required this.booktitle,
      required this.author,
      required this.thumbnail,
      required this.sampletitle,
      required this.duration,
      required this.chapters});
}

class Chapter {
  final String title;
  final String duration;
  Chapter({required this.title, required this.duration});
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

  Stream<AudioPosition> get _audioPositionStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, AudioPosition>(
          _audioPlayer.positionStream.handleError((error) {
        logger.e('Position stream error: $error');
      }), _audioPlayer.bufferedPositionStream.handleError((error) {
        logger.e('Buffered position stream error: $error');
      }), _audioPlayer.durationStream.handleError((error) {
        logger.e('Duration stream error: $error');
      }),
          (position, bufferedPosition, duration) => AudioPosition(
                position,
                bufferedPosition,
                duration ?? Duration.zero,
              ));
  late final ConcatenatingAudioSource _playlist;
    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _audioPlayer.stop();
    }
  }
  
    void _selectSong(Audiobook audiobook) {
    setState(() {
      audiobook = audiobook;
      // _isPlaying = false;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        audiobook = value;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _init();
        });
      });
    }).catchError((error) {
      logger.e('Error fetching data: $error');
    });
  }

  Future<Audiobook> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobook?audiobook_id=ባርቾ'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List<Chapter> chapters = [];
        for (var chapterData in responseData['message']['chapters']) {
          Chapter chapter = Chapter(
            title: chapterData['title'] ?? "nulll",
            duration: chapterData['duration'] ?? "nulll",
          );
          chapters.add(chapter);
        }
        Audiobook audiobook = Audiobook(
          booktitle: responseData['message']['title'] ?? "null",
          author: responseData['message']['author'] ?? "null",
          thumbnail: responseData['message']['thumbnail'] ?? "null",
          sampletitle:
              responseData['message']['Sample Audiobook Title'] ?? "nulll",
          duration: responseData['message']['duration'] ?? "nulll",
          chapters: chapters,
        );

        logger.i(responseData['message']);

        return audiobook;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      logger.e('error fetching data: $error');
      rethrow;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return const Center(child: CircularProgressIndicator());
    //     });
    // Navigator.of(context).pop();
    // await DefaultCacheManager().emptyCache();
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: [
          AudioSource.uri(
              Uri.parse(
                  "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.audiobook_sample?audiobook_id=ከአድማስ ባሻገር"),
              tag: MediaItem(
                id: audiobook!.booktitle,
                album: audiobook!.booktitle,
                title: audiobook!.booktitle,
                artist: audiobook!.sampletitle,
                artUri: Uri.parse(audiobook!.thumbnail),
              )),
          for (var chapter in audiobook!.chapters)
            AudioSource.uri(
              Uri.parse(
                  "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.audiobook_sample?audiobook_id=መተዋወቂያ"),
              tag: MediaItem(
                id: chapter.title,
                album: audiobook!.booktitle,
                title: chapter.title,
                artist: audiobook!.sampletitle,
                artUri: Uri.parse(audiobook!.thumbnail),
              ),
            ),
        ]);
    _audioPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        logger.e('completed ${event.bufferedPosition}');
      }else{
        // logger.e('playback error ${event.currentIndex}');
      }
      // else if (event.processingState == ProcessingState.idle) {
      //   logger.e('playback error ${event.bufferedPosition}');
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: const Text('Playback Error'),
      //         content: const Text('An error occurred while playing the audio.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               _audioPlayer.stop();
      //               Navigator.of(context).pop();
      //             },
      //             child: const Text('OK'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
    }, onError: (Object e, StackTrace stackTrace) {
      logger.e('A stream error occurred: $e');
    });
    try {
      await _audioPlayer.setAudioSource(_playlist);
      await _audioPlayer.setLoopMode(LoopMode.all);
    } catch (e, stackTrace) {
      logger.e("Error loading audio source: $e");
      logger.e(stackTrace);
    }
    // ignore: use_build_context_synchronously
    // Navigator.of(context).pop();
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
              Text(audiobook!.booktitle,
                  style: GoogleFonts.jost(
                    color: _isExpanded
                        ? branaWhite
                        : const Color.fromARGB(255, 2, 22, 41),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  )),
              Text(audiobook!.author,
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
                itemCount: audiobook!.chapters.length + 1,
                itemBuilder: (context, index) {
                  final currentAudiobook = audiobook!;[index];
                  if (index == 0) {
                    return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 1.0),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/authors/ዘነበወላ.jpg'),
                        ),
                        title: Text(
                          audiobook!.sampletitle,
                          style: GoogleFonts.jost(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 2, 22, 41),
                          ),
                        ),
                        subtitle: const Text("Sample Audiobook"),
                        trailing: Text(audiobook!.duration),
                        onTap: () async {
                          _selectSong(currentAudiobook);
                          // // init(index);
                          // audioPlayer.stop();
                        });
                  } else {
                    Chapter chapter = audiobook!.chapters[index - 1];
                    return ListTile(
                        title: Text(chapter.title),
                        subtitle: Text('Chapter $index'),
                        trailing: Text(chapter.duration),
                        onTap: () async {
                          // _selectSong(song);
                          // // init(index);
                          // audioPlayer.stop();
                        });
                  }
                },
              ))),
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
                    image: AssetImage('assets/authors/ዘነበወላ.jpg'),
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
                              if (_isExpanded) const SizedBox(height: 10),
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
