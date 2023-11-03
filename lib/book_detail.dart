import 'package:brana_mobile/audioplayerscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  const BookDetail({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Map<String, dynamic> audiobook = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl = 'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobook?audiobook_id=${widget.title}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        audiobook = jsonDecode(response.body)['message'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ScrollController scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(0);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 2, 22, 41),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(audiobook['thumbnail'] ?? ''),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromARGB(255, 31, 28, 28).withOpacity(1),
                    const Color.fromARGB(159, 224, 218, 218).withOpacity(0.7),
                  ],
                ),
              ),
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification.metrics.pixels < -1000) {
                  scrollController.jumpTo(-1000);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, bottom: 110, right: 16, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 0),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.9),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  audiobook['thumbnail'] != null
                      ?Image.network(
                              audiobook['thumbnail'] ?? '',
                              fit: BoxFit.cover,
                            ): const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                audiobook['title'] ?? '',
                                style: GoogleFonts.jost(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white, // Use Colors.white
                                ),
                              ),
                              Text(
                                audiobook['author'] ?? '',
                                style: GoogleFonts.jost(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white, // Use Colors.white
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            color: Colors.white, // Use Colors.white
                            icon: const Icon(Icons.bookmark_add, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Text(
                        audiobook['description'] ?? '',
                        style: GoogleFonts.jost(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white, // Use Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 200,
                width: size.width,
                padding: EdgeInsets.only(
                  top: 110,
                  left: MediaQuery.of(context).size.width * 0.55,
                  right: MediaQuery.of(context).size.width * 0.05,
                  bottom: 30,
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 20),
                    textStyle: GoogleFonts.jost(fontSize: 16),
                    foregroundColor: Colors.white, // Use Colors.white
                    backgroundColor: const Color.fromARGB(255, 2, 22, 41),
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                  builder: (context) => BookDetail(
                    title: audiobook['title'] ?? '',
                  ),
                ),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, size: 30),
                  label: const Text('Listen'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
