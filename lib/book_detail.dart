// ignore_for_file: non_constant_identifier_names

import 'package:brana_mobile/audioplayerscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/constants.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnail,
    required this.narrator,
    required this.is_favorite,
    // required this.chapters,
  }) : super(key: key);

  final String title;
  final String author;
  final String description;
  final String thumbnail;
  final String narrator;
  final dynamic is_favorite;
  // final String chapters;

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Map<String, dynamic> audiobook = {};
  bool showFullDescription = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl =
        'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobook?audiobook_id=${widget.title}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        audiobook = jsonDecode(response.body)['message'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  

  String truncateDescription(String description) {
    int numChars = 120; // 4 lines * 40 characters per line

    if (description.length <= numChars) {
      return description;
    }

    return '${description.substring(0, numChars)}...';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int? favorite;
  
  if (widget.is_favorite is int) {
    favorite = widget.is_favorite as int;
  } else {
    favorite = int.tryParse(widget.is_favorite) ?? 0;
  }
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
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: NetworkImage(widget.thumbnail),
              fit: BoxFit.cover,
            )),
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
            isLoading
                ? const Center(
                    // Display the preloader if isLoading is true
                    child: CircularProgressIndicator(color: branaWhite),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 110, right: 16, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: widget.thumbnail,
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
                                )),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: GoogleFonts.jost(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color: branaWhite, // Use branaWhite
                                    ),
                                  ),
                                ],
                              ),
                              // Parsing to integer

// Check the parsed integer value against 1
(favorite == 1)
  ? IconButton(
      color: branaWhite,
      icon: const Icon(Icons.favorite, size: 30),
      onPressed: () {},
    )
  : IconButton(
      color: branaWhite,
      icon: const Icon(Icons.favorite_border, size: 30),
      onPressed: () {},
                            )
                        ]),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    "Author",
                                    style: GoogleFonts.jost(
                                      fontSize: 18,
                                      height: 1,
                                      color: branaWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.author,
                                    style: GoogleFonts.jost(
                                      fontSize: 18,
                                      height: 1,
                                      color: branaWhite,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: branaWhite,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Narrator",
                                    style: GoogleFonts.jost(
                                      fontSize: 18,
                                      height: 1,
                                      color: branaWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.narrator,
                                    style: GoogleFonts.jost(
                                      fontSize: 18,
                                      height: 1,
                                      color: branaWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            showFullDescription
                                ? widget.description
                                : truncateDescription(widget.description),
                            style: GoogleFonts.jost(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: branaWhite,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showFullDescription = !showFullDescription;
                              });
                            },
                            child: Center(
                              child: Text(
                                  showFullDescription
                                      ? 'Read Less'
                                      : 'Read More',
                                  style: const TextStyle(
                                    color:
                                        branaWhite, // Customize the color if desired
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 20),
                    textStyle: GoogleFonts.jost(fontSize: 16),
                    foregroundColor: branaWhite,
                    backgroundColor: const Color.fromARGB(255, 2, 22, 41),
                    shadowColor: branaDeepBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioPlayerScreen(
                        book: audiobook['title'],
                        // title: audiobook['title'] ?? '',
                        // author: audiobook['author'] ?? '',
                        // description: audiobook['description'] ?? '',
                        // thumbnail: audiobook['thumbnail'] ?? '',
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
