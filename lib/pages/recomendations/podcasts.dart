import 'dart:convert';
import 'package:brana_mobile/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';

class Podcast extends StatefulWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  State<Podcast> createState() => _PodcastListState();
}

class _PodcastListState extends State<Podcast> {
  late List<dynamic> audiobooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.podcast_api.retrieve_podcasts'));
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
                "Podcasts",
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
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10),
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
                            author: audiobook['Host'] ?? '',
                            description: audiobook['description'] ?? '',
                            thumbnail: audiobook['cover image'] ?? '',
                            narrator: '',
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
                            child: audiobook['cover image'] != null
                                ? CachedNetworkImage(
                                    imageUrl: audiobook['cover image'],
                                    width: containerWidth * 1.2,
                                    height: containerWidth * 1.2)
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
                            audiobook['Host'] ?? '',
                            style: GoogleFonts.jost(
                              fontSize: 14,
                              color: branaWhite,
                            ),
                          )),
                        ],
                      ),
                    )));
          },
        ));
  }
}
