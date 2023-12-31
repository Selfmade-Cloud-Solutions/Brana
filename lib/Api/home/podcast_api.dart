import 'dart:convert';

import 'package:brana_mobile/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';

class PodcastList extends StatefulWidget {
  const PodcastList({Key? key}) : super(key: key);

  @override
  State<PodcastList> createState() => _AudiobookListState();
}

class _AudiobookListState extends State<PodcastList> {
  late List<dynamic> audiobooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.podcast_api.retrieve_recommended_podcasts'));
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: audiobooks.length,
      itemBuilder: (context, index) {
        final audiobook = audiobooks[index];
        return ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
                      is_favorite:audiobook['is_favorite'] ?? '',
                      narrator:'',
                      // chapters: audiobook['episodes'],
                      
                    ),
                  ),
                );
              },
              child: Container(
                width: 140,
                height: 50,
                margin: const EdgeInsets.only(right: 5, left: 5),
                color: kLightBlue.withOpacity(0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: audiobook['cover image'] != null
                          ? CachedNetworkImage(
                              imageUrl: audiobook['cover image'],
                              width: 120,
                              height: 120,
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      audiobook['title'] ?? '',
                      style: GoogleFonts.jost(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: branaGrey,
                      ),
                    ),
                    Text(
                      audiobook['Host'] ?? '',
                      style: GoogleFonts.jost(
                        fontSize: 12,
                        color: branaWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
