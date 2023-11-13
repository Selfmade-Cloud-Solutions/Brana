import 'dart:convert';
import 'package:brana_mobile/book_detail.dart';
import 'package:brana_mobile/pages/explore/swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({Key? key}) : super(key: key);

  @override
  State<LatestPage> createState() => _AudiobookListState();
}

class _AudiobookListState extends State<LatestPage> {
  late List<dynamic> audiobooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retreive_audiobook_genre?audiobook_genre=Children'));
    if (response.statusCode == 200) {
      setState(() {
        audiobooks = jsonDecode(response.body)['message'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: branaDeepBlack,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: branaWhite,
          ),
          flexibleSpace: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Latest Release",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  height: 1,
                  color: branaWhite,
                ),
              ),
            ],
          )),
        ),
        body: Column(children: [
          const LatestTop(),
          const SizedBox(height: 5),
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 50),
            itemCount: audiobooks.length,
            itemBuilder: (context, index) {
              final audiobook = audiobooks[index];
              return AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetail(
                              title: audiobook['title'] ?? '',
                              author: audiobook['author'] ?? '',
                              description: audiobook['description'] ?? '',
                              thumbnail: audiobook['thumbnail'] ?? '',
                              narrator:audiobook['narrator'],
                      is_favorite:audiobook['is_favorite'] ?? '',
                      // chapters: audiobook['chapters'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        color: kLightBlue.withOpacity(0.1),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: audiobook['thumbnail'] != null
                                  ? CachedNetworkImage(
                                      imageUrl: audiobook['thumbnail'],
                                      width: containerWidth * 0.7,
                                      height: containerWidth * 0.7)
                                  : const SizedBox.shrink(),
                            ),
                            Flexible(
                                child: Text(
                              audiobook['title'] ?? '',
                              style: GoogleFonts.jost(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: branaGrey,
                              ),
                            )),
                            Flexible(
                                child: Text(
                              audiobook['author'] ?? '',
                              style: GoogleFonts.jost(
                                fontSize: 14,
                                color: branaWhite,
                              ),
                            )),
                          ],
                        ),
                      )));
            },
          ))
        ]));
  }
}
